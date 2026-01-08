defmodule Storybook.Components.Actions.Button do
  @moduledoc """
  Storybook stories for the MithrilUI Button component.

  Demonstrates various button variants, sizes, states, and configurations.
  """

  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Button.button/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="flex flex-wrap gap-4 items-center" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      # Variants
      %VariationGroup{
        id: :variants,
        description: "Button variants for different contexts",
        variations: [
          %Variation{
            id: :default,
            description: "Default button with no variant",
            slots: ["Default"]
          },
          %Variation{
            id: :primary,
            description: "Primary action button",
            attributes: %{variant: "primary"},
            slots: ["Primary"]
          },
          %Variation{
            id: :secondary,
            description: "Secondary action button",
            attributes: %{variant: "secondary"},
            slots: ["Secondary"]
          },
          %Variation{
            id: :accent,
            description: "Accent button for highlights",
            attributes: %{variant: "accent"},
            slots: ["Accent"]
          },
          %Variation{
            id: :neutral,
            description: "Neutral button",
            attributes: %{variant: "neutral"},
            slots: ["Neutral"]
          },
          %Variation{
            id: :ghost,
            description: "Ghost button with transparent background",
            attributes: %{variant: "ghost"},
            slots: ["Ghost"]
          },
          %Variation{
            id: :link,
            description: "Link-styled button",
            attributes: %{variant: "link"},
            slots: ["Link"]
          }
        ]
      },

      # Semantic variants
      %VariationGroup{
        id: :semantic,
        description: "Semantic variants for status indication",
        variations: [
          %Variation{
            id: :info,
            description: "Informational action",
            attributes: %{variant: "info"},
            slots: ["Info"]
          },
          %Variation{
            id: :success,
            description: "Success/positive action",
            attributes: %{variant: "success"},
            slots: ["Success"]
          },
          %Variation{
            id: :warning,
            description: "Warning action",
            attributes: %{variant: "warning"},
            slots: ["Warning"]
          },
          %Variation{
            id: :error,
            description: "Error/destructive action",
            attributes: %{variant: "error"},
            slots: ["Error"]
          }
        ]
      },

      # Outline variants
      %VariationGroup{
        id: :outline,
        description: "Outline style buttons",
        variations: [
          %Variation{
            id: :outline_default,
            description: "Outline without variant",
            attributes: %{outline: true},
            slots: ["Outline"]
          },
          %Variation{
            id: :outline_primary,
            description: "Outline primary",
            attributes: %{variant: "primary", outline: true},
            slots: ["Outline Primary"]
          },
          %Variation{
            id: :outline_secondary,
            description: "Outline secondary",
            attributes: %{variant: "secondary", outline: true},
            slots: ["Outline Secondary"]
          },
          %Variation{
            id: :outline_accent,
            description: "Outline accent",
            attributes: %{variant: "accent", outline: true},
            slots: ["Outline Accent"]
          }
        ]
      },

      # Sizes
      %VariationGroup{
        id: :sizes,
        description: "Button sizes",
        variations: [
          %Variation{
            id: :xs,
            description: "Extra small button",
            attributes: %{size: "xs"},
            slots: ["Extra Small"]
          },
          %Variation{
            id: :sm,
            description: "Small button",
            attributes: %{size: "sm"},
            slots: ["Small"]
          },
          %Variation{
            id: :md,
            description: "Medium button (default)",
            attributes: %{size: "md"},
            slots: ["Medium"]
          },
          %Variation{
            id: :lg,
            description: "Large button",
            attributes: %{size: "lg"},
            slots: ["Large"]
          }
        ]
      },

      # States
      %VariationGroup{
        id: :states,
        description: "Button states",
        variations: [
          %Variation{
            id: :normal,
            description: "Normal state",
            attributes: %{variant: "primary"},
            slots: ["Normal"]
          },
          %Variation{
            id: :disabled,
            description: "Disabled state",
            attributes: %{variant: "primary", disabled: true},
            slots: ["Disabled"]
          },
          %Variation{
            id: :loading,
            description: "Loading state with spinner",
            attributes: %{variant: "primary", loading: true},
            slots: ["Loading..."]
          }
        ]
      },

      # Shapes
      %VariationGroup{
        id: :shapes,
        description: "Button shapes",
        variations: [
          %Variation{
            id: :default_shape,
            description: "Default shape",
            attributes: %{variant: "primary"},
            slots: ["Default Shape"]
          },
          %Variation{
            id: :block,
            description: "Full width block button",
            attributes: %{variant: "primary", block: true},
            slots: ["Full Width Button"]
          },
          %Variation{
            id: :square,
            description: "Square button",
            attributes: %{variant: "primary", square: true},
            slots: ["X"]
          },
          %Variation{
            id: :circle,
            description: "Circle button",
            attributes: %{variant: "primary", circle: true},
            slots: ["O"]
          }
        ]
      },

      # Combined examples
      %VariationGroup{
        id: :combined,
        description: "Combined variant and size examples",
        variations: [
          %Variation{
            id: :primary_large,
            description: "Large primary button",
            attributes: %{variant: "primary", size: "lg"},
            slots: ["Submit Form"]
          },
          %Variation{
            id: :ghost_small,
            description: "Small ghost button",
            attributes: %{variant: "ghost", size: "sm"},
            slots: ["Cancel"]
          },
          %Variation{
            id: :error_loading,
            description: "Error button in loading state",
            attributes: %{variant: "error", loading: true},
            slots: ["Deleting..."]
          },
          %Variation{
            id: :outline_success_large,
            description: "Large outline success button",
            attributes: %{variant: "success", outline: true, size: "lg"},
            slots: ["Confirm"]
          }
        ]
      }
    ]
  end
end
