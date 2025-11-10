use actix_web_flash_messages::{IncomingFlashMessages, Level};
use actix_web::HttpResponse;
use lazy_static::lazy_static;
use tera::Tera;

lazy_static! {
    pub static ref TEMPLATES: Tera = {
        match Tera::new("templates/**/*") {
            Ok(t) => t,
            Err(e) => {
                eprintln!("Błąd ładowania szablonów Tera: {:?}", e);
                std::process::exit(1);
            }
        }
    };
}

pub fn redirect(location: &str) -> HttpResponse {
    HttpResponse::Found()
        .insert_header(("Location", location))
        .finish()
}

pub fn collect_flash_messages(flash_messages: IncomingFlashMessages) -> Vec<(&'static str, String)> {
    flash_messages
        .iter()
        .map(|msg| {
            let level_str = match msg.level() {
                Level::Error => "error",
                Level::Info => "info",
                Level::Success => "success",
                Level::Warning => "warning",
                Level::Debug => "debug",
            };
            (level_str, msg.content().to_string())
        })
        .collect()
}