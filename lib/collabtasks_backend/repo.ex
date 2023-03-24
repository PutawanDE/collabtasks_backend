defmodule CollabtasksBackend.Repo do
  use Ecto.Repo,
    otp_app: :collabtasks_backend,
    adapter: Ecto.Adapters.MyXQL
end
