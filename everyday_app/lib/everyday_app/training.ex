defmodule EverydayApp.Training do
  use Ecto.Schema
  import Ecto.Changeset

  schema "trainings" do
    field :current, :integer
    field :expect, :integer
    field :title, :string
    belongs_to :calendar, Calendar, foreign_key: :calendar_id, references: :id

    timestamps()
  end

  @doc false
  def changeset(training, attrs) do
    training
    |> cast(attrs, [:title, :expect, :current])
    |> validate_required([:title, :expect, :current])
  end
end
