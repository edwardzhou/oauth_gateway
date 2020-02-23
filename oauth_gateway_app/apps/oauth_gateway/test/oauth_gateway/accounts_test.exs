defmodule OauthGateway.AccountsTest do
  use OauthGateway.DataCase

  alias OauthGateway.Accounts

  alias Accounts.Authentication

  alias OauthGateway.ModelFactory

  describe "Accounts#find_authentication" do
    @auth_id UUID.uuid4()
    @uid "123"

    test "should returns {:ok, authentication} with exists uid" do
      new_auth = ModelFactory.insert(:authentication, %{uid: @uid})
      {:ok, %Authentication{} = auth} = Accounts.find_authentication(@uid)

      assert new_auth == auth
    end

    test "should returns {:not_found, nil} with non-exist uid" do
      {:not_found, nil} = Accounts.find_authentication(@uid)      
    end
  end
end
