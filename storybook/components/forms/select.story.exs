defmodule Storybook.Components.Forms.Select do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Select.select/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <.form for={%{}} class="w-full space-y-6" psb-code-hidden>
      <.psb-variation-group />
    </.form>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :basic,
        description: "Basic select variations",
        variations: [
          %Variation{
            id: :default,
            description: "Basic select with tuple options",
            attributes: %{
              name: "country",
              label: "Country",
              options: [{"United States", "us"}, {"Canada", "ca"}, {"Mexico", "mx"}]
            }
          },
          %Variation{
            id: :with_prompt,
            description: "Select with placeholder prompt",
            attributes: %{
              name: "category",
              label: "Category",
              options: [{"Books", "books"}, {"Electronics", "electronics"}, {"Clothing", "clothing"}],
              prompt: "Select a category"
            }
          },
          %Variation{
            id: :with_value,
            description: "Select with pre-selected value",
            attributes: %{
              name: "role",
              label: "Role",
              options: [{"Admin", "admin"}, {"Editor", "editor"}, {"Viewer", "viewer"}],
              value: "editor"
            }
          }
        ]
      },
      %VariationGroup{
        id: :simple_options,
        description: "Simple value options",
        variations: [
          %Variation{
            id: :simple_strings,
            description: "Options as simple string values",
            attributes: %{
              name: "color",
              label: "Favorite Color",
              options: ["Red", "Green", "Blue", "Yellow", "Purple"]
            }
          }
        ]
      },
      %VariationGroup{
        id: :states,
        description: "Different states",
        variations: [
          %Variation{
            id: :disabled,
            description: "Disabled select",
            attributes: %{
              name: "disabled_select",
              label: "Disabled Select",
              options: [{"Option 1", "1"}, {"Option 2", "2"}],
              value: "1",
              disabled: true
            }
          },
          %Variation{
            id: :required,
            description: "Required select with indicator",
            attributes: %{
              name: "required_select",
              label: "Required Field",
              options: [{"Option 1", "1"}, {"Option 2", "2"}],
              prompt: "Please select",
              required: true
            }
          },
          %Variation{
            id: :with_errors,
            description: "Select with validation errors",
            attributes: %{
              id: "error_select",
              name: "error_select",
              label: "Select with Error",
              options: [{"Option 1", "1"}, {"Option 2", "2"}],
              prompt: "Please select",
              errors: ["This field is required"]
            }
          }
        ]
      },
      %Variation{
        id: :multiple,
        description: "Multiple selection",
        attributes: %{
          name: "tags[]",
          label: "Select Tags",
          options: [
            {"Elixir", "elixir"},
            {"Phoenix", "phoenix"},
            {"LiveView", "liveview"},
            {"Ecto", "ecto"},
            {"OTP", "otp"}
          ],
          value: ["elixir", "phoenix"],
          multiple: true
        }
      },
      %Variation{
        id: :with_help_text,
        description: "Select with helper text",
        attributes: %{
          id: "help_select",
          name: "timezone",
          label: "Timezone",
          options: [
            {"Pacific Time (PT)", "america/los_angeles"},
            {"Mountain Time (MT)", "america/denver"},
            {"Central Time (CT)", "america/chicago"},
            {"Eastern Time (ET)", "america/new_york"}
          ],
          prompt: "Select your timezone",
          help_text: "This will be used to display dates and times in your local timezone"
        }
      }
    ]
  end
end
