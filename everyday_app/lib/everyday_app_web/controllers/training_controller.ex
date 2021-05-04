defmodule EverydayAppWeb.TrainingController do
  use EverydayAppWeb, :controller

  alias EverydayApp.Everyday

  def update(conn, %{"id" => id, "increment" => _increment, "user" =>  user_id, "day" => day}) do
    Everyday.do_training(id, %{increment: 1})

    redirect(conn, to: Routes.day_path(conn, :show, user_id, day: day))
  end
  def update(conn, %{"id" => id, "decrement" => _decrement, "user" => user_id, "day" => day}) do
    Everyday.do_training(id, %{decrement: 1})

    redirect(conn, to: Routes.day_path(conn, :show, user_id, day: day))
  end


  def delete(conn, %{"id" => id}) do
    :ok = Everyday.delete_training(id)

    conn
    |> put_flash(:info, "Training deleted successfully.")
    |> redirect(to: Routes.day_path(conn, :index))
  end
end
