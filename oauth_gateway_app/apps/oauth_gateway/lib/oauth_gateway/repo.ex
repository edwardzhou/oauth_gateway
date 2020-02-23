defmodule OauthGateway.Repo do
  use Ecto.Repo,
    otp_app: :oauth_gateway,
    adapter: Ecto.Adapters.Postgres
end
