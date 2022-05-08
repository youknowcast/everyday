# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :everyday_app,
  env: config_env()

config :everyday_app,
  ecto_repos: [EverydayApp.Repo]

# Configures the endpoint
config :everyday_app, EverydayAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fH/WyIVTmRn35ADxPvwKLjhG+0+USB2C7pudw/Fe4z3IwI/KJj6ZqJ5kGJoJjqw/",
  render_errors: [view: EverydayAppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: EverydayApp.PubSub,
  live_view: [signing_salt: "uKGN/+UA"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
