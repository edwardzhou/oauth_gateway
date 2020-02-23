defmodule OauthGateway.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      OauthGateway.Repo
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: OauthGateway.Supervisor)
  end
end
