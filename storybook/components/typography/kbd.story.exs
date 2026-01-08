defmodule Storybook.Components.Typography.Kbd do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Kbd.kbd/1

  def description do
    """
    Keyboard component for displaying keyboard keys and shortcuts.
    Used in documentation and help content to show keyboard shortcuts
    and key combinations.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Single key",
        slots: ["Enter"]
      },
      %VariationGroup{
        id: :sizes,
        description: "Key sizes",
        variations: [
          %Variation{
            id: :xs,
            attributes: %{size: :xs},
            slots: ["Esc"]
          },
          %Variation{
            id: :sm,
            attributes: %{size: :sm},
            slots: ["Esc"]
          },
          %Variation{
            id: :md,
            attributes: %{size: :md},
            slots: ["Esc"]
          },
          %Variation{
            id: :lg,
            attributes: %{size: :lg},
            slots: ["Esc"]
          }
        ]
      },
      %VariationGroup{
        id: :common_keys,
        description: "Common keys",
        variations: [
          %Variation{
            id: :ctrl,
            slots: ["Ctrl"]
          },
          %Variation{
            id: :alt,
            slots: ["Alt"]
          },
          %Variation{
            id: :shift,
            slots: ["Shift"]
          },
          %Variation{
            id: :cmd,
            slots: ["Cmd"]
          },
          %Variation{
            id: :tab,
            slots: ["Tab"]
          },
          %Variation{
            id: :space,
            slots: ["Space"]
          }
        ]
      }
    ]
  end
end
