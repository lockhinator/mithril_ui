defmodule Mix.Tasks.MithrilUi.Gen.Themes do
  @moduledoc """
  Generates CSS file from custom theme definitions.

      $ mix mithril_ui.gen.themes

  ## Options

    * `--output`, `-o` - Output file path (default: priv/static/css/mithril_ui_themes.css)
    * `--quiet`, `-q` - Suppress output messages

  ## Examples

      $ mix mithril_ui.gen.themes
      $ mix mithril_ui.gen.themes --output=assets/css/themes.css
  """

  use Mix.Task

  @shortdoc "Generates CSS from custom theme definitions"

  @impl true
  def run(args) do
    {opts, _, _} =
      OptionParser.parse(args,
        switches: [output: :string, quiet: :boolean],
        aliases: [o: :output, q: :quiet]
      )

    output_path = opts[:output] || MithrilUI.Theme.Generator.default_output_path()
    quiet = opts[:quiet] || false

    # Ensure the directory exists
    output_path
    |> Path.dirname()
    |> File.mkdir_p!()

    css = MithrilUI.Theme.Generator.generate_css()

    if css == "" do
      unless quiet do
        Mix.shell().info("""

        No custom themes defined.

        To define custom themes, add them to your config:

            config :mithril_ui,
              themes: [
                %{
                  name: "my_theme",
                  color_scheme: :light,
                  colors: %{
                    primary: "#4F46E5",
                    # ... other colors
                  }
                }
              ]
        """)
      end
    else
      File.write!(output_path, css)

      unless quiet do
        Mix.shell().info("Generated theme CSS at #{output_path}")
      end
    end
  end
end
