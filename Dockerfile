FROM node:16.15-slim as node

FROM elixir:1.13.4-slim

ENV ELIXIR_VERSION="v1.13.4" \
	LANG=C.UTF-8
ENV YARN_VERSION 1.22.18

RUN mkdir -p /opt
COPY --from=node /opt/yarn-v$YARN_VERSION /opt/yarn
COPY --from=node /usr/local/bin/node /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules/ /usr/local/lib/node_modules/
RUN ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
  && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarnpkg \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs \
  && ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
  && ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npx

RUN apt-get update \
    && apt-get install -y inotify-tools

WORKDIR /app/assets
RUN yarn install

WORKDIR /
RUN mix do local.hex --force, local.rebar --force, archive.install --force hex phx_new

WORKDIR /app