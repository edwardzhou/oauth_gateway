defmodule OauthGateway.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :nickname, :string
      add :email, :string
      add :phone, :string
      add :username, :string
      add :password_digest, :string
      add :salt, :string
      add :avatar_url, :string
      add :first_name, :string
      add :last_name, :string

      timestamps()
    end
  end
end
