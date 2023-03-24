defmodule CollabtasksBackend.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :board_id, references(:boards, on_delete: :delete_all)
      add :taskName, :string
      add :startTime, :utc_datetime
      add :endTime, :utc_datetime
      add :isCompleted, :boolean, default: false, null: false

      timestamps()
    end
  end
end
