use actix_web::{get, post, web, HttpResponse, Responder}; 
use actix_web_flash_messages::{FlashMessage, IncomingFlashMessages};
use actix_session::Session;
use sqlx::MySqlPool;

use crate::routes::utils::{redirect, TEMPLATES, collect_flash_messages};
use crate::models::models::{LoginUser, RegisterUser};
use crate::auth::{password_hashing, jwt};
use crate::db;

#[get("/login")]
async fn login_page(flash_messages: IncomingFlashMessages, session: Session) -> impl Responder {
    let user_id = session.get::<i32>("user_id").unwrap();
    if user_id.is_some() {
        return redirect("/")
    }
    
    let mut context = tera::Context::new();
    let messages = collect_flash_messages(flash_messages);
    context.insert("flash_messages", &messages);
    context.insert("logged_in", &false);
    HttpResponse::Ok().body(TEMPLATES.render("login.html", &context).unwrap())
}

#[get("/register")]
async fn register_page(flash_messages: IncomingFlashMessages, session: Session) -> impl Responder {
    let user_id = session.get::<i32>("user_id").unwrap();
    if user_id.is_some() {
        return redirect("/")
    }

    let mut context = tera::Context::new();
    let messages = collect_flash_messages(flash_messages);
    context.insert("flash_messages", &messages);
    context.insert("logged_in", &false);
    HttpResponse::Ok().body(TEMPLATES.render("register.html", &context).unwrap())
}

#[post("/login")]
async fn login_handler(form: web::Form<LoginUser>, db_pool: web::Data<MySqlPool>, session: Session) -> impl Responder {

    let form = form.into_inner();
    
    let user = db::users::login_user(&db_pool, &form).await;

    match user {
        Ok(user) => {
            if password_hashing::verify_password(&form.password, &user.password_hash) {
                session.insert("user_id", user.id).unwrap();
                FlashMessage::success("Zalogowano pomyślnie!").send();
                return redirect("/");
            } else {
                FlashMessage::warning("Niepoprawne hasło! Spróbuj ponownie.").send();
                return redirect("/login");
            }
        }
        Err(db::users::LoginUserError::UserDoesNotExist) => {
            FlashMessage::warning("Nie znaleziono użytkownika o podanym emailu.").send();
            return redirect("/login");
        }


        Err(db::users::LoginUserError::UserBanned) => {
            FlashMessage::warning("Twoje konto zostało zbanowane.").send();
            return redirect("/login");
        }
        Err(db::users::LoginUserError::UserSuspended) => {
            FlashMessage::warning("Twoje konto zostało zawieszone.").send();
            return redirect("/login");
        }
        Err(_) => {
            FlashMessage::error("Wystąpił błąd podczas logowania. Spróbuj ponownie później.").send();
            return redirect("/login");
        }
    }
}

#[post("/register")]
async fn register_handler(form: web::Form<RegisterUser>, db_pool: web::Data<MySqlPool>, session: Session) -> impl Responder {

    let user_id = session.get::<i32>("user_id").unwrap();
    if user_id.is_some() {
        return redirect("/")
    }

    let mut user = RegisterUser{
        username: form.username.clone(),
        email: form.email.clone(),
        password: form.password.clone(),
        password_confirmation: form.password_confirmation.clone(),
        elo: form.elo,
    };

    if ![600, 800, 1000].contains(&user.elo) {
        user.elo = 600;
    }

    if user.password != user.password_confirmation {
        FlashMessage::warning("Hasła nie są takie same!").send();
        return redirect("/register");
    }

    user.password = password_hashing::hash_password(&user.password).unwrap();

    match db::users::create_user(&db_pool, &user).await{
        Ok(_) =>{
            FlashMessage::success("Rejestracja zakończona sukcesem! Możesz teraz się zalogować.").send();
            return redirect("/login");
        }
        Err(db::users::CreateUserError::EmailExists) =>{
            FlashMessage::warning("Podany Email jest zajęty.").send();
            return redirect("/register");
        }
        Err(db::users::CreateUserError::UsernameExists) =>{
            FlashMessage::warning("Podana nazwa użytkownika jest już zajęta.").send();
            return redirect("/register");
        }
        Err(db::users::CreateUserError::DatabaseError(_)) => {
            FlashMessage::error("Wystąpił błąd podczas rejestracji. Spróbuj ponownie później.").send();
            return redirect("/register");
        }
    }

}

#[get("/logout")]
async fn logout(session: Session) -> impl Responder {
    session.remove("user_id");
    FlashMessage::info("Zostałeś wylogowany.").send();
    redirect("/")
}


#[get("/get_jwt")]
async fn get_jwt(session: Session) -> impl Responder {
    if let Ok(Some(user_id)) = session.get::<i32>("user_id") {
        match jwt::create_jwt(user_id) {
            Ok(token) => return HttpResponse::Ok().json(serde_json::json!({ "token": token })),
            Err(_) => return HttpResponse::InternalServerError().body("Błąd JWT"),
        }
    }

    HttpResponse::Unauthorized().body("Nie jesteś zalogowany")
}