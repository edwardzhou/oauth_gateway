defmodule OauthGateway.Accounts.Users.Test do
  use OauthGateway.DataCase

  alias OauthGateway.Accounts

  alias OauthGateway.ModelFactory

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
      user_attrs = attrs
      |> Enum.into(@valid_attrs)

      ModelFactory.insert(:user, user_attrs)
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

end
