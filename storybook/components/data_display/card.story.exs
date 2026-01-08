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
      }
    ]
  end
end
