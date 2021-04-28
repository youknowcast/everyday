defmodule EverydayApp.Repo.Migrations.CreateTrainings do
  use Ecto.Migration

  def change do
    create table(:trainings) do
      add :title, :string
      add :expect, :integer
      add :current, :integer

      timestamps()
    end

  end
end
