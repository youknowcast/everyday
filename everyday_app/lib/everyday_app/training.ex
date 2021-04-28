defmodule EverydayApp.Training do
  use Ecto.Schema
  import Ecto.Changeset

  alias EverydayApp.User

  schema "trainings" do
    field :title, :string
    field :current, :integer
    field :expect, :integer
    belongs_to :user, User, foreign_key: :user_id, references: :id

    timestamps()
  end

  @doc false
  def changeset(training, attrs) do
    training
    |> cast(attrs, [:title, :expect, :current])
    |> validate_required([:title, :expect, :current])
  end
end
