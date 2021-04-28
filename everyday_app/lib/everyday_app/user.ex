defmodule EverydayApp.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :active, :boolean
    has_many :calendars, Calendar

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :active])
    |> validate_required([:name])
  end
end
