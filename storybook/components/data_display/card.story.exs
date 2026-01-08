defmodule Storybook.Components.DataDisplay.Card do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Card.card/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 max-w-4xl" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :basic,
        description: "Basic cards",
        variations: [
          %Variation{
            id: :simple,
            slots: ["<:body>Simple card with just content.</:body>"]
          },
          %Variation{
            id: :with_title,
            slots: [
              "<:title>Card Title</:title>",
              "<:body>Card content goes here.</:body>"
            ]
          }
        ]
      },
      %VariationGroup{
        id: :with_image,
        description: "Cards with images",
        variations: [
          %Variation{
            id: :image_card,
            slots: [
              "<:figure><img src=\"https://picsum.photos/400/200\" alt=\"Random\" /></:figure>",
              "<:title>Image Card</:title>",
              "<:body>A card with an image.</:body>"
            ]
          }
        ]
      },
      %VariationGroup{
        id: :with_actions,
        description: "Cards with action buttons",
        variations: [
          %Variation{
            id: :actions,
            slots: [
              "<:title>Product</:title>",
              "<:body>Product description here.</:body>",
              "<:actions><button class=\"btn btn-primary\">Buy Now</button></:actions>"
            ]
          }
        ]
      },
      %VariationGroup{
        id: :variants,
        description: "Card style variants",
        variations: [
          %Variation{
            id: :bordered,
            attributes: %{bordered: true},
            slots: ["<:body>Bordered card</:body>"]
          },
          %Variation{
            id: :compact,
            attributes: %{compact: true},
            slots: ["<:body>Compact card with less padding</:body>"]
          },
          %Variation{
            id: :glass,
            attributes: %{glass: true},
            slots: ["<:body>Glass effect card</:body>"]
          }
        ]
      },

      # List-based class examples
      %VariationGroup{
        id: :list_classes,
        description: """
        Class attribute accepts lists for flexible conditional styling.
        Use: class={["base", @elevated && "shadow-xl", @theme == "dark" && "bg-gray-800"]}
        """,
        variations: [
          %Variation{
            id: :elevated_card,
            description: "Card with elevated shadow styling via list classes",
            attributes: %{
              class: ["shadow-2xl", "hover:shadow-3xl", "transition-shadow", "duration-300"]
            },
            slots: [
              "<:title>Elevated Card</:title>",
              "<:body>This card uses list-based class styling for enhanced shadows.</:body>"
            ]
          },
          %Variation{
            id: :gradient_card,
            description: "Card with gradient background via list classes",
            attributes: %{
              class: [
                "bg-gradient-to-br",
                "from-primary/10",
                "to-secondary/10",
                "border-none"
              ]
            },
            slots: [
              "<:title>Gradient Card</:title>",
              "<:body>Custom gradient applied through list classes.</:body>"
            ]
          },
          %Variation{
            id: :interactive_card,
            description: "Highly interactive card with multiple effects",
            attributes: %{
              class: [
                "cursor-pointer",
                "hover:scale-[1.02]",
                "hover:shadow-xl",
                "transition-all",
                "duration-200",
                "active:scale-[0.98]"
              ]
            },
            slots: [
              "<:title>Interactive Card</:title>",
              "<:body>Click me! This card has multiple hover and active states.</:body>"
            ]
          }
        ]
      }
    ]
  end
end
