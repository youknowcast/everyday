defmodule EverydayAppWeb.Router do
  use EverydayAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :basic_auth,
      username: Application.get_env(:everyday_app, :basic_auth)[:username],
      password: Application.get_env(:everyday_app, :basic_auth)[:password]
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EverydayAppWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/day", DayController, :index
    get "/day/:user_id", DayController, :show
    put "/day/:user_id", DayController, :update
    post "/day/:user_id/create", DayController, :create

    put "/training/:id", TrainingController, :update
    delete "/training/:id", TrainingController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", EverydayAppWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: EverydayAppWeb.Telemetry
    end
  end
end
