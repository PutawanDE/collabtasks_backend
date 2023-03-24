defmodule CollabtasksBackend.Repo.Migrations.CreateBoards do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add :boardName, :string

      timestamps()
    end
  end
end
