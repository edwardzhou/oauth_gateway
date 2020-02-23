defmodule OauthGateway.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias OauthGateway.Repo

  alias OauthGateway.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias OauthGateway.Accounts.Authentication

  @doc """
  Returns the list of authentications.

  ## Examples

      iex> list_authentications()
      [%Authentication{}, ...]

  """
  def list_authentications do
    Repo.all(Authentication)
  end

  @doc """
  Gets a single authentication.

  Raises `Ecto.NoResultsError` if the Authentication does not exist.

  ## Examples

      iex> get_authentication!(123)
      %Authentication{}

      iex> get_authentication!(456)
      ** (Ecto.NoResultsError)

  """
  def get_authentication!(id), do: Repo.get!(Authentication, id)

  @doc """
  Creates a authentication.

  ## Examples

      iex> create_authentication(%{field: value})
      {:ok, %Authentication{}}

      iex> create_authentication(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_authentication(attrs \\ %{}) do
    %Authentication{}
    |> Authentication.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a authentication.

  ## Examples

      iex> update_authentication(authentication, %{field: new_value})
      {:ok, %Authentication{}}

      iex> update_authentication(authentication, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_authentication(%Authentication{} = authentication, attrs) do
    authentication
    |> Authentication.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a authentication.

  ## Examples

      iex> delete_authentication(authentication)
      {:ok, %Authentication{}}

      iex> delete_authentication(authentication)
      {:error, %Ecto.Changeset{}}

  """
  def delete_authentication(%Authentication{} = authentication) do
    Repo.delete(authentication)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking authentication changes.

  ## Examples

      iex> change_authentication(authentication)
      %Ecto.Changeset{source: %Authentication{}}

  """
  def change_authentication(%Authentication{} = authentication) do
    Authentication.changeset(authentication, %{})
  end

  def find_authentication("" <> uid) do
    query =
      from u in Authentication,
        where: u.uid == ^uid,
        limit: 1

    query
    |> Repo.one()
    |> wrap_result()
  end

  def wrap_result(nil), do: {:not_found, nil}
  def wrap_result(data), do: {:ok, data}
end
