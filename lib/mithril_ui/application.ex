defmodule MithrilUi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MithrilUiWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:mithril_ui, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MithrilUi.PubSub},
      # Start a worker by calling: MithrilUi.Worker.start_link(arg)
      # {MithrilUi.Worker, arg},
      # Start to serve requests, typically the last entry
      MithrilUiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MithrilUi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MithrilUiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
