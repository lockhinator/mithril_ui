defmodule Storybook.Components.Typography.Text do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Text.text/1

  def description do
    """
    Text component for paragraphs and inline text styling.
    Provides consistent text styles with control over size, weight,
    color, alignment, and decorations.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default paragraph text",
        slots: ["This is a paragraph of text that demonstrates the default styling of the text component."]
      },
      %VariationGroup{
        id: :sizes,
        description: "Text sizes",
        variations: [
          %Variation{
            id: :xs,
            attributes: %{size: :xs},
            slots: ["Extra small text"]
          },
          %Variation{
            id: :sm,
            attributes: %{size: :sm},
            slots: ["Small text"]
          },
          %Variation{
            id: :base,
            attributes: %{size: :base},
            slots: ["Base text"]
          },
          %Variation{
            id: :lg,
            attributes: %{size: :lg},
            slots: ["Large text"]
          },
          %Variation{
            id: :xl,
            attributes: %{size: :xl},
            slots: ["Extra large text"]
          }
        ]
      },
      %VariationGroup{
        id: :colors,
        description: "Text colors",
        variations: [
          %Variation{
            id: :primary,
            attributes: %{color: :primary},
            slots: ["Primary colored text"]
          },
          %Variation{
            id: :secondary,
            attributes: %{color: :secondary},
            slots: ["Secondary colored text"]
          },
          %Variation{
            id: :muted,
            attributes: %{color: :muted},
            slots: ["Muted text"]
          },
          %Variation{
            id: :success,
            attributes: %{color: :success},
            slots: ["Success text"]
          },
          %Variation{
            id: :error,
            attributes: %{color: :error},
            slots: ["Error text"]
          }
        ]
      },
      %VariationGroup{
        id: :decorations,
        description: "Text decorations",
        variations: [
          %Variation{
            id: :italic,
            attributes: %{italic: true},
            slots: ["Italic text"]
          },
          %Variation{
            id: :underline,
            attributes: %{underline: true},
            slots: ["Underlined text"]
          },
          %Variation{
            id: :strikethrough,
            attributes: %{strikethrough: true},
            slots: ["Strikethrough text"]
          },
          %Variation{
            id: :uppercase,
            attributes: %{uppercase: true},
            slots: ["Uppercase text"]
          }
        ]
      },
      %VariationGroup{
        id: :alignment,
        description: "Text alignment",
        variations: [
          %Variation{
            id: :left,
            attributes: %{align: :left, class: "w-full"},
            slots: ["Left aligned text"]
          },
          %Variation{
            id: :center,
            attributes: %{align: :center, class: "w-full"},
            slots: ["Center aligned text"]
          },
          %Variation{
            id: :right,
            attributes: %{align: :right, class: "w-full"},
            slots: ["Right aligned text"]
          }
        ]
      }
    ]
  end
end
