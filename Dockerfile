# FROM dockerhub.tezign.com/innovation/muse-credits/muse-credits:v1.6

# ENV start_params=" "

# EXPOSE 8080
# CMD ["sh", "-c", "/usr/app/credits-cli task ${task_params} && /usr/app/credits-cli start"]



FROM rust:1.74-slim as builder

WORKDIR /usr/src/

COPY . .

RUN apt-get update && apt-get install -y libssl-dev pkg-config

RUN cargo build --release

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y libc6 && apt-get install -y libssl-dev pkg-config

WORKDIR /usr/app

COPY --from=builder /usr/src/config /usr/app/config
COPY --from=builder /usr/src/target/release/credits-cli /usr/app/credits-cli

ENV start_params=" "

EXPOSE 8080
CMD ["sh", "-c", "/usr/app/credits-cli task ${task_params} && /usr/app/credits-cli start"]