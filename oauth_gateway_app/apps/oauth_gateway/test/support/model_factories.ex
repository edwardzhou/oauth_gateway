defmodule OauthGateway.ModelFactory do
  use ExMachina.Ecto, repo: OauthGateway.Repo

  alias OauthGateway.Accounts.{Users, Authentications}
  alias OauthGateway.Repo
  alias OauthGateway.Factories

  use Factories.UserFactory
  use Factories.AuthenticationFactory

  def clear_database("true") do
    Repo.delete_all(Authentications)
    Repo.delete_all(Users)
  end

  def clear_database(models) when is_list(models) do
    models
    |> Enum.each(&Repo.delete_all/1)
  end

  def clear_database(_), do: nil
end
