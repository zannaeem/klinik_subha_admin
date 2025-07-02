defmodule KlinikSubhaAdminWeb.AppointmentLive.FormComponent do
  use KlinikSubhaAdminWeb, :live_component

  alias KlinikSubhaAdmin.Booking

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage appointment records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="appointment-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:appointment_date]} type="datetime-local" label="Appointment date" />
        <.input field={@form[:status]} type="text" label="Status" />
        <.input field={@form[:notes]} type="text" label="Notes" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Appointment</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{appointment: appointment} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Booking.change_appointment(appointment))
     end)}
  end

  @impl true
  def handle_event("validate", %{"appointment" => appointment_params}, socket) do
    changeset = Booking.change_appointment(socket.assigns.appointment, appointment_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"appointment" => appointment_params}, socket) do
    save_appointment(socket, socket.assigns.action, appointment_params)
  end

  defp save_appointment(socket, :edit, appointment_params) do
    case Booking.update_appointment(socket.assigns.appointment, appointment_params) do
      {:ok, appointment} ->
        notify_parent({:saved, appointment})

        {:noreply,
         socket
         |> put_flash(:info, "Appointment updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_appointment(socket, :new, appointment_params) do
    case Booking.create_appointment(appointment_params) do
      {:ok, appointment} ->
        notify_parent({:saved, appointment})

        {:noreply,
         socket
         |> put_flash(:info, "Appointment created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
