defmodule KlinikSubhaAdminWeb.Telemetry do
  use Supervisor
  import Telemetry.Metrics

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    metrics = [
      summary("phoenix.endpoint.stop.duration", unit: {:native, :millisecond}),
      summary("phoenix.router_dispatch.stop.duration", tags: [:route], unit: {:native, :millisecond}),
      summary("phoenix.live_view.mount.stop.duration", unit: {:native, :millisecond}),
      summary("phoenix.live_view.handle_event.stop.duration", unit: {:native, :millisecond}),
      summary("phoenix.live_view.handle_params.stop.duration", unit: {:native, :millisecond}),
      summary("phoenix.live_view.handle_info.stop.duration", unit: {:native, :millisecond}),
      summary("phoenix.live_component.handle_event.stop.duration", unit: {:native, :millisecond}),
      summary("phoenix.live_component.handle_info.stop.duration", unit: {:native, :millisecond}),
      summary("db.query.total_time", unit: {:native, :millisecond}),
      summary("db.query.decode_time", unit: {:native, :millisecond}),
      summary("db.query.query_time", unit: {:native, :millisecond}),
      summary("db.query.queue_time", unit: {:native, :millisecond}),
      summary("db.query.idle_time", unit: {:native, :millisecond})
    ]

    children = [
      {Telemetry.Metrics.ConsoleReporter, metrics: metrics}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
