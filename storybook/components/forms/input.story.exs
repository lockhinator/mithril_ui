defmodule Storybook.Components.Forms.Input do
  @moduledoc """
  Storybook stories for the MithrilUI Input component.

  Demonstrates various input types, states, and configurations.
  """

  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Input.input/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="w-full max-w-md space-y-4" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      # Basic text inputs
      %VariationGroup{
        id: :basic,
        description: "Basic input variations",
        variations: [
          %Variation{
            id: :default,
            description: "Default text input",
            attributes: %{
              name: "default",
              placeholder: "Enter text..."
            }
          },
          %Variation{
            id: :with_label,
            description: "Input with label",
            attributes: %{
              id: "username",
              name: "username",
              label: "Username",
              placeholder: "Enter your username"
            }
          },
          %Variation{
            id: :with_value,
            description: "Input with value",
            attributes: %{
              id: "prefilled",
              name: "prefilled",
              label: "Prefilled Input",
              value: "Hello, World!"
            }
          },
          %Variation{
            id: :with_help_text,
            description: "Input with help text",
            attributes: %{
              id: "with_help",
              name: "with_help",
              label: "Email",
              type: "email",
              placeholder: "you@example.com",
              help_text: "We'll never share your email with anyone else."
            }
          },
          %Variation{
            id: :required,
            description: "Required input",
            attributes: %{
              id: "required_field",
              name: "required_field",
              label: "Required Field",
              required: true,
              placeholder: "This field is required"
            }
          }
        ]
      },

      # Input types
      %VariationGroup{
        id: :types,
        description: "Different input types",
        variations: [
          %Variation{
            id: :text,
            attributes: %{
              id: "text_input",
              name: "text_input",
              type: "text",
              label: "Text",
              placeholder: "Plain text"
            }
          },
          %Variation{
            id: :email,
            attributes: %{
              id: "email_input",
              name: "email_input",
              type: "email",
              label: "Email",
              placeholder: "you@example.com"
            }
          },
          %Variation{
            id: :password,
            attributes: %{
              id: "password_input",
              name: "password_input",
              type: "password",
              label: "Password",
              placeholder: "Enter password"
            }
          },
          %Variation{
            id: :number,
            attributes: %{
              id: "number_input",
              name: "number_input",
              type: "number",
              label: "Number",
              placeholder: "0",
              min: "0",
              max: "100"
            }
          },
          %Variation{
            id: :tel,
            attributes: %{
              id: "tel_input",
              name: "tel_input",
              type: "tel",
              label: "Phone",
              placeholder: "+1 (555) 000-0000"
            }
          },
          %Variation{
            id: :url,
            attributes: %{
              id: "url_input",
              name: "url_input",
              type: "url",
              label: "URL",
              placeholder: "https://example.com"
            }
          },
          %Variation{
            id: :search,
            attributes: %{
              id: "search_input",
              name: "search_input",
              type: "search",
              label: "Search",
              placeholder: "Search..."
            }
          }
        ]
      },

      # Date and time inputs
      %VariationGroup{
        id: :datetime,
        description: "Date and time inputs",
        variations: [
          %Variation{
            id: :date,
            attributes: %{
              id: "date_input",
              name: "date_input",
              type: "date",
              label: "Date"
            }
          },
          %Variation{
            id: :time,
            attributes: %{
              id: "time_input",
              name: "time_input",
              type: "time",
              label: "Time"
            }
          },
          %Variation{
            id: :datetime_local,
            attributes: %{
              id: "datetime_input",
              name: "datetime_input",
              type: "datetime-local",
              label: "Date & Time"
            }
          }
        ]
      },

      # States
      %VariationGroup{
        id: :states,
        description: "Input states",
        variations: [
          %Variation{
            id: :disabled,
            description: "Disabled input",
            attributes: %{
              id: "disabled_input",
              name: "disabled_input",
              label: "Disabled",
              value: "Cannot edit this",
              disabled: true
            }
          },
          %Variation{
            id: :readonly,
            description: "Read-only input",
            attributes: %{
              id: "readonly_input",
              name: "readonly_input",
              label: "Read-only",
              value: "Read-only value",
              readonly: true
            }
          },
          %Variation{
            id: :with_error,
            description: "Input with validation error",
            attributes: %{
              id: "error_input",
              name: "error_input",
              label: "Email",
              type: "email",
              value: "invalid-email",
              errors: ["is not a valid email address"]
            }
          },
          %Variation{
            id: :multiple_errors,
            description: "Input with multiple errors",
            attributes: %{
              id: "multi_error_input",
              name: "multi_error_input",
              label: "Password",
              type: "password",
              errors: ["is too short (minimum 8 characters)", "must contain at least one number"]
            }
          }
        ]
      },

      # With custom styling
      %VariationGroup{
        id: :custom,
        description: "Custom styled inputs",
        variations: [
          %Variation{
            id: :large,
            description: "Large input",
            attributes: %{
              id: "large_input",
              name: "large_input",
              label: "Large Input",
              class: "input-lg",
              placeholder: "Large size"
            }
          },
          %Variation{
            id: :small,
            description: "Small input",
            attributes: %{
              id: "small_input",
              name: "small_input",
              label: "Small Input",
              class: "input-sm",
              placeholder: "Small size"
            }
          },
          %Variation{
            id: :primary,
            description: "Primary colored input",
            attributes: %{
              id: "primary_input",
              name: "primary_input",
              label: "Primary Input",
              class: "input-primary",
              placeholder: "Primary color on focus"
            }
          },
          %Variation{
            id: :ghost,
            description: "Ghost input",
            attributes: %{
              id: "ghost_input",
              name: "ghost_input",
              label: "Ghost Input",
              class: "input-ghost",
              placeholder: "Ghost style"
            }
          }
        ]
      }
    ]
  end
end
