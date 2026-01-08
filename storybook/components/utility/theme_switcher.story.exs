defmodule Storybook.Components.Utility.ThemeSwitcher do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.ThemeSwitcher.theme_switcher/1

  def description do
    """
    Theme switcher component for DaisyUI theme selection.
    Provides dropdown and button-based theme switching using the data-theme
    attribute. Works with the theme-change JavaScript library.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default dropdown switcher"
      },
      %Variation{
        id: :with_label,
        description: "With label",
        attributes: %{label: "Theme"}
      },
      %Variation{
        id: :limited_themes,
        description: "Limited theme selection",
        attributes: %{
          themes: ["light", "dark", "cupcake", "synthwave", "cyberpunk"]
        }
      }
    ]
  end
end
