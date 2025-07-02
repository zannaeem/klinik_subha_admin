defmodule KlinikSubhaAdmin.Booking.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "appointments" do
    field :status, :string
    field :appointment_date, :naive_datetime
    field :notes, :string
    field :patient_id, :id
    field :doctor_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:appointment_date, :status, :notes])
    |> validate_required([:appointment_date, :status, :notes])
  end
end
