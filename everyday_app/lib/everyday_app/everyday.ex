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
  Gets trainings by user and day.

  ## Examples

      iex> get_trainings(123)
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

  @spec _user(any) :: %{user: any}
  defp _user(user_id) do
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
  defp _calendar(%{user: user}, day) do
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
  defp _trainings(%{user: user, calendar: nil}, day) do
    {_ok, d} = Date.from_iso8601(day)
    cal_changeset = Calendar.changeset(%Calendar{}, %{
      cal_date: d,
      user_id: user.id
    })
    cal = Repo.insert!(cal_changeset)

    tq = from t in Training,
          where: t.calendar_id == ^cal.id,
          order_by: :id
    trainings = Repo.all(tq)

    %{user: user, calendar: cal, trainings: trainings}
  end
  defp _trainings(%{user: user, calendar: cal}, _) do
    tq = from t in Training,
          where: t.calendar_id == ^cal.id,
          order_by: :id
    trainings = Repo.all(tq)

    %{user: user, calendar: cal, trainings: trainings}
  end

  @doc """
  Creates or Updates trainings.

    ## Examples

      iex> create_or_update_trainings(123, "2021-05-05", %{id: 1, ...})

  """
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
  Copys trainings that is related to other day to the day specified with `day`.

  ## Examples

      iex> copy_trainings(123, "2021-05-05")

  """
  def copy_trainings(user_id, day) do
    user_and_cal = user_id
    |> _user()
    |> _calendar(day)

    user_and_cal.user
    |> _get_last_trainings
    |> Enum.map(&(create_or_update_trainings(user_id, day, %{
      id: nil,
      title: &1.title,
      expect: &1.expect,
    })))
  end

  defp _get_last_trainings(user) do
    q = from t in Training,
      inner_join: c in Calendar, on: t.calendar_id == c.id,
      inner_join: u in User, on: c.user_id == u.id,
      where: u.id == ^user.id and c.id in subquery(
        # training をなにかしらもっている最新のもの(id はふつうに作っていたら日付順に並ぶであろう)を calendar から抽出する
        from c2 in Calendar,
          inner_join: u2 in User, on: c2.user_id == u2.id,
          inner_join: t2 in Training, on: t2.calendar_id == c2.id,
          where: u2.id == ^user.id,
          order_by: [desc: :id],
          limit: 1,
          select: [:id]
      )
    trainings = Repo.all(q)
    trainings
  end

  @doc """
  Updates a training.

  ## Examples

      iex> do_training(456, %{increment: 4})

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

  defp _do_training(t, %{increment: inc}) do
    Training.changeset(t, %{current: t.current + inc})
  end
  defp _do_training(t, %{decrement: dec}) do
    case t.current - dec do
      n when n < 0 ->
        nil
      _ ->
        Training.changeset(t, %{current: t.current - 1})
    end
  end

  @doc """
  Deletes a training.

  ## Examples

      iex> delete_training(123)

  """
  def delete_training(id) do
    q = from t in Training,
          where: t.id == ^id
    training = Repo.one(q)
    Repo.delete(training)
  end
end
