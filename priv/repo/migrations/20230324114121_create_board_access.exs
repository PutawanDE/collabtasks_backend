defmodule CollabtasksBackend.Repo.Migrations.CreateBoardAccess do
  use Ecto.Migration

  def change do
    create table(:board_access, primary_key: false) do
      add :board_id, references(:boards, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:board_access, [:user_id, :board_id])
  end
end
