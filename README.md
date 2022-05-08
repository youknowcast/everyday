# everyday

## requirements

TBD

* elixir
* docker-compose
* yarn

## setup

build phoenix app

```
% cd everyday_app
% mix deps.get, compile
```

build javascript

```
% cd assets
% yarn

# when development
% yarn run watch
```

then, docker-compose at project root dir.

```
% docker-compose build
% docker-compose up -d
% docker-compose run --rm app mix ecto.create
% docker-compose run --rm app mix ecto.migrate
```

also run seeds

```
% docker-compose run --rm app mix run priv/repo/seeds.exs
```