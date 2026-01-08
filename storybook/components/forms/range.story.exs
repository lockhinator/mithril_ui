defmodule Storybook.Components.Forms.Range do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Range.range/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default range slider",
        attributes: %{
          name: "volume",
          value: 50
        }
      },
      %Variation{
        id: :with_label,
        description: "Range with label",
        attributes: %{
          name: "brightness",
          label: "Brightness",
          value: 75
        }
      },
      %Variation{
        id: :with_value_display,
        description: "Range showing current value",
        attributes: %{
          name: "opacity",
          label: "Opacity",
          value: 80,
          show_value: true
        }
      },
      %Variation{
        id: :custom_range,
        description: "Custom min, max, step",
        attributes: %{
          name: "rating",
          label: "Rating (1-5)",
          min: 1,
          max: 5,
          step: 1,
          value: 3,
          show_value: true
        }
      },
      %Variation{
        id: :disabled,
        description: "Disabled range",
        attributes: %{
          name: "disabled_range",
          label: "Disabled",
          value: 50,
          disabled: true
        }
      },
      %Variation{
        id: :with_error,
        description: "Range with error",
        attributes: %{
          name: "error_range",
          label: "Volume",
          value: 5,
          errors: ["Must be at least 10"]
        }
      }
    ]
  end
end
