defmodule MessageServer.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MessageServerWeb.Telemetry,
      {Phoenix.PubSub, name: MessageServer.PubSub},
      MessageServerWeb.Endpoint,
      {Registry, keys: :unique, name: BucketRegistry},
      {DynamicSupervisor, strategy: :one_for_one, name: MessageServer.BucketSupervisor}
    ]

    opts = [strategy: :one_for_one, name: MessageServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    MessageServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
