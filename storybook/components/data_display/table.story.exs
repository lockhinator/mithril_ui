defmodule Storybook.Components.DataDisplay.Table do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Table.table/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="w-full max-w-4xl" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :basic,
        description: "Basic table",
        variations: [
          %Variation{
            id: :default,
            attributes: %{
              id: "basic-table",
              rows: [
                %{name: "Alice", email: "alice@example.com", role: "Admin"},
                %{name: "Bob", email: "bob@example.com", role: "User"},
                %{name: "Charlie", email: "charlie@example.com", role: "User"}
              ]
            },
            slots: [
              "<:col :let={row} label=\"Name\"><%= row.name %></:col>",
              "<:col :let={row} label=\"Email\"><%= row.email %></:col>",
              "<:col :let={row} label=\"Role\"><%= row.role %></:col>"
            ]
          }
        ]
      },
      %VariationGroup{
        id: :zebra,
        description: "Zebra striped table",
        variations: [
          %Variation{
            id: :striped,
            attributes: %{
              id: "zebra-table",
              zebra: true,
              rows: [
                %{item: "Item 1", qty: 10, price: "$100"},
                %{item: "Item 2", qty: 5, price: "$50"},
                %{item: "Item 3", qty: 20, price: "$200"},
                %{item: "Item 4", qty: 15, price: "$150"}
              ]
            },
            slots: [
              "<:col :let={row} label=\"Item\"><%= row.item %></:col>",
              "<:col :let={row} label=\"Qty\"><%= row.qty %></:col>",
              "<:col :let={row} label=\"Price\"><%= row.price %></:col>"
            ]
          }
        ]
      },
      %VariationGroup{
        id: :compact,
        description: "Compact table",
        variations: [
          %Variation{
            id: :xs,
            attributes: %{
              id: "compact-table",
              compact: true,
              rows: [
                %{id: 1, status: "Active"},
                %{id: 2, status: "Pending"},
                %{id: 3, status: "Inactive"}
              ]
            },
            slots: [
              "<:col :let={row} label=\"ID\"><%= row.id %></:col>",
              "<:col :let={row} label=\"Status\"><%= row.status %></:col>"
            ]
          }
        ]
      }
    ]
  end
end
