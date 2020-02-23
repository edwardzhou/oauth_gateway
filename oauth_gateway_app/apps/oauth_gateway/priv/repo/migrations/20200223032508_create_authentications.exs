defmodule OauthGateway.Repo.Migrations.CreateAuthentications do
  use Ecto.Migration

  def change do
    create table(:authentications, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :provider, :string
      add :uid, :string
      add :union_id, :string
      add :nickname, :string
      add :first_name, :string
      add :last_name, :string
      add :name, :string
      add :image, :string
      add :email, :string
      add :phone, :string
      add :token, :text
      add :refresh_token, :text
      add :token_secret, :text
      add :user_id, :binary
      add :ref_user_id, :string

      timestamps()
    end
  end
end
