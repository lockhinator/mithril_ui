defmodule MithrilUi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # Only start web-related children when running the storybook locally
    # When used as a library dependency, these modules won't be available
    children = build_children()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MithrilUi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp build_children do
    []
    |> maybe_add_child(MithrilUiWeb.Telemetry)
    |> maybe_add_child(
      {DNSCluster, query: Application.get_env(:mithril_ui, :dns_cluster_query) || :ignore}
    )
    |> maybe_add_child({Phoenix.PubSub, name: MithrilUi.PubSub})
    |> maybe_add_child(MithrilUiWeb.Endpoint)
  end

  defp maybe_add_child(children, {module, _opts} = child) do
    if Code.ensure_loaded?(module) do
      children ++ [child]
    else
      children
    end
  end

  defp maybe_add_child(children, module) when is_atom(module) do
    if Code.ensure_loaded?(module) do
      children ++ [module]
    else
      children
    end
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    if Code.ensure_loaded?(MithrilUiWeb.Endpoint) do
      MithrilUiWeb.Endpoint.config_change(changed, removed)
    end

    :ok
  end
end
