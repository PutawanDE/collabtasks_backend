defmodule CollabtasksBackend.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :displayName, :string
    field :email, :string
    field :photoUrl, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:id, :email, :displayName, :photoUrl])
    |> validate_required([:id, :email, :displayName, :photoUrl])
  end
end
