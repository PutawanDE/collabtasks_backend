defmodule CollabtasksBackend.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :taskName, :startTime, :endTime, :isCompleted]}
  schema "tasks" do
    field :endTime, :utc_datetime
    field :isCompleted, :boolean, default: false
    field :startTime, :utc_datetime
    field :taskName, :string

    belongs_to :board, CollabtasksBackend.Board
    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:board_id, :taskName, :startTime, :endTime, :isCompleted])
    |> validate_required([:board_id, :taskName, :startTime, :endTime, :isCompleted])
  end
end
