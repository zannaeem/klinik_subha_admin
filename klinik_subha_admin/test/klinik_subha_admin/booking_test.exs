defmodule KlinikSubhaAdmin.BookingTest do
  use KlinikSubhaAdmin.DataCase

  alias KlinikSubhaAdmin.Booking

  describe "patients" do
    alias KlinikSubhaAdmin.Booking.Patient

    import KlinikSubhaAdmin.BookingFixtures

    @invalid_attrs %{name: nil, address: nil, email: nil, phone: nil, date_of_birth: nil}

    test "list_patients/0 returns all patients" do
      patient = patient_fixture()
      assert Booking.list_patients() == [patient]
    end

    test "get_patient!/1 returns the patient with given id" do
      patient = patient_fixture()
      assert Booking.get_patient!(patient.id) == patient
    end

    test "create_patient/1 with valid data creates a patient" do
      valid_attrs = %{name: "some name", address: "some address", email: "some email", phone: "some phone", date_of_birth: ~D[2025-07-01]}

      assert {:ok, %Patient{} = patient} = Booking.create_patient(valid_attrs)
      assert patient.name == "some name"
      assert patient.address == "some address"
      assert patient.email == "some email"
      assert patient.phone == "some phone"
      assert patient.date_of_birth == ~D[2025-07-01]
    end

    test "create_patient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Booking.create_patient(@invalid_attrs)
    end

    test "update_patient/2 with valid data updates the patient" do
      patient = patient_fixture()
      update_attrs = %{name: "some updated name", address: "some updated address", email: "some updated email", phone: "some updated phone", date_of_birth: ~D[2025-07-02]}

      assert {:ok, %Patient{} = patient} = Booking.update_patient(patient, update_attrs)
      assert patient.name == "some updated name"
      assert patient.address == "some updated address"
      assert patient.email == "some updated email"
      assert patient.phone == "some updated phone"
      assert patient.date_of_birth == ~D[2025-07-02]
    end

    test "update_patient/2 with invalid data returns error changeset" do
      patient = patient_fixture()
      assert {:error, %Ecto.Changeset{}} = Booking.update_patient(patient, @invalid_attrs)
      assert patient == Booking.get_patient!(patient.id)
    end

    test "delete_patient/1 deletes the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{}} = Booking.delete_patient(patient)
      assert_raise Ecto.NoResultsError, fn -> Booking.get_patient!(patient.id) end
    end

    test "change_patient/1 returns a patient changeset" do
      patient = patient_fixture()
      assert %Ecto.Changeset{} = Booking.change_patient(patient)
    end
  end

  describe "doctors" do
    alias KlinikSubhaAdmin.Booking.Doctor

    import KlinikSubhaAdmin.BookingFixtures

    @invalid_attrs %{name: nil, specialization: nil, email: nil, phone: nil}

    test "list_doctors/0 returns all doctors" do
      doctor = doctor_fixture()
      assert Booking.list_doctors() == [doctor]
    end

    test "get_doctor!/1 returns the doctor with given id" do
      doctor = doctor_fixture()
      assert Booking.get_doctor!(doctor.id) == doctor
    end

    test "create_doctor/1 with valid data creates a doctor" do
      valid_attrs = %{name: "some name", specialization: "some specialization", email: "some email", phone: "some phone"}

      assert {:ok, %Doctor{} = doctor} = Booking.create_doctor(valid_attrs)
      assert doctor.name == "some name"
      assert doctor.specialization == "some specialization"
      assert doctor.email == "some email"
      assert doctor.phone == "some phone"
    end

    test "create_doctor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Booking.create_doctor(@invalid_attrs)
    end

    test "update_doctor/2 with valid data updates the doctor" do
      doctor = doctor_fixture()
      update_attrs = %{name: "some updated name", specialization: "some updated specialization", email: "some updated email", phone: "some updated phone"}

      assert {:ok, %Doctor{} = doctor} = Booking.update_doctor(doctor, update_attrs)
      assert doctor.name == "some updated name"
      assert doctor.specialization == "some updated specialization"
      assert doctor.email == "some updated email"
      assert doctor.phone == "some updated phone"
    end

    test "update_doctor/2 with invalid data returns error changeset" do
      doctor = doctor_fixture()
      assert {:error, %Ecto.Changeset{}} = Booking.update_doctor(doctor, @invalid_attrs)
      assert doctor == Booking.get_doctor!(doctor.id)
    end

    test "delete_doctor/1 deletes the doctor" do
      doctor = doctor_fixture()
      assert {:ok, %Doctor{}} = Booking.delete_doctor(doctor)
      assert_raise Ecto.NoResultsError, fn -> Booking.get_doctor!(doctor.id) end
    end

    test "change_doctor/1 returns a doctor changeset" do
      doctor = doctor_fixture()
      assert %Ecto.Changeset{} = Booking.change_doctor(doctor)
    end
  end

  describe "appointments" do
    alias KlinikSubhaAdmin.Booking.Appointment

    import KlinikSubhaAdmin.BookingFixtures

    @invalid_attrs %{status: nil, appointment_date: nil, notes: nil}

    test "list_appointments/0 returns all appointments" do
      appointment = appointment_fixture()
      assert Booking.list_appointments() == [appointment]
    end

    test "get_appointment!/1 returns the appointment with given id" do
      appointment = appointment_fixture()
      assert Booking.get_appointment!(appointment.id) == appointment
    end

    test "create_appointment/1 with valid data creates a appointment" do
      valid_attrs = %{status: "some status", appointment_date: ~N[2025-07-01 04:05:00], notes: "some notes"}

      assert {:ok, %Appointment{} = appointment} = Booking.create_appointment(valid_attrs)
      assert appointment.status == "some status"
      assert appointment.appointment_date == ~N[2025-07-01 04:05:00]
      assert appointment.notes == "some notes"
    end

    test "create_appointment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Booking.create_appointment(@invalid_attrs)
    end

    test "update_appointment/2 with valid data updates the appointment" do
      appointment = appointment_fixture()
      update_attrs = %{status: "some updated status", appointment_date: ~N[2025-07-02 04:05:00], notes: "some updated notes"}

      assert {:ok, %Appointment{} = appointment} = Booking.update_appointment(appointment, update_attrs)
      assert appointment.status == "some updated status"
      assert appointment.appointment_date == ~N[2025-07-02 04:05:00]
      assert appointment.notes == "some updated notes"
    end

    test "update_appointment/2 with invalid data returns error changeset" do
      appointment = appointment_fixture()
      assert {:error, %Ecto.Changeset{}} = Booking.update_appointment(appointment, @invalid_attrs)
      assert appointment == Booking.get_appointment!(appointment.id)
    end

    test "delete_appointment/1 deletes the appointment" do
      appointment = appointment_fixture()
      assert {:ok, %Appointment{}} = Booking.delete_appointment(appointment)
      assert_raise Ecto.NoResultsError, fn -> Booking.get_appointment!(appointment.id) end
    end

    test "change_appointment/1 returns a appointment changeset" do
      appointment = appointment_fixture()
      assert %Ecto.Changeset{} = Booking.change_appointment(appointment)
    end
  end
end
