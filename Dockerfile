# syntax=docker/dockerfile:1

FROM rust:1.82.0 AS builder
WORKDIR /build
RUN --mount=type=bind,source=src,target=src \
  --mount=type=bind,source=Cargo.toml,target=Cargo.toml \
  --mount=type=bind,source=Cargo.lock,target=Cargo.lock \
  --mount=type=cache,target=/build/target/ \
  --mount=type=cache,target=/usr/local/cargo/registry/ \
  <<EOF
set -e
cargo build --locked --release
cp ./target/release/try-docker-actions /bin/app
EOF

FROM debian:bookworm-slim
RUN adduser \
  --disabled-password \
  --gecos "" \
  --home "/nonexistent" \
  --shell "/sbin/nologin" \
  --no-create-home \
  --uid 10001 \
  appuser
USER appuser
COPY --from=builder /bin/app /bin
CMD ["/bin/app"]
