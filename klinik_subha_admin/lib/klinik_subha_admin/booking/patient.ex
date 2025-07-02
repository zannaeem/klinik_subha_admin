defmodule KlinikSubhaAdmin.Booking.Patient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "patients" do
    field :name, :string
    field :address, :string
    field :email, :string
    field :phone, :string
    field :date_of_birth, :date

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [:name, :email, :phone, :date_of_birth, :address])
    |> validate_required([:name, :email, :phone, :date_of_birth, :address])
  end
end
