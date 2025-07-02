defmodule KlinikSubhaAdminWeb.DoctorLive.Index do
  use KlinikSubhaAdminWeb, :live_view

  alias KlinikSubhaAdmin.Booking
  alias KlinikSubhaAdmin.Booking.Doctor

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :doctors, Booking.list_doctors())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Doctor")
    |> assign(:doctor, Booking.get_doctor!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Doctor")
    |> assign(:doctor, %Doctor{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Doctors")
    |> assign(:doctor, nil)
  end

  @impl true
  def handle_info({KlinikSubhaAdminWeb.DoctorLive.FormComponent, {:saved, doctor}}, socket) do
    {:noreply, stream_insert(socket, :doctors, doctor)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    doctor = Booking.get_doctor!(id)
    {:ok, _} = Booking.delete_doctor(doctor)

    {:noreply, stream_delete(socket, :doctors, doctor)}
  end
end
