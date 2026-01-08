defmodule MithrilUI.Theme.Generator do
  @moduledoc """
  Generates DaisyUI-compatible theme CSS from Phoenix configuration.

  This module reads custom theme definitions from the application config
  and generates CSS that can be used with DaisyUI's theming system.

  ## Usage

  Define themes in your config:

      config :mithril_ui,
        themes: [
          %{
            name: "brand_light",
            label: "Brand Light",
            color_scheme: :light,
            colors: %{
              primary: "#4F46E5",
              primary_content: "#FFFFFF",
              # ... other colors
            }
          }
        ]

  Generate CSS:

      MithrilUI.Theme.Generator.generate_css()
      # => "[data-theme=\\"brand_light\\"] { ... }"

  Or use the mix task:

      mix mithril_ui.gen.themes
  """

  @doc """
  Generates CSS for all custom themes defined in config.

  Returns a string containing all theme CSS rules.
  """
  @spec generate_css() :: String.t()
  def generate_css do
    Application.get_env(:mithril_ui, :themes, [])
    |> Enum.map_join("\n\n", &theme_to_css/1)
  end

  @doc """
  Generates CSS for a single theme definition.

  ## Parameters

  - `theme` - A map containing theme configuration

  ## Example

      theme = %{
        name: "custom",
        color_scheme: :light,
        colors: %{primary: "#4F46E5"}
      }
      MithrilUI.Theme.Generator.theme_to_css(theme)
  """
  @spec theme_to_css(map()) :: String.t()
  def theme_to_css(%{name: name, colors: colors} = theme) do
    color_scheme = Map.get(theme, :color_scheme, :light)
    radius = Map.get(theme, :radius, %{})
    border = Map.get(theme, :border, "1px")
    depth = Map.get(theme, :depth, "1")
    noise = Map.get(theme, :noise, "0")

    css_vars =
      [
        colors_to_css(colors),
        radius_to_css(radius),
        effects_to_css(border, depth, noise)
      ]
      |> Enum.filter(&(&1 != ""))
      |> Enum.join("\n  ")

    """
    [data-theme="#{name}"] {
      color-scheme: #{color_scheme};
      #{css_vars}
    }
    """
    |> String.trim()
  end

  def theme_to_css(_), do: ""

  @doc """
  Writes generated CSS to the specified file path.

  Returns `:ok` on success or `{:error, reason}` on failure.
  """
  @spec write_css(String.t()) :: :ok | {:error, term()}
  def write_css(path) do
    css = generate_css()

    case File.write(path, css) do
      :ok ->
        :ok

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Returns the default output path for generated theme CSS.
  """
  @spec default_output_path() :: String.t()
  def default_output_path do
    Path.join([File.cwd!(), "priv", "static", "css", "mithril_ui_themes.css"])
  end

  # Private functions

  defp colors_to_css(colors) when is_map(colors) do
    Enum.map_join(colors, "\n  ", fn {key, value} ->
      css_var = key_to_css_var(key)
      "#{css_var}: #{value};"
    end)
  end

  defp colors_to_css(_), do: ""

  defp radius_to_css(radius) when is_map(radius) and map_size(radius) > 0 do
    Enum.map_join(radius, "\n  ", fn {key, value} ->
      "--radius-#{key}: #{value};"
    end)
  end

  defp radius_to_css(_), do: ""

  defp effects_to_css(border, depth, noise) do
    [
      "--border: #{border};",
      "--depth: #{depth};",
      "--noise: #{noise};"
    ]
    |> Enum.join("\n  ")
  end

  defp key_to_css_var(key) do
    key_str =
      key
      |> to_string()
      |> String.replace("_", "-")

    "--color-#{key_str}"
  end
end
