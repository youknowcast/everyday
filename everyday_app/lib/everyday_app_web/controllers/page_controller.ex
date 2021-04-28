defmodule EverydayAppWeb.PageController do
  use EverydayAppWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: "/day")
  end
end
