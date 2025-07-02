defmodule KlinikSubhaAdmin.Repo.Migrations.CreateAppointments do
  use Ecto.Migration

  def change do
    create table(:appointments) do
      add :appointment_date, :naive_datetime
      add :status, :string
      add :notes, :text
      add :patient_id, references(:patients, on_delete: :nothing)
      add :doctor_id, references(:doctors, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:appointments, [:patient_id])
    create index(:appointments, [:doctor_id])
  end
end
