defmodule CollabtasksBackend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      CollabtasksBackendWeb.Telemetry,
      # Start the Ecto repository
      CollabtasksBackend.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: CollabtasksBackend.PubSub},
      # Start Finch
      {Finch, name: CollabtasksBackend.Finch},
      # Start the Endpoint (http/https)
      CollabtasksBackendWeb.Endpoint
      # Start a worker by calling: CollabtasksBackend.Worker.start_link(arg)
      # {CollabtasksBackend.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CollabtasksBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CollabtasksBackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
