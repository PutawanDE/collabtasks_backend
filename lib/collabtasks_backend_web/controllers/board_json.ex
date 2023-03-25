defmodule CollabtasksBackendWeb.BoardJSON do
  alias CollabtasksBackend.Board

  @doc """
  Renders a list of boards.
  """
  def index(%{boards: boards}) do
    %{data: for(board <- boards, do: data(board))}
  end

  @doc """
  Renders a single board.
  """
  def show(%{board: board}) do
    %{data: data(board)}
  end

  defp data(%Board{} = board) do
    %{
      id: board.id,
      boardName: board.boardName,
    }
  end
end
