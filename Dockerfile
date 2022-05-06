FROM elixir:1.13.4-slim

ENV ELIXIR_VERSION="v1.13.4" \
	LANG=C.UTF-8

RUN apt-get update \
    && apt-get install -y inotify-tools nodejs npm
RUN npm install npm@latest -g

RUN mix do local.hex --force, local.rebar --force, archive.install --force hex phx_new

WORKDIR /app