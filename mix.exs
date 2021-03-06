defmodule Poller.Mixfile do
  use Mix.Project

  def project do
    [
      app: :poller,
      version: "1.0.2",
      elixir: "~> 1.5.0",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Poller.Application, []},
      extra_applications: [:logger, :runtime_tools, :con_cache, :faker]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:comeonin, "~> 4.0"},
      {:argon2_elixir, "~> 1.2"},
      {:con_cache, "~> 0.12.1"},
      {:faker, "~> 0.9"},
      {:credo, "~> 0.9.0-rc1", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.8", only: :test},
      {:distillery, "~> 1.0.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end

#  defp current_version() do
#    # get git version
#    # => returns something like: v1.0-231-g1c7ef8b
#    {description, 0} = System.cmd("git", ~w[describe])
#
#    _git_version =
#      String.trim(description)
#      |> String.split("-")
#      |> Enum.take(2)
#      |> Enum.join("+")
#      |> String.replace_leading("v", "")
#  end
end
