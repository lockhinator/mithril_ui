defmodule Storybook.Components.Utility.ThemeToggle do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.ThemeSwitcher.theme_toggle/1

  def description do
    """
    Simple light/dark mode toggle button using DaisyUI swap component.
    Toggles between two themes with a smooth icon animation.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Light/Dark toggle"
      },
      %Variation{
        id: :custom_themes,
        description: "Custom themes",
        attributes: %{
          light_theme: "corporate",
          dark_theme: "business"
        }
      }
    ]
  end
end
