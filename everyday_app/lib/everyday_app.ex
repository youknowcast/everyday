defmodule EverydayApp do
  @moduledoc """
  EverydayApp keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @doc """
  Returns current env in [:dev, :prod, :test]
  """
  def env do
    Application.fetch_env!(:everyday_app, :env)
  end
end
