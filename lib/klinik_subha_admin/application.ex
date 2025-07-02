defmodule KlinikSubhaAdmin.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      KlinikSubhaAdminWeb.Telemetry,
      KlinikSubhaAdmin.Repo,
      {DNSCluster, query: Application.get_env(:klinik_subha_admin, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: KlinikSubhaAdmin.PubSub},
      {Finch, name: KlinikSubhaAdmin.Finch},
      KlinikSubhaAdminWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: KlinikSubhaAdmin.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    KlinikSubhaAdminWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
