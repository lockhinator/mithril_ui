defmodule Storybook.Components.Utility.SpeedDial do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.SpeedDial.speed_dial/1

  def description do
    """
    Speed dial component for floating action buttons with expandable menus.
    Displays a primary action button that reveals additional action buttons
    on hover.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default speed dial",
        attributes: %{id: "dial-default"},
        slots: [
          """
          <:action icon="share" label="Share" />
          <:action icon="print" label="Print" />
          <:action icon="download" label="Download" />
          """
        ]
      },
      %VariationGroup{
        id: :positions,
        description: "Position variations",
        variations: [
          %Variation{
            id: :bottom_right,
            attributes: %{id: "dial-br", position: "bottom-right"},
            slots: [
              """
              <:action icon="share" label="Share" />
              """
            ]
          },
          %Variation{
            id: :bottom_left,
            attributes: %{id: "dial-bl", position: "bottom-left"},
            slots: [
              """
              <:action icon="share" label="Share" />
              """
            ]
          }
        ]
      },
      %VariationGroup{
        id: :colors,
        description: "Color variations",
        variations: [
          %Variation{
            id: :primary,
            attributes: %{id: "dial-primary", color: "primary"},
            slots: ["<:action icon=\"share\" label=\"Share\" />"]
          },
          %Variation{
            id: :secondary,
            attributes: %{id: "dial-secondary", color: "secondary"},
            slots: ["<:action icon=\"share\" label=\"Share\" />"]
          },
          %Variation{
            id: :accent,
            attributes: %{id: "dial-accent", color: "accent"},
            slots: ["<:action icon=\"share\" label=\"Share\" />"]
          }
        ]
      }
    ]
  end
end
