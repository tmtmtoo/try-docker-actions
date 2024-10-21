# syntax=docker/dockerfile:1

FROM rust:1.82.0 AS builder
WORKDIR /build
COPY . .
RUN cargo build --release

FROM debian:bookworm-slim
WORKDIR /app
COPY --from=builder /build/target/release/try-docker-actions .
CMD ["./try-docker-actions"]
