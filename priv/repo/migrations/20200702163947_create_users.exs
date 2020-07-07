defmodule LetInv.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :password_hash, :string
      add :mobile_no, :string, null: false
      add :is_admin, :boolean, default: false, null: false
      add :provider, :string, null: true
      add :email_verified, :string, default: false
      add :role, :integer, default: 1
      add :dob, :utc_datetime, null: true
      add :avata, :string, null: true
      add :bvn, :string, null: true

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
