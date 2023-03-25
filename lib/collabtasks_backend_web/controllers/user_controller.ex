defmodule CollabtasksBackendWeb.UserController do
  use CollabtasksBackendWeb, :controller

  alias CollabtasksBackend.User
  alias CollabtasksBackend.Accounts

  action_fallback CollabtasksBackendWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_account(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/accounts/#{user}")
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    account = Accounts.get_account!(id)

    with {:ok, %User{} = user} <- Accounts.update_account(account, user_params) do
      render(conn, :show, account: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %User{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
