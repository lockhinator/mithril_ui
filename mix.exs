defmodule MithrilUi.MixProject do
  use Mix.Project

  @version "0.1.6"
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
  end

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

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      # Core dependencies - required for component library
      {:phoenix, "~> 1.7"},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_live_view, "~> 1.0"},
      {:jason, "~> 1.2"},

      # Testing and development
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

  defp aliases do
    [
      setup: ["deps.get"],
      precommit: ["compile --warning-as-errors", "deps.unlock --unused", "format", "test"]
    ]
  end
end
