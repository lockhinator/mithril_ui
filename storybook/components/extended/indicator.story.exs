defmodule Storybook.Components.Extended.Indicator do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Indicator.indicator/1

  def description do
    """
    Indicator component for displaying status dots, notification badges,
    and counts on elements like buttons, avatars, and cards.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Badge indicator",
        slots: [
          "<:badge class=\"badge badge-primary\">New</:badge>",
          "<button class=\"btn\">Messages</button>"
        ]
      },
      %VariationGroup{
        id: :positions,
        description: "Indicator positions",
        variations: [
          %Variation{
            id: :top_end,
            attributes: %{vertical: "top", horizontal: "end"},
            slots: [
              "<:badge class=\"badge badge-secondary badge-xs\"></:badge>",
              "<div class=\"bg-base-300 p-4 rounded\">Top End</div>"
            ]
          },
          %Variation{
            id: :top_start,
            attributes: %{vertical: "top", horizontal: "start"},
            slots: [
              "<:badge class=\"badge badge-secondary badge-xs\"></:badge>",
              "<div class=\"bg-base-300 p-4 rounded\">Top Start</div>"
            ]
          },
          %Variation{
            id: :bottom_end,
            attributes: %{vertical: "bottom", horizontal: "end"},
            slots: [
              "<:badge class=\"badge badge-secondary badge-xs\"></:badge>",
              "<div class=\"bg-base-300 p-4 rounded\">Bottom End</div>"
            ]
          },
          %Variation{
            id: :middle_center,
            attributes: %{vertical: "middle", horizontal: "center"},
            slots: [
              "<:badge class=\"badge badge-secondary badge-xs\"></:badge>",
              "<div class=\"bg-base-300 p-4 rounded\">Middle Center</div>"
            ]
          }
        ]
      },
      %Variation{
        id: :on_button,
        description: "On button",
        slots: [
          "<:badge class=\"badge badge-sm badge-error\">99+</:badge>",
          "<button class=\"btn\">Inbox</button>"
        ]
      }
    ]
  end
end
