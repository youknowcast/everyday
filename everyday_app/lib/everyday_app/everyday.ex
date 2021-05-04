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

    ret = user_id
    |> _user()
    |> _calendar(day)
    |> _trainings(day)

    # %{user: user, calendar: calendar, trainings: traininings}
    ret
  end

  def _user(user_id) do
    uq = from u in User,
          where: u.id == ^user_id,
          select: [:id, :name]
    user = Repo.one(uq)

    %{user: user}
  end

  @spec _calendar(
          %{:user => atom | %{:id => any, optional(any) => any}, optional(any) => any},
          any
        ) :: %{calendar: any, user: atom | %{:id => any, optional(any) => any}}
  def _calendar(%{user: user}, day) do
    cq = from c in Calendar,
          where: c.cal_date == ^day and c.user_id == ^user.id,
          select: [:id]
    cal = Repo.one(cq)

    %{user: user, calendar: cal}
  end

  @spec _trainings(
          %{
            :calendar => atom | %{:id => any, optional(any) => any},
            :user => any,
            optional(any) => any
          },
          any
        ) :: %{calendar: atom | %{:id => any, optional(any) => any}, trainings: any, user: any}
  def _trainings(%{user: user, calendar: nil}, day) do
    {_ok, d} = Date.from_iso8601(day)
    cal_changeset = Calendar.changeset(%Calendar{}, %{
      cal_date: d,
      user_id: user.id
    })
    cal = Repo.insert!(cal_changeset)

    tq = from t in Training,
    where: t.calendar_id == ^cal.id
    trainings = Repo.all(tq)

    %{user: user, calendar: cal, trainings: trainings}
  end
  def _trainings(%{user: user, calendar: cal}, _) do
    tq = from t in Training,
    where: t.calendar_id == ^cal.id
    trainings = Repo.all(tq)

    %{user: user, calendar: cal, trainings: trainings}
  end

  @spec create_or_update_trainings(
          any,
          any,
          :invalid | %{:id => any, optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: any
  def create_or_update_trainings(user_id, day, changeset) do

    %{user: _user, calendar: cal, trainings: trainings} = user_id
    |> _user()
    |> _calendar(day)
    |> _trainings(day)

    case changeset.id do
      nil ->
        t = Training.changeset(%Training{
          current: 0,
          calendar_id: cal.id
        }, changeset)
        Repo.insert!(t)

      training_id ->
        current = Enum.find(trainings, &(&1.id == training_id))

        future = Training.changeset(current, changeset)
        Repo.update!(future)
    end
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
  def do_training(training_id, content) do
    q = from t in Training,
          where: t.id == ^training_id
    training = Repo.one(q)

    new_content = _do_training(training, content)
    case new_content do
      nil ->
        nil
      changeset ->
        Repo.update(changeset)
    end
  end

  def _do_training(t, %{increment: inc}) do
    Training.changeset(t, %{current: t.current + inc})
  end
  def _do_training(t, %{decrement: dec}) do
    case t.current - dec do
      n when n < 0 ->
        nil
      _ ->
        Training.changeset(t, %{current: t.current - 1})
    end
  end


  @doc """
  Deletes a Day.

  ## Examples

      iex> delete_day(day)
      {:ok, %Day{}}

      iex> delete_day(day)
      {:error, ...}

  """
  def delete_training(id) do
    q = from t in Training,
          where: t.id == ^id
    training = Repo.one(q)
    Repo.delete(training)

    :ok
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
