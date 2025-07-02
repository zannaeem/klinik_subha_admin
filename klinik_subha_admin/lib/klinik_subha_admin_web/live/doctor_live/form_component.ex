defmodule KlinikSubhaAdminWeb.DoctorLive.FormComponent do
  use KlinikSubhaAdminWeb, :live_component

  alias KlinikSubhaAdmin.Booking

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage doctor records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="doctor-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:specialization]} type="text" label="Specialization" />
        <.input field={@form[:email]} type="text" label="Email" />
        <.input field={@form[:phone]} type="text" label="Phone" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Doctor</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{doctor: doctor} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Booking.change_doctor(doctor))
     end)}
  end

  @impl true
  def handle_event("validate", %{"doctor" => doctor_params}, socket) do
    changeset = Booking.change_doctor(socket.assigns.doctor, doctor_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"doctor" => doctor_params}, socket) do
    save_doctor(socket, socket.assigns.action, doctor_params)
  end

  defp save_doctor(socket, :edit, doctor_params) do
    case Booking.update_doctor(socket.assigns.doctor, doctor_params) do
      {:ok, doctor} ->
        notify_parent({:saved, doctor})

        {:noreply,
         socket
         |> put_flash(:info, "Doctor updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_doctor(socket, :new, doctor_params) do
    case Booking.create_doctor(doctor_params) do
      {:ok, doctor} ->
        notify_parent({:saved, doctor})

        {:noreply,
         socket
         |> put_flash(:info, "Doctor created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
