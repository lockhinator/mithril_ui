defmodule Storybook.Components.Actions.ButtonGroup do
  @moduledoc """
  Storybook stories for the MithrilUI ButtonGroup component.

  Demonstrates various button group configurations, orientations, and states.
  """

  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.ButtonGroup.button_group/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="flex flex-col gap-8" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      # Basic
      %VariationGroup{
        id: :basic,
        description: "Basic button groups",
        variations: [
          %Variation{
            id: :default,
            description: "Default button group",
            slots: [
              """
              <:button>Left</:button>
              <:button>Center</:button>
              <:button>Right</:button>
              """
            ]
          },
          %Variation{
            id: :two_buttons,
            description: "Two button group",
            slots: [
              """
              <:button>Yes</:button>
              <:button>No</:button>
              """
            ]
          }
        ]
      },

      # Variants
      %VariationGroup{
        id: :variants,
        description: "Button group variants",
        variations: [
          %Variation{
            id: :primary,
            description: "Primary variant",
            attributes: %{variant: "primary"},
            slots: [
              """
              <:button>One</:button>
              <:button>Two</:button>
              <:button>Three</:button>
              """
            ]
          },
          %Variation{
            id: :secondary,
            description: "Secondary variant",
            attributes: %{variant: "secondary"},
            slots: [
              """
              <:button>One</:button>
              <:button>Two</:button>
              <:button>Three</:button>
              """
            ]
          },
          %Variation{
            id: :accent,
            description: "Accent variant",
            attributes: %{variant: "accent"},
            slots: [
              """
              <:button>One</:button>
              <:button>Two</:button>
              <:button>Three</:button>
              """
            ]
          },
          %Variation{
            id: :outline,
            description: "Outline style",
            attributes: %{variant: "primary", outline: true},
            slots: [
              """
              <:button>One</:button>
              <:button>Two</:button>
              <:button>Three</:button>
              """
            ]
          }
        ]
      },

      # Sizes
      %VariationGroup{
        id: :sizes,
        description: "Button group sizes",
        variations: [
          %Variation{
            id: :xs,
            description: "Extra small",
            attributes: %{size: "xs"},
            slots: [
              """
              <:button>XS</:button>
              <:button>XS</:button>
              <:button>XS</:button>
              """
            ]
          },
          %Variation{
            id: :sm,
            description: "Small",
            attributes: %{size: "sm"},
            slots: [
              """
              <:button>SM</:button>
              <:button>SM</:button>
              <:button>SM</:button>
              """
            ]
          },
          %Variation{
            id: :md,
            description: "Medium (default)",
            attributes: %{size: "md"},
            slots: [
              """
              <:button>MD</:button>
              <:button>MD</:button>
              <:button>MD</:button>
              """
            ]
          },
          %Variation{
            id: :lg,
            description: "Large",
            attributes: %{size: "lg"},
            slots: [
              """
              <:button>LG</:button>
              <:button>LG</:button>
              <:button>LG</:button>
              """
            ]
          }
        ]
      },

      # Orientation
      %VariationGroup{
        id: :orientation,
        description: "Button group orientation",
        variations: [
          %Variation{
            id: :horizontal,
            description: "Horizontal (default)",
            attributes: %{orientation: "horizontal", variant: "primary"},
            slots: [
              """
              <:button>Left</:button>
              <:button>Center</:button>
              <:button>Right</:button>
              """
            ]
          },
          %Variation{
            id: :vertical,
            description: "Vertical",
            attributes: %{orientation: "vertical", variant: "primary"},
            slots: [
              """
              <:button>Top</:button>
              <:button>Middle</:button>
              <:button>Bottom</:button>
              """
            ]
          }
        ]
      },

      # States
      %VariationGroup{
        id: :states,
        description: "Button states within groups",
        variations: [
          %Variation{
            id: :with_active,
            description: "With active button",
            attributes: %{variant: "primary"},
            slots: [
              """
              <:button>Normal</:button>
              <:button active>Active</:button>
              <:button>Normal</:button>
              """
            ]
          },
          %Variation{
            id: :with_disabled,
            description: "With disabled button",
            attributes: %{variant: "primary"},
            slots: [
              """
              <:button>Enabled</:button>
              <:button disabled>Disabled</:button>
              <:button>Enabled</:button>
              """
            ]
          },
          %Variation{
            id: :all_disabled,
            description: "All disabled",
            attributes: %{variant: "primary", disabled: true},
            slots: [
              """
              <:button>One</:button>
              <:button>Two</:button>
              <:button>Three</:button>
              """
            ]
          }
        ]
      }
    ]
  end
end
