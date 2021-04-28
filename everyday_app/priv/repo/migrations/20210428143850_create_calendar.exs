defmodule EverydayApp.Repo.Migrations.CreateCalendar do
  use Ecto.Migration

  def change do
    create table(:calendar) do
      add :cal_date, :date
      add :user_id, :integer

      timestamps()
    end

  end
end
