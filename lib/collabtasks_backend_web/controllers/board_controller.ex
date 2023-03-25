defmodule CollabtasksBackendWeb.BoardController do
  use CollabtasksBackendWeb, :controller

  alias CollabtasksBackend.UserBoards
  alias CollabtasksBackend.Board

  action_fallback CollabtasksBackendWeb.FallbackController

  def index(conn, _params) do
    boards = UserBoards.list_boards()
    render(conn, :index, boards: boards)
  end

  def create(conn, %{"board" => board_params}) do
    with {:ok, %Board{} = board} <- UserBoards.create_board(board_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/boards/#{board}")
      |> render(:show, board: board)
    end
  end

  def show(conn, %{"id" => userId}) do
    boards = UserBoards.list_user_boards(userId)
    render(conn, :index, boards: boards)
  end

  def update(conn, %{"id" => id, "board" => board_params}) do
    board = UserBoards.get_board!(id)

    with {:ok, %Board{} = board} <- UserBoards.update_board(board, board_params) do
      render(conn, :show, board: board)
    end
  end

  def delete(conn, %{"id" => id}) do
    board = UserBoards.get_board!(id)

    with {:ok, %Board{}} <- UserBoards.delete_board(board) do
      send_resp(conn, :no_content, "")
    end
  end
end
