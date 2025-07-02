defmodule KlinikSubhaAdminWeb.DoctorLive.Show do
  use KlinikSubhaAdminWeb, :live_view

  alias KlinikSubhaAdmin.Booking

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:doctor, Booking.get_doctor!(id))}
  end

  defp page_title(:show), do: "Show Doctor"
  defp page_title(:edit), do: "Edit Doctor"
end
