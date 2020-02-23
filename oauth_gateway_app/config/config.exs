# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :oauth_gateway,
  ecto_repos: [OauthGateway.Repo]

config :oauth_gateway_web,
  ecto_repos: [OauthGateway.Repo],
  generators: [context_app: :oauth_gateway, binary_id: true]

# Configures the endpoint
config :oauth_gateway_web, OauthGatewayWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "U5pJLQ5UcDKIDYdam6AHRtW1mc3CrmUM/Ojb3yRQfcmoPWkSYmgTaQcQeKj0V94c",
  render_errors: [view: OauthGatewayWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: OauthGatewayWeb.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "iGfH0LdV"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
