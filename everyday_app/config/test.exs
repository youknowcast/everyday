import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :everyday_app, EverydayApp.Repo,
       adapter: Ecto.Adapters.MyXQL,
       username: "root",
       password: "",
       hostname: "127.0.0.1",
       port: 23306,
       database: "everyday_test",
       pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :everyday_app, EverydayAppWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
