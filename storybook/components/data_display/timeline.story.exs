defmodule Storybook.Components.DataDisplay.Timeline do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Timeline.timeline/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="w-full max-w-2xl" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :basic,
        description: "Basic timeline",
        variations: [
          %Variation{
            id: :simple,
            slots: [
              "<:item time=\"2024\">First event</:item>",
              "<:item time=\"2025\">Second event</:item>",
              "<:item time=\"2026\">Third event</:item>"
            ]
          }
        ]
      },
      %VariationGroup{
        id: :with_status,
        description: "Timeline with status indicators",
        variations: [
          %Variation{
            id: :status,
            slots: [
              "<:item time=\"Jan\" title=\"Completed\" status=\"done\">This task is finished.</:item>",
              "<:item time=\"Feb\" title=\"In Progress\" status=\"current\">Currently working on this.</:item>",
              "<:item time=\"Mar\" title=\"Upcoming\" status=\"pending\">This is planned for later.</:item>"
            ]
          }
        ]
      },
      %VariationGroup{
        id: :horizontal,
        description: "Horizontal timeline",
        variations: [
          %Variation{
            id: :horiz,
            attributes: %{horizontal: true},
            slots: [
              "<:item time=\"Step 1\" status=\"done\">Complete</:item>",
              "<:item time=\"Step 2\" status=\"current\">Active</:item>",
              "<:item time=\"Step 3\">Pending</:item>"
            ]
          }
        ]
      }
    ]
  end
end
