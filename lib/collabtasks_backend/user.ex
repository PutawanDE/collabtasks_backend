defmodule CollabtasksBackend.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :displayName, :string
    field :email, :string, primary_key: true
    field :photoUrl, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :displayName, :photoUrl])
    |> validate_required([:email, :displayName, :photoUrl])
  end
end
