defmodule SimpleMmo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SimpleMmoWeb.Telemetry,
      SimpleMmo.Repo,
      {DNSCluster, query: Application.get_env(:simple_mmo, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SimpleMmo.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: SimpleMmo.Finch},
      # Start a worker by calling: SimpleMmo.Worker.start_link(arg)
      # {SimpleMmo.Worker, arg},
      {SimpleMmo.Worker.Enemy, 20000},
      # Start to serve requests, typically the last entry
      SimpleMmoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SimpleMmo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SimpleMmoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
