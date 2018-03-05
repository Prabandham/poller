defmodule Poller do
  @moduledoc """
  Poller keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def current_version() do
    # get git version
    {description, 0} = System.cmd("git", ~w[describe]) # => returns something like: v1.0-231-g1c7ef8b
    _git_version = String.strip(description)
                   |> String.split("-")
                   |> Enum.take(2)
                   |> Enum.join("+")
                   |> String.replace_leading("v", "")
  end
end
