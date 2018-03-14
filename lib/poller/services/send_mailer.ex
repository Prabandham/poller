defmodule Poller.Services do
  alias Poller.{Auth.User, Repo}

  @moduledoc """
  Poller Services are set of services that will perform things like API calls
  or send mails or do a background clean up etc.

  Genrally long running things or things that might break like external service interaction can be done in here.
  """

  def send_invite_code(user_id) do
    User
    |> Repo.get_by(id: user_id)

    # TODO send mail
  end
end
