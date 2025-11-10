use sqlx::MySqlPool;

use crate::models::models::{User, RegisterUser, LoginUser};
use crate::db::statistics::create_statistics_for_user;

pub enum CreateUserError {
    UsernameExists,
    EmailExists,
    DatabaseError(sqlx::Error),
}

impl From<sqlx::Error> for CreateUserError {
    fn from(e: sqlx::Error) -> Self {
        CreateUserError::DatabaseError(e)
    }
}

pub enum LoginUserError {
    UserDoesNotExist,
    UserBanned,
    UserSuspended,
    DatabaseError(sqlx::Error),
}

impl From<sqlx::Error> for LoginUserError {
    fn from(e: sqlx::Error) -> Self {
        LoginUserError::DatabaseError(e)
    }
}


pub async fn create_user(pool: &MySqlPool, user: &RegisterUser) -> Result<bool, CreateUserError> {
    let email_exists = sqlx::query!(
        "SELECT * FROM users WHERE email = ?",
        user.email
    )
    .fetch_optional(pool)
    .await?;

    if email_exists.is_some() {
        return Err(CreateUserError::EmailExists);
    }

    let username_exists = sqlx::query!(
        "SELECT * FROM users WHERE username = ?",
        user.username
    )
    .fetch_optional(pool)
    .await?;

    if username_exists.is_some() {
        return Err(CreateUserError::UsernameExists);
    }

    let _result = sqlx::query!(
        "INSERT INTO users (username, email, password_hash) VALUES (?, ?, ?)",
        user.username,
        user.email,
        user.password,
    )
    .execute(pool)
    .await?;
    match create_statistics_for_user(&pool, user.elo, &user.email).await {
        Ok(_) => {Ok(true)},
        Err(_) => {return Err(CreateUserError::DatabaseError(sqlx::Error::RowNotFound));}
    }
}


pub async fn get_user_by_id(pool: &MySqlPool, user_id: i32) -> Result<Option<User>, sqlx::Error> {
    let user = sqlx::query_as!(
        User,
        "SELECT * FROM users WHERE id = ?",
        user_id
    )
    .fetch_optional(pool)
    .await?;

    Ok(user)
}

pub async fn get_user_by_email(pool: &MySqlPool, email: &str) -> Result<Option<User>, sqlx::Error> {
    let user = sqlx::query_as!(
        User,
        "SELECT * FROM users WHERE email = ?",
        email
    )
    .fetch_optional(pool)
    .await?;

    Ok(user)
}


pub async fn login_user(pool: &MySqlPool, user: &LoginUser) -> Result<User, LoginUserError> {

    let user: Option<User> = get_user_by_email(pool, &user.email).await?;
    if user.is_none() {
        return Err(LoginUserError::UserDoesNotExist);
    }

    if let Some(user) = user {
        if user.status == "banned" {
            return Err(LoginUserError::UserBanned);
        } else if user.status == "suspended" {
            return Err(LoginUserError::UserSuspended);
        } else if user.status == "active" { 
            return Ok(user);
        }
    }
    
    Err(LoginUserError::UserDoesNotExist)

}