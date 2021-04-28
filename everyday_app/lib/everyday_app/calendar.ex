defmodule EverydayApp.Calendar do
  use Ecto.Schema
  import Ecto.Changeset

  alias EverydayApp.User
  alias EverydayApp.Training

  schema "calendars" do
    field :cal_date, :date
    belongs_to :user, User, foreign_key: :user_id, references: :id
    has_many :trainings, Training

    timestamps()
  end

  @doc false
  def changeset(calendar, attrs) do
    calendar
    |> cast(attrs, [:cal_date, :user_id])
    |> validate_required([:cal_date])
  end
end
