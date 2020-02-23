defmodule OauthGateway.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias OauthGateway.Accounts.Authentication

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :avatar_url, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :nickname, :string
    field :password_digest, :string
    field :phone, :string
    field :salt, :string
    field :username, :string

    has_many :authentications, Authentication, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :nickname,
      :email,
      :phone,
      :username,
      :password_digest,
      :salt,
      :avatar_url,
      :first_name,
      :last_name
    ])
    |> validate_required([:nickname])
  end
end
