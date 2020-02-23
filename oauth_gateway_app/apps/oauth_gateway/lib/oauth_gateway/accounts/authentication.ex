defmodule OauthGateway.Accounts.Authentication do
  use Ecto.Schema
  import Ecto.Changeset

  alias OauthGateway.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder,
           except: [:__meta__, :user]}
  schema "authentications" do
    field :email, :string
    field :first_name, :string
    field :image, :string
    field :last_name, :string
    field :name, :string
    field :nickname, :string
    field :phone, :string
    field :provider, :string
    field :ref_user_id, :string
    field :refresh_token, :string
    field :token, :string
    field :token_secret, :string
    field :uid, :string
    field :union_id, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(authentication, attrs) do
    authentication
    |> cast(attrs, [
      :provider,
      :uid,
      :union_id,
      :nickname,
      :first_name,
      :last_name,
      :name,
      :image,
      :email,
      :phone,
      :token,
      :refresh_token,
      :token_secret,
      :user_id,
      :ref_user_id
    ])
    |> validate_required([
      :provider,
      :uid,
      :nickname,
      :token
    ])
  end
end
