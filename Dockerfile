FROM bitwalker/alpine-elixir:1.12.3

RUN mkdir /app
WORKDIR /app

COPY mix.exs mix.lock entrypoint.sh ./

RUN apk update \
    && mix do deps.get, deps.compile \
    && chmod +x /app/entrypoint.sh && \
    update-ca-certificates

COPY . . 

ENTRYPOINT [ "sh", "/app/entrypoint.sh" ]