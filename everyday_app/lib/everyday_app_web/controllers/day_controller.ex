defmodule EverydayAppWeb.DayController do
  use EverydayAppWeb, :controller

  alias EverydayApp.Everyday
  alias EverydayApp.Training

  def index(conn, _params) do
    users = Everyday.list_user
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Everyday.change_day(%Training{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"day" => day_params}) do
    case Everyday.create_day(day_params) do
      {:ok, day} ->
        conn
        |> put_flash(:info, "Day created successfully.")
        |> redirect(to: Routes.day_path(conn, :show, day))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"user_id" => user_id, "calendar_id" => calendar_id}) do
    day = Everyday.get_day!(user_id)
    render(conn, "show.html", day: day)
  end

  def show_today(conn, %{"user_id" => user_id}) do
    today = Everyday.get_today
    show(conn, %{
      "user_id" => user_id,
      "calendar_id" => ""
    })
  end

  def edit(conn, %{"id" => id}) do
    day = Everyday.get_day!(id)
    changeset = Everyday.change_day(day)
    render(conn, "edit.html", day: day, changeset: changeset)
  end

  def update(conn, %{"id" => id, "day" => day_params}) do
    day = Everyday.get_day!(id)

    case Everyday.update_day(day, day_params) do
      {:ok, day} ->
        conn
        |> put_flash(:info, "Day updated successfully.")
        |> redirect(to: Routes.day_path(conn, :show, day))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", day: day, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    day = Everyday.get_day!(id)
    {:ok, _day} = Everyday.delete_day(day)

    conn
    |> put_flash(:info, "Day deleted successfully.")
    |> redirect(to: Routes.day_path(conn, :index))
  end
end
