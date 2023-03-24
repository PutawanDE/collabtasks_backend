defmodule CollabtasksBackend.Board do
  use Ecto.Schema
  import Ecto.Changeset

  schema "boards" do
    field :boardName, :string
    many_to_many :users, CollabtasksBackend.User, join_through: "board_access", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:boardName])
    |> validate_required([:boardName])
  end
end
