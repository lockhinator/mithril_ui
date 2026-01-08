defmodule MithrilUI.Theme do
  @moduledoc """
  Runtime theme management for Mithril UI.

  This module provides functions to query available themes, get the default theme,
  and generate theme metadata for UI components like theme switchers.

  ## Configuration

      # config/config.exs
      config :mithril_ui,
        default_theme: "light",
        dark_theme: "dark",
        builtin_themes: :all,  # or [:light, :dark, :corporate] or :none
        themes: [
          %{
            name: "brand_light",
            label: "Brand Light",
            extends: "light",
            color_scheme: :light,
            colors: %{
              primary: "#4F46E5",
              primary_content: "#FFFFFF"
            }
          }
        ]

  ## Built-in DaisyUI Themes

  The following 35 themes are available when `builtin_themes: :all`:

      light, dark, cupcake, bumblebee, emerald, corporate, synthwave, retro,
      cyberpunk, valentine, halloween, garden, forest, aqua, lofi, pastel,
      fantasy, wireframe, black, luxury, dracula, cmyk, autumn, business,
      acid, lemonade, night, coffee, winter, dim, nord, sunset,
      caramellatte, abyss, silk
  """

  @builtin_themes ~w(
    light dark cupcake bumblebee emerald corporate synthwave retro
    cyberpunk valentine halloween garden forest aqua lofi pastel
    fantasy wireframe black luxury dracula cmyk autumn business
    acid lemonade night coffee winter dim nord sunset
    caramellatte abyss silk
  )

  @dark_themes ~w(
    dark synthwave halloween forest aqua black luxury dracula
    night coffee dim abyss
  )

  @doc """
  Returns the list of all built-in DaisyUI theme names.
  """
  @spec builtin_themes() :: [String.t()]
  def builtin_themes, do: @builtin_themes

  @doc """
  Returns the list of all available theme names (builtin + custom).

  ## Examples

      iex> MithrilUI.Theme.available_themes()
      ["light", "dark", "cupcake", ...]
  """
  @spec available_themes() :: [String.t()]
  def available_themes do
    get_builtin_themes() ++ get_custom_theme_names()
  end

  @doc """
  Returns theme metadata for UI display (e.g., theme switcher dropdowns).

  Each theme includes:
  - `name` - The theme identifier used in `data-theme`
  - `label` - Human-readable display name
  - `color_scheme` - `:light` or `:dark`

  ## Examples

      iex> MithrilUI.Theme.theme_options()
      [
        %{name: "light", label: "Light", color_scheme: :light},
        %{name: "dark", label: "Dark", color_scheme: :dark},
        ...
      ]
  """
  @spec theme_options() :: [map()]
  def theme_options do
    available_themes()
    |> Enum.map(fn name ->
      %{
        name: name,
        label: theme_label(name),
        color_scheme: theme_color_scheme(name)
      }
    end)
  end

  @doc """
  Returns the default theme name from configuration.

  Defaults to "light" if not configured.

  ## Examples

      iex> MithrilUI.Theme.default_theme()
      "light"
  """
  @spec default_theme() :: String.t()
  def default_theme do
    Application.get_env(:mithril_ui, :default_theme, "light")
  end

  @doc """
  Returns the dark mode theme name from configuration.

  This theme is used when the user's system prefers dark mode.
  Defaults to "dark" if not configured.

  ## Examples

      iex> MithrilUI.Theme.dark_theme()
      "dark"
  """
  @spec dark_theme() :: String.t()
  def dark_theme do
    Application.get_env(:mithril_ui, :dark_theme, "dark")
  end

  @doc """
  Checks if a theme exists in the available themes.

  ## Examples

      iex> MithrilUI.Theme.theme_exists?("light")
      true

      iex> MithrilUI.Theme.theme_exists?("nonexistent")
      false
  """
  @spec theme_exists?(String.t()) :: boolean()
  def theme_exists?(name), do: name in available_themes()

  @doc """
  Returns the human-readable label for a theme.

  For builtin themes, returns a capitalized version of the name.
  For custom themes, returns the configured label or capitalized name.

  ## Examples

      iex> MithrilUI.Theme.theme_label("light")
      "Light"

      iex> MithrilUI.Theme.theme_label("cupcake")
      "Cupcake"
  """
  @spec theme_label(String.t()) :: String.t()
  def theme_label(name) do
    case get_custom_theme(name) do
      %{label: label} -> label
      nil -> name |> String.replace("_", " ") |> String.capitalize()
    end
  end

  @doc """
  Returns the color scheme (`:light` or `:dark`) for a theme.

  ## Examples

      iex> MithrilUI.Theme.theme_color_scheme("light")
      :light

      iex> MithrilUI.Theme.theme_color_scheme("dark")
      :dark
  """
  @spec theme_color_scheme(String.t()) :: :light | :dark
  def theme_color_scheme(name) do
    case get_custom_theme(name) do
      %{color_scheme: scheme} -> scheme
      nil -> if name in @dark_themes, do: :dark, else: :light
    end
  end

  @doc """
  Returns a custom theme definition by name, or nil if not found.
  """
  @spec get_custom_theme(String.t()) :: map() | nil
  def get_custom_theme(name) do
    get_custom_themes()
    |> Enum.find(&(&1[:name] == name))
  end

  # Private functions

  defp get_builtin_themes do
    case Application.get_env(:mithril_ui, :builtin_themes, :all) do
      :all -> @builtin_themes
      :none -> []
      themes when is_list(themes) -> Enum.map(themes, &to_string/1)
    end
  end

  defp get_custom_themes do
    Application.get_env(:mithril_ui, :themes, [])
  end

  defp get_custom_theme_names do
    get_custom_themes()
    |> Enum.map(& &1[:name])
    |> Enum.filter(& &1)
  end
end
