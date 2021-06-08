defmodule EverydayAppWeb.WeeksController do
  use EverydayAppWeb, :controller

  alias EverydayApp.Everyday
  alias EverydayApp.Everyday.Weeks

  def show(conn, %{"day" => day}) do
    week = day
      |> Everyday.get_mon
      |> Everyday.get_week!

    render(conn, "show.html", week: week)
  end
end
