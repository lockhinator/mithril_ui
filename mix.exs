defmodule MithrilUi.MixProject do
  use Mix.Project

  @version "0.1.4"
  @source_url "https://github.com/lockhinator/mithril_ui"

  def project do
    [
      app: :mithril_ui,
      version: @version,
      elixir: "~> 1.15",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      compilers: [:phoenix_live_view] ++ Mix.compilers(),

      # Hex.pm package metadata
      name: "Mithril UI",
      description: "A comprehensive Phoenix LiveView component library with DaisyUI theming",
      package: package(),
      docs: docs(),

      # Dialyzer
      dialyzer: [
        plt_add_apps: [:mix, :ex_unit],
        plt_file: {:no_warn, "priv/plts/project.plt"}
      ]
    ]
    |> maybe_add_listeners()
  end

  # Add Phoenix.CodeReloader listener in dev for storybook hot-reloading
  defp maybe_add_listeners(config) do
    if Mix.env() == :dev do
      Keyword.put(config, :listeners, [Phoenix.CodeReloader])
    else
      config
    end
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def cli do
    [
      preferred_envs: [precommit: :test]
    ]
  end

  # Specifies which paths to compile per environment.
  # Only compile the web/storybook parts in dev/test where dependencies are available
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(:dev), do: ["lib"]
  defp elixirc_paths(_), do: ["lib/mithril_ui", "lib/mix"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # Core dependencies - required for component library
      {:phoenix, "~> 1.7"},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_live_view, "~> 1.0"},
      {:jason, "~> 1.2"},

      # Storybook & Dev Server - not needed by library users
      {:phoenix_storybook, "~> 0.9.3", only: [:dev, :test]},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:esbuild, "~> 0.10", only: :dev, runtime: false},
      {:tailwind, "~> 0.3", only: :dev, runtime: false},
      {:heroicons,
       github: "tailwindlabs/heroicons",
       tag: "v2.2.0",
       sparse: "optimized",
       app: false,
       compile: false,
       depth: 1,
       only: :dev},
      {:telemetry_metrics, "~> 1.0", only: [:dev, :test]},
      {:telemetry_poller, "~> 1.0", only: [:dev, :test]},
      {:gettext, "~> 0.26", only: [:dev, :test]},
      {:dns_cluster, "~> 0.2.0", only: :dev},
      {:bandit, "~> 1.5", only: :dev},

      # Testing
      {:lazy_html, ">= 0.1.0", only: :test},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Lockhinator"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url
      },
      files: ~w(
        lib/mithril_ui/ai
        lib/mithril_ui/animations.ex
        lib/mithril_ui/components
        lib/mithril_ui/components.ex
        lib/mithril_ui/helpers.ex
        lib/mithril_ui/mcp
        lib/mithril_ui/schemas
        lib/mithril_ui/theme
        lib/mithril_ui/theme.ex
        lib/mithril_ui.ex
        lib/mix
        .formatter.exs
        mix.exs
        README.md
        LICENSE
        CHANGELOG.md
      )
    ]
  end

  defp docs do
    [
      main: "readme",
      name: "Mithril UI",
      source_ref: "v#{@version}",
      source_url: @source_url,
      extras: ["README.md", "CHANGELOG.md", "LICENSE"],
      groups_for_modules: [
        Components: ~r/MithrilUI\.Components\..*/,
        Theme: ~r/MithrilUI\.Theme.*/,
        Utilities: ~r/MithrilUI\.(Animations|Helpers)/
      ]
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "assets.setup", "assets.build"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": [
        "tailwind mithril_ui",
        "tailwind storybook",
        "esbuild mithril_ui",
        "esbuild storybook"
      ],
      "assets.deploy": [
        "tailwind mithril_ui --minify",
        "tailwind storybook --minify",
        "esbuild mithril_ui --minify",
        "esbuild storybook --minify",
        "phx.digest"
      ],
      precommit: ["compile --warning-as-errors", "deps.unlock --unused", "format", "test"]
    ]
  end
end
