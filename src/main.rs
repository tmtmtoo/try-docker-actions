#[tokio::main]
async fn main() {
    let app = axum::Router::new().route("/", axum::routing::get(root));
    let listener = tokio::net::TcpListener::bind("0.0.0.0:8081").await.unwrap();
    axum::serve(listener, app).await.unwrap();
}

async fn root() -> String {
    let foo = std::env::var("FOO").unwrap_or_else(|_| "foo".into());
    format!("Hello, World!! {foo}")
}
