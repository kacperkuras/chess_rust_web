use sqlx::MySqlPool;

pub async fn add_chat_message(pool: &MySqlPool, game_id: i32, sender_id: i32, message: &str) -> Result<(), sqlx::Error> {
    sqlx::query!(
        "INSERT INTO chat_messages (game_id, sender_id, message) VALUES (?, ?, ?)",
        game_id,
        sender_id,
        message,
    )
    .execute(pool)
    .await?;

    Ok(())
}