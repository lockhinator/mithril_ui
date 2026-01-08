defmodule Storybook.Components.DataDisplay.ListGroup do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.ListGroup.list_group/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="flex flex-col gap-6 max-w-md" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :basic,
        description: "Basic list groups",
        variations: [
          %Variation{
            id: :simple,
            slots: [
              "<:item>Item 1</:item>",
              "<:item>Item 2</:item>",
              "<:item>Item 3</:item>"
            ]
          },
          %Variation{
            id: :with_title,
            slots: [
              "<:title>Menu</:title>",
              "<:item>Dashboard</:item>",
              "<:item>Settings</:item>",
              "<:item>Profile</:item>"
            ]
          }
        ]
      },
      %VariationGroup{
        id: :states,
        description: "Item states",
        variations: [
          %Variation{
            id: :active,
            slots: [
              "<:item>Normal</:item>",
              "<:item active>Active Item</:item>",
              "<:item>Normal</:item>"
            ]
          },
          %Variation{
            id: :disabled,
            slots: [
              "<:item>Enabled</:item>",
              "<:item disabled>Disabled Item</:item>",
              "<:item>Enabled</:item>"
            ]
          }
        ]
      },
      %VariationGroup{
        id: :variants,
        description: "List group variants",
        variations: [
          %Variation{
            id: :not_bordered,
            attributes: %{bordered: false},
            slots: [
              "<:item>No border</:item>",
              "<:item>List items</:item>"
            ]
          },
          %Variation{
            id: :horizontal,
            attributes: %{horizontal: true},
            slots: [
              "<:item>One</:item>",
              "<:item>Two</:item>",
              "<:item>Three</:item>"
            ]
          }
        ]
      }
    ]
  end
end
