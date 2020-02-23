defmodule OauthGateway.AccountsTest do
  use OauthGateway.DataCase

  alias OauthGateway.Accounts

  describe "users" do
    alias OauthGateway.Accounts.User

    @valid_attrs %{
      avatar_url: "some avatar_url",
      email: "some email",
      first_name: "some first_name",
      last_name: "some last_name",
      nickname: "some nickname",
      password_digest: "some password_digest",
      phone: "some phone",
      salt: "some salt",
      username: "some username"
    }
    @update_attrs %{
      avatar_url: "some updated avatar_url",
      email: "some updated email",
      first_name: "some updated first_name",
      last_name: "some updated last_name",
      nickname: "some updated nickname",
      password_digest: "some updated password_digest",
      phone: "some updated phone",
      salt: "some updated salt",
      username: "some updated username"
    }
    @invalid_attrs %{
      avatar_url: nil,
      email: nil,
      first_name: nil,
      last_name: nil,
      nickname: nil,
      password_digest: nil,
      phone: nil,
      salt: nil,
      username: nil
    }

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.avatar_url == "some avatar_url"
      assert user.email == "some email"
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.nickname == "some nickname"
      assert user.password_digest == "some password_digest"
      assert user.phone == "some phone"
      assert user.salt == "some salt"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.avatar_url == "some updated avatar_url"
      assert user.email == "some updated email"
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.nickname == "some updated nickname"
      assert user.password_digest == "some updated password_digest"
      assert user.phone == "some updated phone"
      assert user.salt == "some updated salt"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "authentications" do
    alias OauthGateway.Accounts.Authentication

    @new_user_id UUID.uuid4()
    @updated_user_id UUID.uuid4()

    @valid_attrs %{
      email: "some email",
      first_name: "some first_name",
      image: "some image",
      last_name: "some last_name",
      name: "some name",
      nickname: "some nickname",
      phone: "some phone",
      provider: "some provider",
      ref_user_id: "some ref_user_id",
      refresh_token: "some refresh_token",
      token: "some token",
      token_secret: "some token_secret",
      uid: "some uid",
      union_id: "some union_id",
      user_id: @new_user_id
    }
    @update_attrs %{
      email: "some updated email",
      first_name: "some updated first_name",
      image: "some updated image",
      last_name: "some updated last_name",
      name: "some updated name",
      nickname: "some updated nickname",
      phone: "some updated phone",
      provider: "some updated provider",
      ref_user_id: "some updated ref_user_id",
      refresh_token: "some updated refresh_token",
      token: "some updated token",
      token_secret: "some updated token_secret",
      uid: "some updated uid",
      union_id: "some updated union_id",
      user_id: @updated_user_id
    }
    @invalid_attrs %{
      email: nil,
      first_name: nil,
      image: nil,
      last_name: nil,
      name: nil,
      nickname: nil,
      phone: nil,
      provider: nil,
      ref_user_id: nil,
      refresh_token: nil,
      token: nil,
      token_secret: nil,
      uid: nil,
      union_id: nil,
      user_id: nil
    }

    def authentication_fixture(attrs \\ %{}) do
      {:ok, authentication} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_authentication()

      authentication
    end

    test "list_authentications/0 returns all authentications" do
      authentication = authentication_fixture()
      assert Accounts.list_authentications() == [authentication]
    end

    test "get_authentication!/1 returns the authentication with given id" do
      authentication = authentication_fixture()
      assert Accounts.get_authentication!(authentication.id) == authentication
    end

    test "create_authentication/1 with valid data creates a authentication" do
      assert {:ok, %Authentication{} = authentication} =
               Accounts.create_authentication(@valid_attrs)

      assert authentication.email == "some email"
      assert authentication.first_name == "some first_name"
      assert authentication.image == "some image"
      assert authentication.last_name == "some last_name"
      assert authentication.name == "some name"
      assert authentication.nickname == "some nickname"
      assert authentication.phone == "some phone"
      assert authentication.provider == "some provider"
      assert authentication.ref_user_id == "some ref_user_id"
      assert authentication.refresh_token == "some refresh_token"
      assert authentication.token == "some token"
      assert authentication.token_secret == "some token_secret"
      assert authentication.uid == "some uid"
      assert authentication.union_id == "some union_id"
      assert authentication.user_id == @new_user_id
    end

    test "create_authentication/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_authentication(@invalid_attrs)
    end

    test "update_authentication/2 with valid data updates the authentication" do
      authentication = authentication_fixture()

      assert {:ok, %Authentication{} = authentication} =
               Accounts.update_authentication(authentication, @update_attrs)

      assert authentication.email == "some updated email"
      assert authentication.first_name == "some updated first_name"
      assert authentication.image == "some updated image"
      assert authentication.last_name == "some updated last_name"
      assert authentication.name == "some updated name"
      assert authentication.nickname == "some updated nickname"
      assert authentication.phone == "some updated phone"
      assert authentication.provider == "some updated provider"
      assert authentication.ref_user_id == "some updated ref_user_id"
      assert authentication.refresh_token == "some updated refresh_token"
      assert authentication.token == "some updated token"
      assert authentication.token_secret == "some updated token_secret"
      assert authentication.uid == "some updated uid"
      assert authentication.union_id == "some updated union_id"
      assert authentication.user_id == @updated_user_id
    end

    test "update_authentication/2 with invalid data returns error changeset" do
      authentication = authentication_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Accounts.update_authentication(authentication, @invalid_attrs)

      assert authentication == Accounts.get_authentication!(authentication.id)
    end

    test "delete_authentication/1 deletes the authentication" do
      authentication = authentication_fixture()
      assert {:ok, %Authentication{}} = Accounts.delete_authentication(authentication)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_authentication!(authentication.id) end
    end

    test "change_authentication/1 returns a authentication changeset" do
      authentication = authentication_fixture()
      assert %Ecto.Changeset{} = Accounts.change_authentication(authentication)
    end
  end
end
