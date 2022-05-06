# everyday

## setup

build phoenix app

```
% cd everyday_app
% mix deps.get, compile
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