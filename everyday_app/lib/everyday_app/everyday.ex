defmodule EverydayApp.Everyday do
  @moduledoc """
  The Everyday context.
  """

  import Ecto.Query, warn: false
  alias EverydayApp.Repo
  alias EverydayApp.Training
  alias EverydayApp.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_user do
    users = Repo.all(from u in User, where: u.active)
    users
  end

  @doc """
  Gets a single day.

  Raises if the Day does not exist.

  ## Examples

      iex> get_day!(123)
      %Day{}

  """
  def get_day!(id), do: raise "TODO"

  @doc """
  Creates a day.

  ## Examples

      iex> create_day(%{field: value})
      {:ok, %Day{}}

      iex> create_day(%{field: bad_value})
      {:error, ...}

  """
  def create_day(attrs \\ %{}) do
    raise "TODO"
  end

  @doc """
  Updates a day.

  ## Examples

      iex> update_day(day, %{field: new_value})
      {:ok, %Day{}}

      iex> update_day(day, %{field: bad_value})
      {:error, ...}

  """
  def update_day(%Training{} = day, attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a Day.

  ## Examples

      iex> delete_day(day)
      {:ok, %Day{}}

      iex> delete_day(day)
      {:error, ...}

  """
  def delete_day(%Training{} = day) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking day changes.

  ## Examples

      iex> change_day(day)
      %Todo{...}

  """
  def change_day(%Training{} = day, _attrs \\ %{}) do
    raise "TODO"
  end
end
