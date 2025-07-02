defmodule KlinikSubhaAdmin.Booking.Doctor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "doctors" do
    field :name, :string
    field :specialization, :string
    field :email, :string
    field :phone, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(doctor, attrs) do
    doctor
    |> cast(attrs, [:name, :specialization, :email, :phone])
    |> validate_required([:name, :specialization, :email, :phone])
  end
end
