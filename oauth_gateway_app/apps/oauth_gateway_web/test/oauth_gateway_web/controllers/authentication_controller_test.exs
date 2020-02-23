defmodule OauthGatewayWeb.AuthenticationControllerTest do
  use OauthGatewayWeb.ConnCase

  alias OauthGateway.Accounts
  alias OauthGatewayWeb.Router.Helpers, as: Routes

  @auth_attrs %{
    email: "test@test.com",
    image:
      "http://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqNeOZ9Nibv3jbicE8ztp6ul1ic6S4F1bM1wPrU2iaOazL7nGbSZpIr00tom8fnqGSKP7sOanGOBvLJwQ/132",
    name: "tester",
    nickname: "tester",
    provider: "github",
    refresh_token: "some refresh_token",
    token: "some token",
    token_secret: "some token_secret",
    uid: "o4VnTwMHwR3bex-rikSbEsx2ksi4",
    union_id: "the_union_id"
  }

  @user_attrs %{
    email: "test@test.com",
    nickname: "tester",
    password: "pass",
    password_salt: "salt",
    avatar: "image"
  }

  @github_params %{
    credentials: %Ueberauth.Auth.Credentials{
      expires: false,
      expires_at: nil,
      other: %{},
      refresh_token: nil,
      scopes: [""],
      secret: nil,
      token:
        "{\"access_token\":\"6_kWAreWiyqGnPNLG5jFXOIlUDSxsNca11lfm-iisGmtQ_vSju3EUMWjsv_sIaIShCFNunpQub8KUhL08Y1RB_Gw\",\"expires_in\":7200,\"refresh_token\":\"6_Lwo_qEWptm_lNpaRhwBq-5cDdLo0dm2LIPqjFkS_By9GjOar4_9jGCSOwjMbq4dzn74_OzuEOIpilky2RaqFLg\",\"openid\":\"o4VnTwMHwR3bex-rikSbEsx2ksi4\",\"scope\":\"snsapi_userinfo\"}",
      token_type: "Bearer"
    },
    extra: %Ueberauth.Auth.Extra{
      raw_info: %{
        token: %OAuth2.AccessToken{
          access_token:
            "{\"access_token\":\"6_kWAreWiyqGnPNLG5jFXOIlUDSxsNca11lfm-iisGmtQ_vSju3EUMWjsv_sIaIShCFNunpQub8KUhL08Y1RB_Gw\",\"expires_in\":7200,\"refresh_token\":\"6_Lwo_qEWptm_lNpaRhwBq-5cDdLo0dm2LIPqjFkS_By9GjOar4_9jGCSOwjMbq4dzn74_OzuEOIpilky2RaqFLg\",\"openid\":\"o4VnTwMHwR3bex-rikSbEsx2ksi4\",\"scope\":\"snsapi_userinfo\"}",
          expires_at: nil,
          other_params: %{},
          refresh_token: nil,
          token_type: "Bearer"
        },
        user: %{
          "city" => "Shenzhen",
          "country" => "CN",
          "headimgurl" =>
            "http://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqNeOZ9Nibv3jbicE8ztp6ul1ic6S4F1bM1wPrU2iaOazL7nGbSZpIr00tom8fnqGSKP7sOanGOBvLJwQ/132",
          "language" => "zh_CN",
          "nickname" => "Edward",
          "openid" => "o4VnTwMHwR3bex-rikSbEsx2ksi4",
          "privilege" => [],
          "province" => "Guangdong",
          "sex" => 1,
          "unionid" => "the_union_id"
        }
      }
    },
    info: %Ueberauth.Auth.Info{
      description: nil,
      email: "test@test.com",
      first_name: nil,
      image:
        "http://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqNeOZ9Nibv3jbicE8ztp6ul1ic6S4F1bM1wPrU2iaOazL7nGbSZpIr00tom8fnqGSKP7sOanGOBvLJwQ/132",
      last_name: nil,
      location: nil,
      name: nil,
      nickname: "Edward",
      phone: nil,
      urls: %{}
    },
    provider: :github,
    strategy: Ueberauth.Strategy.Github,
    uid: "o4VnTwMHwR3bex-rikSbEsx2ksi4"
  }

  def fixture(:authentication, attrs) do
    {:ok, authentication} = Accounts.create_authentication(attrs)
    authentication
  end

  def fixture(:user, attrs) do
    {:ok, user} = Accounts.create_user(attrs)
    user
  end

  def fixture(:user_with_auth, auth_attrs, user_attrs) do
    auth = fixture(:authentication, auth_attrs)
    user = fixture(:user, user_attrs)

    {:ok, _auth} = Accounts.update_authentication(auth, %{user_id: user.id})

    user
    # |> Repo.preload(:authentications)
  end

  describe "new github authentication" do
    test "create new user", %{conn: conn} do
      {:not_found, nil} = Accounts.find_authentication(@github_params.uid)

      conn =
        conn
        |> assign(:ueberauth_auth, @github_params)
        |> get(Routes.auth_path(conn, :callback, :github), %{"code" => "test_code"})

      assert html_response(conn, 302)
      {:ok, _auth} = Accounts.find_authentication(@github_params.uid)
    end
  end

  describe "existing github authentication" do
    test "should return existing user", %{conn: conn} do
      existing_user = fixture(:user_with_auth, @auth_attrs, @user_attrs)

      conn =
        conn
        |> assign(:ueberauth_auth, @github_params)
        |> get(Routes.auth_path(conn, :callback, :github), %{"code" => "test_code"})

      assert html_response(conn, 302)
      assert conn.assigns[:current_user] != nil
      assert conn.assigns[:current_user].id == existing_user.id
    end
  end
end
