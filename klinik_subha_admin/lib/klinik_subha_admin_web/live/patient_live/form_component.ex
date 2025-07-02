defmodule KlinikSubhaAdminWeb.PatientLive.FormComponent do
  use KlinikSubhaAdminWeb, :live_component

  alias KlinikSubhaAdmin.Booking

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage patient records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="patient-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:email]} type="text" label="Email" />
        <.input field={@form[:phone]} type="text" label="Phone" />
        <.input field={@form[:date_of_birth]} type="date" label="Date of birth" />
        <.input field={@form[:address]} type="text" label="Address" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Patient</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{patient: patient} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Booking.change_patient(patient))
     end)}
  end

  @impl true
  def handle_event("validate", %{"patient" => patient_params}, socket) do
    changeset = Booking.change_patient(socket.assigns.patient, patient_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"patient" => patient_params}, socket) do
    save_patient(socket, socket.assigns.action, patient_params)
  end

  defp save_patient(socket, :edit, patient_params) do
    case Booking.update_patient(socket.assigns.patient, patient_params) do
      {:ok, patient} ->
        notify_parent({:saved, patient})

        {:noreply,
         socket
         |> put_flash(:info, "Patient updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_patient(socket, :new, patient_params) do
    case Booking.create_patient(patient_params) do
      {:ok, patient} ->
        notify_parent({:saved, patient})

        {:noreply,
         socket
         |> put_flash(:info, "Patient created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
