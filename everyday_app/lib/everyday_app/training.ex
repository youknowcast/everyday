defmodule EverydayApp.Training do
  @moduledoc """
  Training
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias EverydayApp.Calendar

  schema "trainings" do
    field :title, :string
    field :current, :integer
    field :expect, :integer
    field :skip, :boolean
    belongs_to :calendar, Calendar, foreign_key: :calendar_id, references: :id

    timestamps()
  end

  @doc false
  def changeset(training, attrs) do
    training
    |> cast(attrs, [:title, :expect, :current, :calendar_id])
    |> validate_required([:title, :expect, :current])
  end
end
