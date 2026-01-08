defmodule Storybook.Components.Typography.Link do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Link.styled_link/1

  def description do
    """
    Link component for styled anchor elements.
    Provides consistent link styles with support for colors, underline behaviors,
    and various visual variants including navigation and button-styled links.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default styled link",
        attributes: %{href: "#"},
        slots: ["Click here"]
      },
      %VariationGroup{
        id: :colors,
        description: "Link colors",
        variations: [
          %Variation{
            id: :primary,
            attributes: %{href: "#", color: :primary},
            slots: ["Primary link"]
          },
          %Variation{
            id: :secondary,
            attributes: %{href: "#", color: :secondary},
            slots: ["Secondary link"]
          },
          %Variation{
            id: :accent,
            attributes: %{href: "#", color: :accent},
            slots: ["Accent link"]
          },
          %Variation{
            id: :muted,
            attributes: %{href: "#", color: :muted},
            slots: ["Muted link"]
          }
        ]
      },
      %VariationGroup{
        id: :underline,
        description: "Underline behaviors",
        variations: [
          %Variation{
            id: :hover,
            attributes: %{href: "#", underline: :hover},
            slots: ["Underline on hover"]
          },
          %Variation{
            id: :always,
            attributes: %{href: "#", underline: :always},
            slots: ["Always underlined"]
          },
          %Variation{
            id: :none,
            attributes: %{href: "#", underline: :none},
            slots: ["No underline"]
          }
        ]
      },
      %Variation{
        id: :external,
        description: "External link (opens in new tab)",
        attributes: %{href: "https://example.com", external: true},
        slots: ["External site"]
      },
      %VariationGroup{
        id: :weights,
        description: "Font weights",
        variations: [
          %Variation{
            id: :normal,
            attributes: %{href: "#", weight: :normal},
            slots: ["Normal weight"]
          },
          %Variation{
            id: :medium,
            attributes: %{href: "#", weight: :medium},
            slots: ["Medium weight"]
          },
          %Variation{
            id: :bold,
            attributes: %{href: "#", weight: :bold},
            slots: ["Bold weight"]
          }
        ]
      }
    ]
  end
end
