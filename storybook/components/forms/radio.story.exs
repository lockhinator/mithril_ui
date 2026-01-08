defmodule Storybook.Components.Forms.Radio do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Radio.radio/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Single radio button",
        attributes: %{
          name: "option",
          value: "first",
          label: "First option"
        }
      },
      %Variation{
        id: :checked,
        description: "Pre-selected radio",
        attributes: %{
          name: "selected",
          value: "selected",
          label: "Selected option",
          checked: true
        }
      },
      %Variation{
        id: :disabled,
        description: "Disabled radio",
        attributes: %{
          name: "disabled_option",
          value: "disabled",
          label: "Disabled option",
          disabled: true
        }
      },
      %VariationGroup{
        id: :plan_selection,
        description: "Radio group for plan selection",
        variations: [
          %Variation{
            id: :basic,
            attributes: %{
              name: "plan",
              value: "basic",
              label: "Basic - Free"
            }
          },
          %Variation{
            id: :pro,
            attributes: %{
              name: "plan",
              value: "pro",
              label: "Pro - $9/month",
              checked: true
            }
          },
          %Variation{
            id: :enterprise,
            attributes: %{
              name: "plan",
              value: "enterprise",
              label: "Enterprise - Contact us"
            }
          }
        ]
      },
      %VariationGroup{
        id: :size_selection,
        description: "Radio group for size selection",
        variations: [
          %Variation{
            id: :small,
            attributes: %{
              name: "size",
              value: "small",
              label: "Small"
            }
          },
          %Variation{
            id: :medium,
            attributes: %{
              name: "size",
              value: "medium",
              label: "Medium",
              checked: true
            }
          },
          %Variation{
            id: :large,
            attributes: %{
              name: "size",
              value: "large",
              label: "Large"
            }
          },
          %Variation{
            id: :xl,
            attributes: %{
              name: "size",
              value: "xl",
              label: "Extra Large",
              disabled: true
            }
          }
        ]
      }
    ]
  end
end
