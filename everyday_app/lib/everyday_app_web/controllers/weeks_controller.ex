defmodule EverydayAppWeb.WeeksController do
  use EverydayAppWeb, :controller

  alias EverydayApp.Everyday
  alias EverydayApp.Everyday.Weeks

  def index(conn, %{"day" => day}) do
    {:ok, _day} = Date.from_iso8601(day)
    conn
    |> render("index.html", %{users: Everyday.list_user, week: Everyday.get_week(_day)})
  end
  def index(conn, _params) do
    conn
    |> render("index.html", %{users: Everyday.list_user, week: Everyday.get_week(nil)})
  end

  def show(conn, %{"user_id" => user_id, "day" => day}) do
    if  day == "" do
      conn
      |> put_flash(:error, "ひづけをいれてね")
      |> redirect(to: "/day/#{user_id}")
    end

    week = day
      |> Everyday.get_mon
      |> Everyday.get_week
      |> Enum.map(&(Everyday.get_trainings(user_id, &1)))

    render(conn, "show.html", week: week)
  end
end
