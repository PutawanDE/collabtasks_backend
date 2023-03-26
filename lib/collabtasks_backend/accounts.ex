defmodule CollabtasksBackend.Accounts do
  import Ecto.Query, warn: false
  alias CollabtasksBackend.Repo

  alias CollabtasksBackend.User

  def list_accounts do
    Repo.all(User)
  end

  def get_account!(id), do: Repo.get!(User, id)

  def create_account(attrs \\ %{}) do
    case Repo.get_by(User, email: attrs["email"]) do
      nil ->
        %User{}
        |> User.changeset(attrs)
        |> Repo.insert()

      %User{} = user ->
        {:ok, user}
    end
  end

  def update_account(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_account(%User{} = user) do
    Repo.delete(user)
  end

  def change_account(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
