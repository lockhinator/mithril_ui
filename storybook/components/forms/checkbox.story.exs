defmodule Storybook.Components.Forms.Checkbox do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Checkbox.checkbox/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default checkbox",
        attributes: %{
          name: "terms",
          label: "I agree to the terms and conditions"
        }
      },
      %Variation{
        id: :checked,
        description: "Pre-checked checkbox",
        attributes: %{
          name: "subscribe",
          label: "Subscribe to newsletter",
          checked: true
        }
      },
      %Variation{
        id: :disabled,
        description: "Disabled checkbox",
        attributes: %{
          name: "locked",
          label: "This option is locked",
          disabled: true
        }
      },
      %Variation{
        id: :disabled_checked,
        description: "Disabled and checked",
        attributes: %{
          name: "required_option",
          label: "Required option (always enabled)",
          checked: true,
          disabled: true
        }
      },
      %Variation{
        id: :with_error,
        description: "Checkbox with error",
        attributes: %{
          name: "agreement",
          label: "I accept the privacy policy",
          errors: ["You must accept the privacy policy"]
        }
      },
      %VariationGroup{
        id: :multiple_options,
        description: "Multiple checkboxes for selection",
        variations: [
          %Variation{
            id: :option_email,
            attributes: %{
              name: "notifications[email]",
              label: "Email notifications",
              checked: true
            }
          },
          %Variation{
            id: :option_sms,
            attributes: %{
              name: "notifications[sms]",
              label: "SMS notifications"
            }
          },
          %Variation{
            id: :option_push,
            attributes: %{
              name: "notifications[push]",
              label: "Push notifications",
              checked: true
            }
          }
        ]
      }
    ]
  end
end
