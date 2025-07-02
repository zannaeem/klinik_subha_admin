defmodule KlinikSubhaAdminWeb.PatientLive.Index do
  use KlinikSubhaAdminWeb, :live_view

  alias KlinikSubhaAdmin.Booking
  alias KlinikSubhaAdmin.Booking.Patient

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :patients, Booking.list_patients())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Patient")
    |> assign(:patient, Booking.get_patient!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Patient")
    |> assign(:patient, %Patient{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Patients")
    |> assign(:patient, nil)
  end

  @impl true
  def handle_info({KlinikSubhaAdminWeb.PatientLive.FormComponent, {:saved, patient}}, socket) do
    {:noreply, stream_insert(socket, :patients, patient)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    patient = Booking.get_patient!(id)
    {:ok, _} = Booking.delete_patient(patient)

    {:noreply, stream_delete(socket, :patients, patient)}
  end
end
