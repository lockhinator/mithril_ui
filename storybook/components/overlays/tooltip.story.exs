defmodule Storybook.Components.Overlays.Tooltip do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Tooltip.tooltip/1

  def description do
    """
    Tooltip component for displaying contextual information on hover.

    Tooltips are small pop-ups that appear when users hover over an element,
    providing additional context or information without cluttering the UI.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Basic tooltip",
        attributes: %{
          text: "This is a tooltip"
        },
        slots: [
          """
          <button class="btn">Hover me</button>
          """
        ]
      },
      %VariationGroup{
        id: :positions,
        description: "Tooltip positions",
        variations: [
          %Variation{
            id: :top,
            attributes: %{text: "Top tooltip", position: :top},
            slots: ["<button class=\"btn\">Top</button>"]
          },
          %Variation{
            id: :bottom,
            attributes: %{text: "Bottom tooltip", position: :bottom},
            slots: ["<button class=\"btn\">Bottom</button>"]
          },
          %Variation{
            id: :left,
            attributes: %{text: "Left tooltip", position: :left},
            slots: ["<button class=\"btn\">Left</button>"]
          },
          %Variation{
            id: :right,
            attributes: %{text: "Right tooltip", position: :right},
            slots: ["<button class=\"btn\">Right</button>"]
          }
        ]
      },
      %VariationGroup{
        id: :colors,
        description: "Tooltip color variants",
        variations: [
          %Variation{
            id: :primary,
            attributes: %{text: "Primary tooltip", color: :primary},
            slots: ["<button class=\"btn btn-primary\">Primary</button>"]
          },
          %Variation{
            id: :secondary,
            attributes: %{text: "Secondary tooltip", color: :secondary},
            slots: ["<button class=\"btn btn-secondary\">Secondary</button>"]
          },
          %Variation{
            id: :accent,
            attributes: %{text: "Accent tooltip", color: :accent},
            slots: ["<button class=\"btn btn-accent\">Accent</button>"]
          },
          %Variation{
            id: :info,
            attributes: %{text: "Info tooltip", color: :info},
            slots: ["<button class=\"btn btn-info\">Info</button>"]
          },
          %Variation{
            id: :success,
            attributes: %{text: "Success tooltip", color: :success},
            slots: ["<button class=\"btn btn-success\">Success</button>"]
          },
          %Variation{
            id: :warning,
            attributes: %{text: "Warning tooltip", color: :warning},
            slots: ["<button class=\"btn btn-warning\">Warning</button>"]
          },
          %Variation{
            id: :error,
            attributes: %{text: "Error tooltip", color: :error},
            slots: ["<button class=\"btn btn-error\">Error</button>"]
          }
        ]
      },
      %Variation{
        id: :always_open,
        description: "Tooltip that's always visible",
        attributes: %{
          text: "I'm always visible",
          open: true
        },
        slots: [
          """
          <button class="btn">Always Open</button>
          """
        ]
      },
      %Variation{
        id: :form_field,
        description: "Tooltip on form field",
        attributes: %{
          text: "Enter your email address",
          position: :right
        },
        slots: [
          """
          <input type="email" placeholder="Email" class="input input-bordered" />
          """
        ]
      },
      %Variation{
        id: :icon_trigger,
        description: "Tooltip on icon",
        attributes: %{
          text: "Click for more information",
          color: :info
        },
        slots: [
          """
          <button class="btn btn-circle btn-ghost btn-sm">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd" />
            </svg>
          </button>
          """
        ]
      },
      %Variation{
        id: :long_text,
        description: "Tooltip with longer text",
        attributes: %{
          text: "This is a longer tooltip with more detailed information about the element"
        },
        slots: [
          """
          <button class="btn">Long tooltip</button>
          """
        ]
      }
    ]
  end
end
