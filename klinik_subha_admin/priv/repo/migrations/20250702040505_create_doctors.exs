defmodule KlinikSubhaAdmin.Repo.Migrations.CreateDoctors do
  use Ecto.Migration

  def change do
    create table(:doctors) do
      add :name, :string
      add :specialization, :string
      add :email, :string
      add :phone, :string

      timestamps(type: :utc_datetime)
    end
  end
end
