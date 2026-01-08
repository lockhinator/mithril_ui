defmodule Storybook.Components.DataDisplay.Accordion do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Accordion.accordion/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="w-full max-w-lg" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :basic,
        description: "Basic accordion",
        variations: [
          %Variation{
            id: :default,
            slots: [
              "<:item title=\"Section 1\">Content for section 1. Click to expand or collapse.</:item>",
              "<:item title=\"Section 2\">Content for section 2. Each section can contain any content.</:item>",
              "<:item title=\"Section 3\">Content for section 3. Only one section is open at a time.</:item>"
            ]
          }
        ]
      },
      %VariationGroup{
        id: :icons,
        description: "Accordion icon styles",
        variations: [
          %Variation{
            id: :arrow,
            attributes: %{icon: "arrow"},
            slots: [
              "<:item title=\"Arrow Icon\">This accordion uses arrow indicators.</:item>",
              "<:item title=\"Click me\">Arrow rotates when opened.</:item>"
            ]
          },
          %Variation{
            id: :plus,
            attributes: %{icon: "plus"},
            slots: [
              "<:item title=\"Plus Icon\">This accordion uses plus/minus indicators.</:item>",
              "<:item title=\"Click me\">Plus changes to minus when open.</:item>"
            ]
          }
        ]
      },
      %VariationGroup{
        id: :open_state,
        description: "With initially open item",
        variations: [
          %Variation{
            id: :open_second,
            slots: [
              "<:item title=\"Closed\">This section starts closed.</:item>",
              "<:item title=\"Open by Default\" open>This section starts open.</:item>",
              "<:item title=\"Closed\">This section also starts closed.</:item>"
            ]
          }
        ]
      }
    ]
  end
end
