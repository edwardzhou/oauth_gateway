defmodule OauthGateway.AuthenticatorTest do
  use OauthGateway.DataCase

  alias OauthGateway.{Accounts, Authenticator}
  alias Accounts.{User, Authentication}

  @new_auth_attrs %{
    uid: "uid_001",
    provider: "github",
    name: "tester",
    nickname: "my tester",
    email: "tester@test.com",
    phone: "13100010001",
    image: "image_url",
    token: "token",
    token_secret: "token_secret",
    refresh_token: "refresh_token",
    union_id: "the_union_id"
  }

  @existing_auth_attrs %{
    uid: "uid_002",
    provider: "github",
    name: "tester2",
    nickname: "my tester2",
    email: "tester@test.com",
    phone: "13100010002",
    image: "image_url",
    token: "token",
    token_secret: "token_secret",
    refresh_token: "refresh_token",
    union_id: "the_union_id"
  }

  describe "Authenticator" do
    def fixture(:authentication) do
      {:ok, auth} = Accounts.create_authentication(@existing_auth_attrs)

      {:ok, user} =
        Accounts.create_user(%{
          nickname: auth.nickname,
          password: "password",
          password_salt: "salt",
          avatar: auth.image
        })

      {:ok, auth} = Accounts.update_authentication(auth, %{user_id: user.id})
      {:ok, auth, user}
    end

    test "authenticate/1 returns {:ok, _}" do
      {:ok, _, _} = Authenticator.authenticate(@new_auth_attrs)
    end

    test "authenticate/1 returns new authentication" do
      {:ok, %Authentication{} = auth, %User{} = user} =
        Authenticator.authenticate(@new_auth_attrs)

      assert auth.uid == "uid_001"
      assert auth.nickname == "my tester"
      assert user.nickname == "my tester"
      assert auth.user_id == user.id
    end

    test "authenticate/1 returns existing authentication" do
      {:ok, existing_auth, _user} = fixture(:authentication)

      {:ok, %Authentication{} = auth, user} = 
        @existing_auth_attrs
        |> Map.put(:image, "http://a.com/avatar_1.jpg")
        |> Authenticator.authenticate()
      assert existing_auth.id == auth.id
      assert user.avatar_url == "http://a.com/avatar_1.jpg"
    end

    test "authenticate/1 returns exisitng user with same union_id" do
      {:ok, existing_auth, existing_user} = fixture(:authentication)

      auth_attrs = Map.put(@existing_auth_attrs, :uid, "the_new_nonexist_uid")
      {:ok, %Authentication{} = auth, user} = Authenticator.authenticate(auth_attrs)
      assert existing_auth.id != auth.id
      assert auth.user_id == existing_auth.user_id
      assert user.id == existing_user.id
    end
  end
end
