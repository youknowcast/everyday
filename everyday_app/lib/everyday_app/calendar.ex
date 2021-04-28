defmodule EverydayApp.Calendar do
  use Ecto.Schema
  import Ecto.Changeset

  alias EverydayApp.User

  schema "calendars" do
    field :cal_date, :date
    belongs_to :user, User, foreign_key: :user_id, references: :id
    belongs_to :training, Training, foreign_key: :training_id, references: :id

    timestamps()
  end

  @doc false
  def changeset(calendar, attrs) do
    calendar
    |> cast(attrs, [:cal_date])
    |> validate_required([:cal_date])
  end
end
