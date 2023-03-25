defmodule CollabtasksBackendWeb.BoardControllerTest do
  use CollabtasksBackendWeb.ConnCase

  import CollabtasksBackend.BoardsFixtures

  alias CollabtasksBackend.Boards.Board

  @create_attrs %{
    boardName: "some boardName"
  }
  @update_attrs %{
    boardName: "some updated boardName"
  }
  @invalid_attrs %{boardName: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all boards", %{conn: conn} do
      conn = get(conn, ~p"/api/boards")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create board" do
    test "renders board when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/boards", board: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/boards/#{id}")

      assert %{
               "id" => ^id,
               "boardName" => "some boardName"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/boards", board: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update board" do
    setup [:create_board]

    test "renders board when data is valid", %{conn: conn, board: %Board{id: id} = board} do
      conn = put(conn, ~p"/api/boards/#{board}", board: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/boards/#{id}")

      assert %{
               "id" => ^id,
               "boardName" => "some updated boardName"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, board: board} do
      conn = put(conn, ~p"/api/boards/#{board}", board: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete board" do
    setup [:create_board]

    test "deletes chosen board", %{conn: conn, board: board} do
      conn = delete(conn, ~p"/api/boards/#{board}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/boards/#{board}")
      end
    end
  end

  defp create_board(_) do
    board = board_fixture()
    %{board: board}
  end
end
