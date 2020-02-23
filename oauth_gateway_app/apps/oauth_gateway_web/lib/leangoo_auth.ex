defmodule OauthGatewayWeb.LeangooAuth do
  use Tesla

  # @LeangooAuthUrlBase System.get_env("LEANGOO_AUTH_URL_BASE")

  plug Tesla.Middleware.BaseUrl, System.get_env("LEANGOO_AUTH_URL_BASE") || "http://localhost:4100"
  plug Tesla.Middleware.Headers, [{"authorization", "token 16c9cd9e621ed0280db3dbd5ea77e139b841ac25"}]
  plug Tesla.Middleware.JSON

  def user_repos(login) do
    get("/users/" <> login <> "/repos")
  end

  def user_auth(params) do
    post("/user_auth", params)
  end

end
