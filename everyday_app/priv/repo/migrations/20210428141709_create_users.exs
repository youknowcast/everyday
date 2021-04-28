defmodule EverydayApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :active, :boolean

      timestamps()
    end

  end
end
