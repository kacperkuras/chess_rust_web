use sqlx::MySqlPool;
use chrono::Utc;

use crate::game::GameStatus;
use crate::models::GameSummary;

pub async fn create_game(pool: &MySqlPool, white_player_id: i32, black_player_id: i32, white_player_elo: i32, black_player_elo: i32) -> Result<i32, sqlx::Error> {
    let mut conn = pool.acquire().await?;
    let result = sqlx::query!(
        "INSERT INTO games (white_player_id, black_player_id, white_player_initial_elo, black_player_initial_elo) VALUES (?, ?, ?, ?)",
        white_player_id,
        black_player_id,
        white_player_elo,
        black_player_elo
    )
    .execute(&mut *conn)
    .await?;

    Ok(result.last_insert_id() as i32)
}

pub async fn add_move_to_game(pool: &MySqlPool, game_id: i32, player_color: &str, move_number: i32, pgn_move: &str) -> Result<(), sqlx::Error> {
    sqlx::query!(
        "INSERT INTO moves (game_id, player_color, move_number, pgn_move) VALUES (?, ?, ?, ?)",
        game_id,
        player_color,
        move_number,
        pgn_move
    )
    .execute(pool)
    .await?;

    Ok(())
}



pub async fn end_game(pool: &MySqlPool, game_id: i32, result: &GameStatus) -> Result<(), sqlx::Error> {
    sqlx::query!(
        "UPDATE games SET status = 'finished', result = ?, ended_at = ? WHERE id = ?",
        result.as_str(),
        Utc::now(),
        game_id
    )
    .execute(pool)
    .await?;

    Ok(())
}

pub async fn get_games_for_player(pool: &MySqlPool, player_id: i32) -> Result<Vec<GameSummary>, sqlx::Error> {
    let games = sqlx::query_as!(
    GameSummary,
    r#"
    SELECT
        CAST(g.id AS SIGNED) AS game_id,
        g.game_type,
        CASE
            WHEN g.white_player_id = ? THEN 'white'
            ELSE 'black'
        END AS player_color,
        u.username AS username,
        CASE
            WHEN g.white_player_id = ? THEN g.white_player_initial_elo
            ELSE g.black_player_initial_elo
        END AS elo,
        ou.username AS opponent_username,
        CASE
            WHEN g.white_player_id = ? THEN g.black_player_initial_elo
            ELSE g.white_player_initial_elo
        END AS opponent_elo,
        (
            SELECT COUNT(*) FROM moves m WHERE m.game_id = g.id
        ) AS move_count,
        CASE
            WHEN TIMESTAMPDIFF(SECOND, g.started_at, g.ended_at) >= 3600 THEN
                CONCAT(
                    FLOOR(TIMESTAMPDIFF(SECOND, g.started_at, g.ended_at) / 3600), 'h ',
                    FLOOR((TIMESTAMPDIFF(SECOND, g.started_at, g.ended_at) % 3600) / 60), 'm ',
                    TIMESTAMPDIFF(SECOND, g.started_at, g.ended_at) % 60, 's'
                )
            WHEN TIMESTAMPDIFF(SECOND, g.started_at, g.ended_at) >= 60 THEN
                CONCAT(
                    FLOOR(TIMESTAMPDIFF(SECOND, g.started_at, g.ended_at) / 60), 'm ',
                    TIMESTAMPDIFF(SECOND, g.started_at, g.ended_at) % 60, 's'
                )
            ELSE
                CONCAT(
                    TIMESTAMPDIFF(SECOND, g.started_at, g.ended_at), 's'
                )
        END AS duration,
        g.started_at,
        CASE
            WHEN g.result = 'draw' THEN 'draw'
            WHEN (g.result = 'white_win' AND g.white_player_id = ?) OR
                 (g.result = 'black_win' AND g.black_player_id = ?) THEN 'win'
            ELSE 'lose'
        END AS result
    FROM games g
    JOIN users u ON u.id = ?
    JOIN users ou ON (
        ou.id = CASE
            WHEN g.white_player_id = ? THEN g.black_player_id
            ELSE g.white_player_id
        END
    )
    WHERE (g.white_player_id = ? OR g.black_player_id = ?)
      AND g.status = 'finished'
    ORDER BY g.started_at DESC
    "#,
    player_id,
    player_id,
    player_id,
    player_id,
    player_id,
    player_id,
    player_id,
    player_id,
    player_id
)
.fetch_all(pool)
.await?;

    Ok(games)
}
