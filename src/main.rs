#[tokio::main]
async fn main() {
    let app = axum::Router::new().route("/", axum::routing::get(root));
    let listener = tokio::net::TcpListener::bind("0.0.0.0:8081").await.unwrap();
    axum::serve(listener, app).await.unwrap();
}

async fn root() -> &'static str {
    "Hello, World!"
}
