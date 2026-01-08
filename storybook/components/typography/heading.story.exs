defmodule Storybook.Components.Typography.Heading do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Heading.heading/1

  def description do
    """
    Heading component for semantic page titles and section headers.
    Provides consistent heading styles from H1 to H6 with support for colors,
    sizes, and various font weights.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default H1 heading",
        attributes: %{level: 1},
        slots: ["Page Title"]
      },
      %VariationGroup{
        id: :levels,
        description: "Heading levels H1-H6",
        variations: [
          %Variation{
            id: :h1,
            attributes: %{level: 1},
            slots: ["Heading Level 1"]
          },
          %Variation{
            id: :h2,
            attributes: %{level: 2},
            slots: ["Heading Level 2"]
          },
          %Variation{
            id: :h3,
            attributes: %{level: 3},
            slots: ["Heading Level 3"]
          },
          %Variation{
            id: :h4,
            attributes: %{level: 4},
            slots: ["Heading Level 4"]
          },
          %Variation{
            id: :h5,
            attributes: %{level: 5},
            slots: ["Heading Level 5"]
          },
          %Variation{
            id: :h6,
            attributes: %{level: 6},
            slots: ["Heading Level 6"]
          }
        ]
      },
      %VariationGroup{
        id: :colors,
        description: "Color variants",
        variations: [
          %Variation{
            id: :primary,
            attributes: %{level: 2, color: :primary},
            slots: ["Primary Heading"]
          },
          %Variation{
            id: :secondary,
            attributes: %{level: 2, color: :secondary},
            slots: ["Secondary Heading"]
          },
          %Variation{
            id: :accent,
            attributes: %{level: 2, color: :accent},
            slots: ["Accent Heading"]
          },
          %Variation{
            id: :muted,
            attributes: %{level: 2, color: :muted},
            slots: ["Muted Heading"]
          }
        ]
      },
      %VariationGroup{
        id: :weights,
        description: "Font weights",
        variations: [
          %Variation{
            id: :normal,
            attributes: %{level: 3, weight: :normal},
            slots: ["Normal Weight"]
          },
          %Variation{
            id: :medium,
            attributes: %{level: 3, weight: :medium},
            slots: ["Medium Weight"]
          },
          %Variation{
            id: :semibold,
            attributes: %{level: 3, weight: :semibold},
            slots: ["Semibold Weight"]
          },
          %Variation{
            id: :bold,
            attributes: %{level: 3, weight: :bold},
            slots: ["Bold Weight"]
          },
          %Variation{
            id: :extrabold,
            attributes: %{level: 3, weight: :extrabold},
            slots: ["Extrabold Weight"]
          }
        ]
      }
    ]
  end
end
