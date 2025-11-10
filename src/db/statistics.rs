use sqlx::MySqlPool;
use chrono::Utc;

use crate::models::models::{User, UserStatistics};
use crate::db::users::get_user_by_email;
use crate::game::game::{GameStatus, calculate_elo_changes};

pub async fn create_statistics_for_user(pool: &MySqlPool, elo:i32, email: &str) -> Result<bool, sqlx::Error> {
    let user: Option<User> = get_user_by_email(&pool, &email).await?;
    let _result = sqlx::query!(
        "INSERT INTO statistics (user_id, elo, max_elo) VALUES (?, ?, ?)",
        user.unwrap().id,
        elo,
        elo
    )
    .execute(pool)
    .await?;

    Ok(true)
}


pub async fn get_user_statistics(pool: &MySqlPool, user_id: i32) -> Result<Option<UserStatistics>, sqlx::Error> {
    let stats = sqlx::query_as!(
        UserStatistics,
        "SELECT * FROM statistics WHERE user_id = ?",
        user_id
    )
    .fetch_optional(pool)
    .await?;

    Ok(stats)
}



pub async fn update_user_statistics_win(pool: &MySqlPool, winner_id: i32, winner_elo_change: i32) -> Result<(), sqlx::Error> {
    sqlx::query!(
        "UPDATE statistics SET games_played = games_played + 1, games_won = games_won + 1, current_win_streak = current_win_streak + 1,
        max_win_streak = CASE
            WHEN current_win_streak > max_win_streak THEN current_win_streak
            ELSE max_win_streak
        END,
        elo = CASE
            WHEN elo + ? < 100 THEN 100
            ELSE elo + ?
        END,
        max_elo = CASE
            WHEN elo > max_elo THEN elo 
            ELSE max_elo
        END,
        last_game_at = ? WHERE user_id = ?",
        winner_elo_change,
        winner_elo_change,
        Utc::now(),
        winner_id
    )
    .execute(pool)
    .await?;

    Ok(())
}

pub async fn update_user_statistics_lose(pool: &MySqlPool, loser_id: i32, loser_elo_change: i32) -> Result<(), sqlx::Error> {
    sqlx::query!(
        "UPDATE statistics SET games_played = games_played + 1, games_lost = games_lost + 1, current_win_streak = 0,
        elo = CASE
            WHEN elo + ? < 100 THEN 100
            ELSE elo + ?
        END,
        max_elo = CASE
            WHEN elo > max_elo THEN elo 
            ELSE max_elo
        END,
        last_game_at = ? WHERE user_id = ?",
        loser_elo_change,
        loser_elo_change,
        Utc::now(),
        loser_id
    )
    .execute(pool)
    .await?;

    Ok(())
}

pub async fn update_user_statistics_draw(pool: &MySqlPool, white_player_id: i32, black_player_id: i32, white_elo_change: i32, black_elo_change: i32) -> Result<(), sqlx::Error> {
    sqlx::query!(
        "UPDATE statistics SET games_played = games_played + 1, games_drawn = games_drawn + 1, current_win_streak = 0,
        elo = CASE
            WHEN elo + ? < 100 THEN 100
            ELSE elo + ?
        END,
        max_elo = CASE
            WHEN elo > max_elo THEN elo 
            ELSE max_elo
        END,
        last_game_at = ? WHERE user_id = ?",
        white_elo_change,
        white_elo_change,
        Utc::now(),
        white_player_id
    )
    .execute(pool)
    .await?;

    sqlx::query!(
        "UPDATE statistics SET games_played = games_played + 1, games_drawn = games_drawn + 1, current_win_streak = 0,
        elo = CASE
            WHEN elo + ? < 100 THEN 100
            ELSE elo + ?
        END,
        max_elo = CASE
            WHEN elo > max_elo THEN elo 
            ELSE max_elo
        END,
        last_game_at = ? WHERE user_id = ?",
        black_elo_change,
        black_elo_change,
        Utc::now(),
        black_player_id
    )
    .execute(pool)
    .await?;

    Ok(())
}


pub async fn update_users_statistics(pool: &MySqlPool, white_player_id: i32, black_player_id: i32, result: &GameStatus) -> Result<(), sqlx::Error> {
    
    let white_stats = get_user_statistics(pool, white_player_id).await?;
    let black_stats = get_user_statistics(pool, black_player_id).await?;

    let white_elo = white_stats.unwrap().elo;
    let black_elo = black_stats.unwrap().elo;

    let (white_elo_change, black_elo_change) = calculate_elo_changes(white_elo, black_elo, result);
    match result {
        GameStatus::WhiteWin => {
            update_user_statistics_win(pool, white_player_id, white_elo_change).await?;
            update_user_statistics_lose(pool, black_player_id, black_elo_change).await?;
        },
        GameStatus::BlackWin => {
            update_user_statistics_win(pool, black_player_id, black_elo_change).await?;
            update_user_statistics_lose(pool, white_player_id, white_elo_change).await?;
        },
        GameStatus::Draw => {
           update_user_statistics_draw(pool, white_player_id, black_player_id, white_elo_change, black_elo_change).await?;
        },
        _ => {}
    }
    

    Ok(())
}