defmodule EverydayApp.Repo.Migrations.AddSkipFlag do
  use Ecto.Migration

  def change do
    alter table(:trainings) do
      add :skip, :boolean, default: false, null: false, after: :calendar_id
    end
  end
end
