defmodule CollabtasksBackend.UserBoards do
  @moduledoc """
  The UserBoards context.
  """

  import Ecto.Query, warn: false
  alias CollabtasksBackend.BoardAccess
  alias Ecto.Multi
  alias CollabtasksBackend.Repo

  alias CollabtasksBackend.Board

  @doc """
  Returns the list of boards.

  ## Examples

      iex> list_boards()
      [%Board{}, ...]

  """
  def list_boards do
    Repo.all(Board)
  end

  @doc """
  Gets a single board.

  Raises `Ecto.NoResultsError` if the Board does not exist.

  ## Examples

      iex> get_board!(123)
      %Board{}

      iex> get_board!(456)
      ** (Ecto.NoResultsError)

  """
  def get_board!(id), do: Repo.get!(Board, id)

  @doc """
  Creates a board.

  ## Examples

      iex> create_board(%{field: value})
      {:ok, %Board{}}

      iex> create_board(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_board(attrs \\ %{}) do
    Multi.new()
    |> Multi.insert(:board, Board.changeset(%Board{}, attrs))
    |> Multi.insert(:board_access, fn %{board: %Board{id: boardId}} ->
      CollabtasksBackend.BoardAccess.changeset(%CollabtasksBackend.BoardAccess{}, %{
        board_id: boardId,
        user_id: attrs["userId"]
      })
    end)
    |> Repo.transaction()
    |> case  do
      {:ok, %{board: board, board_access: _board_access}} -> {:ok, board}
      {:error, _} -> {:error, Board.changeset(%Board{}, attrs)}
    end
  end

  @doc """
  Updates a board.

  ## Examples

      iex> update_board(board, %{field: new_value})
      {:ok, %Board{}}

      iex> update_board(board, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_board(%Board{} = board, attrs) do
    board
    |> Board.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a board.

  ## Examples

      iex> delete_board(board)
      {:ok, %Board{}}

      iex> delete_board(board)
      {:error, %Ecto.Changeset{}}

  """
  def delete_board(%Board{} = board) do
    Repo.delete(board)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking board changes.

  ## Examples

      iex> change_board(board)
      %Ecto.Changeset{data: %Board{}}

  """
  def change_board(%Board{} = board, attrs \\ %{}) do
    Board.changeset(board, attrs)
  end

  def list_user_boards(id) do
    Repo.all(
      from b in Board,
      join: ba in BoardAccess,
      where: ba.user_id == ^id,
      distinct: true,
      select: b
    )
  end
end
