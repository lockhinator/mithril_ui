defmodule Storybook.Components.Typography.Blockquote do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Blockquote.blockquote/1

  def description do
    """
    Blockquote component for quoted text and testimonials.
    Provides styled quotations with support for citations, avatars,
    and various visual styles.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default blockquote",
        slots: ["The only way to do great work is to love what you do."]
      },
      %Variation{
        id: :with_citation,
        description: "Blockquote with citation",
        attributes: %{cite: "Steve Jobs"},
        slots: ["The only way to do great work is to love what you do."]
      },
      %VariationGroup{
        id: :variants,
        description: "Visual variants",
        variations: [
          %Variation{
            id: :bordered,
            attributes: %{variant: :bordered},
            slots: ["A bordered blockquote with left border accent."]
          },
          %Variation{
            id: :solid,
            attributes: %{variant: :solid},
            slots: ["A solid blockquote with background color."]
          }
        ]
      },
      %Variation{
        id: :with_icon,
        description: "With quotation icon",
        attributes: %{icon: true},
        slots: ["A quote with a decorative quotation mark icon."]
      },
      %VariationGroup{
        id: :sizes,
        description: "Text sizes",
        variations: [
          %Variation{
            id: :sm,
            attributes: %{size: :sm},
            slots: ["Small quote"]
          },
          %Variation{
            id: :lg,
            attributes: %{size: :lg},
            slots: ["Large quote"]
          },
          %Variation{
            id: :xl,
            attributes: %{size: :xl},
            slots: ["Extra large quote"]
          }
        ]
      },
      %VariationGroup{
        id: :alignment,
        description: "Text alignment",
        variations: [
          %Variation{
            id: :left,
            attributes: %{align: :left},
            slots: ["Left aligned quote"]
          },
          %Variation{
            id: :center,
            attributes: %{align: :center},
            slots: ["Center aligned quote"]
          },
          %Variation{
            id: :right,
            attributes: %{align: :right},
            slots: ["Right aligned quote"]
          }
        ]
      }
    ]
  end
end
