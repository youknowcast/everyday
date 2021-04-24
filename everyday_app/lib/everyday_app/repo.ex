defmodule EverydayApp.Repo do
  use Ecto.Repo,
    otp_app: :everyday_app,
    adapter: Ecto.Adapters.Postgres
end
