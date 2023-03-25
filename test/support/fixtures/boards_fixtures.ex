defmodule CollabtasksBackend.BoardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CollabtasksBackend.Boards` context.
  """

  @doc """
  Generate a board.
  """
  def board_fixture(attrs \\ %{}) do
    {:ok, board} =
      attrs
      |> Enum.into(%{
        boardId: 42,
        boardName: "some boardName"
      })
      |> CollabtasksBackend.Boards.create_board()

    board
  end
end
