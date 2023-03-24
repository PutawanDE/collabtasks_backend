defmodule CollabtasksBackend.BoardAccess do
  use Ecto.Schema
  import Ecto.Changeset

  schema "board_access" do
    @primary_key false
    belongs_to :board, CollabtasksBackend.Board
    belongs_to :user, CollabtasksBackend.User

    timestamps()
  end

  @doc false
  def changeset(board_access, attrs) do
    board_access
    |> cast(attrs, [:board_id, :user_id])
    |> validate_required([:board_id, :user_id])
  end
end
