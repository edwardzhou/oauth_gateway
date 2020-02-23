defmodule OauthGateway.Authenticator do
  @moduledoc """
  OAuth授权登录校验处理
  """

  alias OauthGateway.Accounts

  @doc """
  授权登录
  """
  def authenticate(%{uid: uid} = auth_attrs) do
    case Accounts.find_authentication(uid) do
      {:not_found, _} ->
        union_id = auth_attrs.union_id
        {_, prior_auth} = Accounts.find_authentication(union_id: union_id)
        {:ok, new_auth} = Accounts.create_authentication(auth_attrs)

        {:ok, user} = user_from_auth(new_auth, prior_auth)

        {:ok, new_auth} =
          Accounts.update_authentication(
            new_auth,
            %{user_id: user.id}
          )

        {:ok, new_auth, user}

      {:ok, auth} ->
        {:ok, user} =
          auth.user_id
          |> Accounts.get_user!()
          |> Accounts.update_user(%{avatar_url: auth_attrs.image})

        {:ok, updated_auth} =
          auth
          |> Accounts.update_authentication(auth_attrs)
        {:ok, updated_auth, user}
    end
  end

  def user_from_auth(%{email: nil} = auth, nil) do
    new_user_from_auth(auth)
  end

  def user_from_auth(%{email: ""} = auth, nil) do
    new_user_from_auth(auth)
  end

  def user_from_auth(auth, nil) do
    case Accounts.get_user_by_email(auth.email) do
      {:ok, _user} = result -> result
      _ -> new_user_from_auth(auth)
    end
  end

  def user_from_auth(auth, prior_auth) do
    {:ok, Accounts.get_user!(prior_auth.user_id)}
  end

  def new_user_from_auth(auth) do
    Accounts.create_user(%{
      nickname: auth.nickname,
      phone: auth.phone,
      avatar_url: auth.image,
      email: Map.get(auth, :email),
      password: "default",
      password_salt: "salt"
    })
  end

end
