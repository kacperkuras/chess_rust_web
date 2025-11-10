use actix_web::{get, web, HttpResponse, Responder}; 
use actix_web_flash_messages::{IncomingFlashMessages};
use actix_session::Session;

use sqlx::MySqlPool;

use crate::db;
use crate::routes::utils::{redirect, TEMPLATES, collect_flash_messages};
use crate::models::models::{User, UserStatistics};


#[get("/")]
async fn home_page(flash_messages: IncomingFlashMessages, db_pool: web::Data<MySqlPool>, session: Session) -> impl Responder {
    let user = session.get::<i32>("user_id").unwrap();
    if user.is_none() {
        return redirect("/login");
    }

    let mut context = tera::Context::new();

    let user: User = db::users::get_user_by_id(&db_pool, user.unwrap()).await.unwrap().unwrap();
    let user_statistics: UserStatistics = db::statistics::get_user_statistics(&db_pool, user.id).await.unwrap().unwrap();

    context.insert("user", &user);
    context.insert("username", &user.username);
    context.insert("user_statistics", &user_statistics);

    let messages = collect_flash_messages(flash_messages);
    context.insert("flash_messages", &messages);
    context.insert("logged_in", &true);
    HttpResponse::Ok().body(TEMPLATES.render("home.html", &context).unwrap())
}


#[get("/play")]
async fn play_page(flash_messages: IncomingFlashMessages,  db_pool: web::Data<MySqlPool>, session: Session) -> impl Responder {

    let user_id = session.get::<i32>("user_id").unwrap();
    let user = match user_id {
        Some(id) => db::users::get_user_by_id(&db_pool, id).await.unwrap().unwrap(),
        None => return redirect("/login"),
    };
    let user_statistics = db::statistics::get_user_statistics(&db_pool, user.id).await.unwrap().unwrap();
    let mut context = tera::Context::new();
    let messages = collect_flash_messages(flash_messages);
    context.insert("flash_messages", &messages);
    context.insert("logged_in", &true);
    context.insert("username", &user.username);
    context.insert("elo", &user_statistics.elo);

    HttpResponse::Ok().body(TEMPLATES.render("chess.html", &context).unwrap())
}

#[get("/games")]
async fn games_page(flash_messages: IncomingFlashMessages,  db_pool: web::Data<MySqlPool>, session: Session) -> impl Responder {
    
    let user_id = session.get::<i32>("user_id").unwrap();
    let user = match user_id {
        Some(id) => db::users::get_user_by_id(&db_pool, id).await.unwrap().unwrap(),
        None => return redirect("/login"),
    };

    let games = db::games::get_games_for_player(&db_pool, user.id).await.unwrap();

    for game in &games{
        print!("\n\n\n{:?}\n\n\n", game);
    }


    let mut context = tera::Context::new();
    let messages = collect_flash_messages(flash_messages);
    context.insert("flash_messages", &messages);
    context.insert("logged_in", &true);
    context.insert("username", &user.username);

    context.insert("games", &games);

    HttpResponse::Ok().body(TEMPLATES.render("games.html", &context).unwrap())
}


#[get("/statistics")]
pub async fn statistics_page(flash_messages: IncomingFlashMessages, db_pool: web::Data<MySqlPool>, session: Session) -> impl Responder {
    let user_id = session.get::<i32>("user_id").unwrap();
    let user = match user_id {
        Some(id) => db::users::get_user_by_id(&db_pool, id).await.unwrap().unwrap(),
        None => return redirect("/login"),
    };

    let user_statistics = db::statistics::get_user_statistics(&db_pool, user.id).await.unwrap().unwrap();

    let mut context = tera::Context::new();
    let messages = collect_flash_messages(flash_messages);
    context.insert("flash_messages", &messages);
    context.insert("logged_in", &true);
    context.insert("username", &user.username);
    context.insert("user_statistics", &user_statistics);

    HttpResponse::Ok().body(TEMPLATES.render("statistics.html", &context).unwrap())
}