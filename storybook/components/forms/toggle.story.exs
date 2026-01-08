defmodule Storybook.Components.Forms.Toggle do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Toggle.toggle/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default toggle",
        attributes: %{
          name: "notifications",
          label: "Enable notifications"
        }
      },
      %Variation{
        id: :checked,
        description: "Toggle in on state",
        attributes: %{
          name: "dark_mode",
          label: "Dark mode",
          checked: true
        }
      },
      %Variation{
        id: :without_label,
        description: "Toggle without label",
        attributes: %{
          name: "simple_toggle"
        }
      },
      %Variation{
        id: :disabled_off,
        description: "Disabled toggle (off)",
        attributes: %{
          name: "locked_off",
          label: "Feature coming soon",
          disabled: true
        }
      },
      %Variation{
        id: :disabled_on,
        description: "Disabled toggle (on)",
        attributes: %{
          name: "always_on",
          label: "Required feature",
          checked: true,
          disabled: true
        }
      },
      %Variation{
        id: :with_error,
        description: "Toggle with error",
        attributes: %{
          name: "consent",
          label: "I consent to data processing",
          errors: ["You must consent to continue"]
        }
      },
      %VariationGroup{
        id: :settings_panel,
        description: "Settings panel with multiple toggles",
        variations: [
          %Variation{
            id: :auto_save,
            attributes: %{
              name: "settings[auto_save]",
              label: "Auto-save documents",
              checked: true
            }
          },
          %Variation{
            id: :sound,
            attributes: %{
              name: "settings[sound]",
              label: "Sound effects"
            }
          },
          %Variation{
            id: :analytics,
            attributes: %{
              name: "settings[analytics]",
              label: "Share usage analytics",
              checked: true
            }
          },
          %Variation{
            id: :beta,
            attributes: %{
              name: "settings[beta]",
              label: "Enable beta features"
            }
          }
        ]
      }
    ]
  end
end
