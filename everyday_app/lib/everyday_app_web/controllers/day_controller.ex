defmodule EverydayAppWeb.DayController do
  use EverydayAppWeb, :controller

  alias EverydayApp.Everyday

  def index(conn, _params) do
    users = Everyday.list_user
    day = Date.to_string(Date.utc_today)
    render(conn, "index.html", users: users, day: day)
  end

  def show(conn, %{"user_id" => user_id, "day" => day}) do
    %{user: user, trainings: trainings} = Everyday.get_trainings(user_id, day)

    render(conn, "show.html", trainings: trainings, user: user, day: day)
  end
  def show(conn, %{"user_id" => user_id}) do
    day = Date.to_string(Date.utc_today)
    %{user: user, trainings: trainings} = Everyday.get_trainings(user_id, day)

    render(conn, "show.html", trainings: trainings, user: user, day: day)
  end

  def create(conn, %{"user_id" => user_id, "day" => day}) do
    Everyday.copy_trainings(user_id, day)

    redirect(conn, to: "/day/#{user_id}?day=#{day}")
  end

  @spec update(Plug.Conn.t(), map) :: Plug.Conn.t()
  def update(conn, %{"user_id" => user_id, "day" => day,
                      "title" => title, "expect" => expect}) do

    Everyday.create_or_update_trainings(user_id, day, %{id: nil, title: title, expect: expect})

    redirect(conn, to: "/day/#{user_id}?day=#{day}")
  end
end
