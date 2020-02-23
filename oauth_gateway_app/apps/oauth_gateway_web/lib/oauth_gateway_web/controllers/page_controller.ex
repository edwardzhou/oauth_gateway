defmodule OauthGatewayWeb.PageController do
  use OauthGatewayWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
