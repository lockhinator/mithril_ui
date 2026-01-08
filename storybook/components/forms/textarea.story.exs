defmodule Storybook.Components.Forms.Textarea do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Textarea.textarea/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default textarea",
        attributes: %{
          name: "description",
          placeholder: "Enter your text here..."
        }
      },
      %Variation{
        id: :with_label,
        description: "Textarea with label",
        attributes: %{
          name: "bio",
          label: "Biography",
          placeholder: "Tell us about yourself..."
        }
      },
      %Variation{
        id: :with_value,
        description: "Textarea with initial value",
        attributes: %{
          name: "content",
          label: "Content",
          value: "This is some pre-filled content in the textarea.\n\nIt can span multiple lines."
        }
      },
      %Variation{
        id: :with_help_text,
        description: "Textarea with help text",
        attributes: %{
          id: "notes",
          name: "notes",
          label: "Notes",
          help_text: "Maximum 500 characters",
          placeholder: "Add any additional notes..."
        }
      },
      %Variation{
        id: :custom_rows,
        description: "Textarea with custom rows (6 rows)",
        attributes: %{
          name: "essay",
          label: "Essay",
          rows: 6,
          placeholder: "Write your essay here..."
        }
      },
      %Variation{
        id: :required,
        description: "Required textarea",
        attributes: %{
          name: "feedback",
          label: "Feedback",
          required: true,
          placeholder: "Your feedback is required..."
        }
      },
      %Variation{
        id: :disabled,
        description: "Disabled textarea",
        attributes: %{
          name: "disabled_field",
          label: "Disabled Field",
          value: "This field is disabled",
          disabled: true
        }
      },
      %Variation{
        id: :readonly,
        description: "Readonly textarea",
        attributes: %{
          name: "readonly_field",
          label: "Readonly Field",
          value: "This content is read-only and cannot be modified.",
          readonly: true
        }
      },
      %Variation{
        id: :with_error,
        description: "Textarea with validation error",
        attributes: %{
          id: "error_field",
          name: "error_field",
          label: "Description",
          value: "Too short",
          errors: ["must be at least 50 characters"]
        }
      },
      %Variation{
        id: :with_multiple_errors,
        description: "Textarea with multiple errors",
        attributes: %{
          id: "multi_error_field",
          name: "multi_error_field",
          label: "Content",
          value: "",
          errors: ["can't be blank", "must contain at least one paragraph"]
        }
      },
      %VariationGroup{
        id: :states,
        description: "All states comparison",
        variations: [
          %Variation{
            id: :normal_state,
            attributes: %{
              name: "normal",
              label: "Normal",
              placeholder: "Normal state"
            }
          },
          %Variation{
            id: :disabled_state,
            attributes: %{
              name: "disabled",
              label: "Disabled",
              value: "Disabled content",
              disabled: true
            }
          },
          %Variation{
            id: :readonly_state,
            attributes: %{
              name: "readonly",
              label: "Readonly",
              value: "Readonly content",
              readonly: true
            }
          },
          %Variation{
            id: :error_state,
            attributes: %{
              id: "error_textarea",
              name: "error",
              label: "With Error",
              value: "Invalid",
              errors: ["is invalid"]
            }
          }
        ]
      }
    ]
  end
end
