defmodule OauthGatewayWeb.AuthenticationController do
  use OauthGatewayWeb, :controller
  alias OauthGateway.Authenticator

  def remote_authenticator() do
    Application.get_env(:oauth_gateway_web, :remote_authenticator) || OauthGatewayWeb.LeangooAuth
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    {:ok, authentication, user} =
      auth
      # |> IO.inspect(label: "[OauthGatewayWeb.AuthenticationController] callback auth", pretty: true)
      |> auth_params()
      # |> IO.inspect(label: "[OauthGatewayWeb.AuthenticationController] auth_params", pretty: true)
      |> Authenticator.authenticate()

    conn
    |> assign(:current_user, user)
    |> forward_authentication(authentication, auth, params)
  end

  def callback(%{assigns: %{} = auth} = conn, params) do
    fails = auth |> Map.get(:ueberauth_failure)
    IO.puts("ueberauth_failure: #{inspect(fails)}")

    conn
    |> put_flash(:error, "Failed to authenticate")
    |> handle_failure(auth, params)
  end

  def forward_authentication(conn, authentication, auth, params) do
    {:ok, response} = remote_authenticator().user_auth(
      %{
        provider: auth.provider,
        authentication: authentication,
        params: params
      }
    )
    |> IO.inspect(label: "leangooAuth response ", pretty: true)

    conn
    |> handle_response(response)
  end

  def handle_failure(conn, auth, _) do
    conn
    |> json(auth[:errors])
  end

  # def handle_response(conn, _, user, params) do
  #   # {:ok, token, _full_claims} = Guardian.encode_and_sign(user)
  #   state = params["state"]
  #   url = "#{state}?token=token_abc"
  #   conn
  #   |> redirect(external: url)
  # end

  def handle_response(conn, %{body: resp_body}) do
    conn
    |> redirect(external: resp_body["url"])
  end

  def auth_params(%{provider: :github} = auth) do
    %{
      uid: to_string(auth.uid),
      name: auth.info.name || auth.info.nickname,
      nickname: auth.info.nickname,
      image: auth.info.image,
      provider: to_string(auth.provider),
      strategy: to_string(auth.strategy),
      union_id: "",
      token: auth.credentials.token,
      refresh_token: auth.credentials.refresh_token,
      token_secret: auth.credentials.secret
    }
  end

  def auth_params(%{provider: :feishu} = auth) do
    %{
      uid: to_string(auth.uid),
      name: auth.info.name || auth.info.nickname,
      nickname: auth.info.nickname,
      email: auth.info.email,
      image: auth.info.image,
      provider: to_string(auth.provider),
      strategy: to_string(auth.strategy),
      union_id: "",
      token: auth.credentials.token,
      refresh_token: auth.credentials.refresh_token,
      token_secret: auth.credentials.secret
    }
  end
end
