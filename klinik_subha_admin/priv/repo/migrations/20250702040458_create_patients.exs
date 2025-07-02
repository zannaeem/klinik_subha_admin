defmodule KlinikSubhaAdmin.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :name, :string
      add :email, :string
      add :phone, :string
      add :date_of_birth, :date
      add :address, :text

      timestamps(type: :utc_datetime)
    end
  end
end
