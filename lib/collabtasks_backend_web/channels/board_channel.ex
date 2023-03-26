defmodule CollabtasksBackendWeb.BoardChannel do
  use Phoenix.Channel
  require Logger

  def join("board:" <> _board_id, _params, socket) do
    {:ok, socket}
  end

  def handle_in("new_task", params, socket), do: handle_new_task(params, socket)
  def handle_in("update_task", params, socket), do: handle_update_task(params, socket)
  def handle_in("delete_task", params, socket), do: handle_delete_task(params, socket)

  defp task_record_struct_to_map(record) do
    record
    |> Map.from_struct()
    |> Map.delete(:__meta__)
    |> Map.delete(:board)
  end

  def handle_new_task(params, socket) do
    case add_task(params) do
      {:ok, new_task} ->
        Logger.info("Created task: #{inspect(new_task)}")
        broadcast!(socket, "new_task", task_record_struct_to_map(new_task))
        {:noreply, socket}

      {:error, changeset} ->
        Logger.error("Error creating task: #{inspect(changeset)}")
        {:noreply, socket}
    end
  end

  defp add_task(task) do
    CollabtasksBackend.Task.changeset(%CollabtasksBackend.Task{}, task)
    |> CollabtasksBackend.Repo.insert()
  end

  def handle_update_task(params, socket) do
    with {:ok, _, _} <- DateTime.from_iso8601(params["startTime"]),
         {:ok, _, _} <- DateTime.from_iso8601(params["endTime"]) do
      case update_task(params) do
        {:ok, task} ->
          Logger.info("Updated task: #{inspect(task)}")
          broadcast!(socket, "update_task", task_record_struct_to_map(task))

          {:noreply, socket}

        {:error, changeset} ->
          Logger.error("Error updating task: #{inspect(changeset)}")
          {:noreply, socket}
      end
    end
  end

  defp update_task(params) do
    CollabtasksBackend.Repo.get(CollabtasksBackend.Task, params["id"])
    |> case do
      nil ->
        {:error, "Task not found"}

      task ->
        CollabtasksBackend.Task.changeset(task, params)
        |> CollabtasksBackend.Repo.update()
    end
  end

  def handle_delete_task(params, socket) do
    case delete_task(params) do
      {:ok, task} ->
        Logger.info("Deleted task: #{inspect(task)}")
        broadcast!(socket, "delete_task", task_record_struct_to_map(task))
        {:noreply, socket}

      {:error, changeset} ->
        Logger.error("Error deleting task: #{inspect(changeset)}")
        {:noreply, socket}
    end
  end

  defp delete_task(params) do
    CollabtasksBackend.Repo.get(CollabtasksBackend.Task, params["id"])
    |> CollabtasksBackend.Repo.delete()
  end
end
