defmodule EverydayApp.User do
  @moduledoc """
  User
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias EverydayApp.Calendar

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
