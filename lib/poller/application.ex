defmodule Poller.Application do
  @moduledoc false

  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Poller.Repo, []),
      # Start the endpoint when the application starts
      supervisor(PollerWeb.Endpoint, []),
      # Start your own worker by calling: Poller.Worker.start_link(arg1, arg2, arg3)
      # worker(Poller.Worker, [arg1, arg2, arg3]),
      # Start our cache server which is powered by ets via a libiary called con_cache.
      supervisor(ConCache, [[], [name: :poller_cache]])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Poller.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PollerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
