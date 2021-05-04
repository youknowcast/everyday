defmodule EverydayApp.Everyday do
  @moduledoc """
  The Everyday context.
  """

  import Ecto.Query, warn: false
  alias EverydayApp.Repo
  alias EverydayApp.Training
  alias EverydayApp.Calendar
  alias EverydayApp.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_user do
    users = Repo.all(from u in User, where: u.active)
    users
  end

  @doc """
  Gets a single day.

  Raises if the Day does not exist.

  ## Examples

      iex> get_day!(123)
      %Day{}

  """
  def get_trainings(user_id, day) do
    uq = from u in User,
              where: u.id == ^user_id,
              select: [:id, :name]
    user = Repo.one(uq)

    cq = from c in Calendar,
              where: c.cal_date == ^day and c.user_id == ^user.id,
              select: [:id]
    cal = Repo.one(cq)

    trainings = _get_trainings(user, cal, day)

    %{user: user, trainings: trainings}
  end

  def _get_trainings(user, nil, day) do
    {_ok, d} = Date.from_iso8601(day)
    cal_changeset = Calendar.changeset(%Calendar{}, %{
      cal_date: d,
      user_id: user.id
    })
    cal = Repo.insert!(cal_changeset)

    tq = from t in Training,
    where: t.calendar_id == ^cal.id
    trainings = Repo.all(tq)
    trainings
  end
  def _get_trainings(_, cal, _) do
    tq = from t in Training,
    where: t.calendar_id == ^cal.id
    trainings = Repo.all(tq)
    trainings
  end

  @doc """
  Creates a day.

  ## Examples

      iex> create_day(%{field: value})
      {:ok, %Day{}}

      iex> create_day(%{field: bad_value})
      {:error, ...}

  """
  def create_day(attrs \\ %{}) do
    raise "TODO"
  end

  @doc """
  Updates a day.

  ## Examples

      iex> update_day(day, %{field: new_value})
      {:ok, %Day{}}

      iex> update_day(day, %{field: bad_value})
      {:error, ...}

  """
  def update_day(%Training{} = day, attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a Day.

  ## Examples

      iex> delete_day(day)
      {:ok, %Day{}}

      iex> delete_day(day)
      {:error, ...}

  """
  def delete_day(%Training{} = day) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking day changes.

  ## Examples

      iex> change_day(day)
      %Todo{...}

  """
  def change_day(%Training{} = day, _attrs \\ %{}) do
    raise "TODO"
  end
end
