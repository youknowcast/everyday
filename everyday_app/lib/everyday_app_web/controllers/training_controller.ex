defmodule EverydayAppWeb.TrainingController do
  use EverydayAppWeb, :controller

  alias EverydayApp.Everyday

  @spec update(Plug.Conn.t(), map) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "increment" => _increment, "user" =>  user_id, "day" => day}) do
    Everyday.do_training(id, %{increment: 1})

    conn
    |> redirect(to: Routes.day_path(conn, :show, user_id, day: day))
  end
  def update(conn, %{"id" => id, "decrement" => _decrement, "user" => user_id, "day" => day}) do
    Everyday.do_training(id, %{decrement: 1})

    conn
    |> redirect(to: Routes.day_path(conn, :show, user_id, day: day))
  end


  @spec delete(Plug.Conn.t(), map) :: Plug.Conn.t()
  def delete(conn, %{"id" => id, "user" => user_id, "day" => day}) do
    :ok = Everyday.delete_training(id)

    conn
    |> redirect(to: Routes.day_path(conn, :show, user_id, day: day))
  end
end
