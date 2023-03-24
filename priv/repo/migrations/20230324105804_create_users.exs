defmodule CollabtasksBackend.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :displayName, :string
      add :photoUrl, :string

      timestamps()
    end
  end
end
