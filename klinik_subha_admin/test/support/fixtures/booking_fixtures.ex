defmodule KlinikSubhaAdmin.BookingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KlinikSubhaAdmin.Booking` context.
  """

  @doc """
  Generate a patient.
  """
  def patient_fixture(attrs \\ %{}) do
    {:ok, patient} =
      attrs
      |> Enum.into(%{
        address: "some address",
        date_of_birth: ~D[2025-07-01],
        email: "some email",
        name: "some name",
        phone: "some phone"
      })
      |> KlinikSubhaAdmin.Booking.create_patient()

    patient
  end

  @doc """
  Generate a doctor.
  """
  def doctor_fixture(attrs \\ %{}) do
    {:ok, doctor} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name",
        phone: "some phone",
        specialization: "some specialization"
      })
      |> KlinikSubhaAdmin.Booking.create_doctor()

    doctor
  end

  @doc """
  Generate a appointment.
  """
  def appointment_fixture(attrs \\ %{}) do
    {:ok, appointment} =
      attrs
      |> Enum.into(%{
        appointment_date: ~N[2025-07-01 04:05:00],
        notes: "some notes",
        status: "some status"
      })
      |> KlinikSubhaAdmin.Booking.create_appointment()

    appointment
  end
end
