defmodule CollabtasksBackendWeb.UserJSON do
  alias CollabtasksBackend.User

  @doc """
  Renders a list of boards.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single board.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      displayName: user.displayName,
      photoUrl: user.photoUrl,
      email: user.email,
    }
  end
end
