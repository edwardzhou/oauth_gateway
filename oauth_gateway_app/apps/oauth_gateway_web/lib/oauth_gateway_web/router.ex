defmodule OauthGatewayWeb.Router do
  use OauthGatewayWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :ueberauth do
    plug Ueberauth
  end

  scope "/", OauthGatewayWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/auth", OauthGatewayWeb do
    pipe_through [:browser, :ueberauth]

    get "/:provider", AuthenticationController, :request, as: :auth
    get "/:provider/callback", AuthenticationController, :callback, as: :auth
    post "/:provider/callback", AuthenticationController, :callback, as: :auth
  end

  # Other scopes may use custom stacks.
  # scope "/api", OauthGatewayWeb do
  #   pipe_through :api
  # end
end
