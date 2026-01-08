defmodule Storybook.Components.Actions.Dropdown do
  @moduledoc """
  Storybook stories for the MithrilUI Dropdown component.

  Demonstrates various dropdown configurations, positions, and content types.
  """

  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Dropdown.dropdown/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="flex flex-wrap gap-8 items-start min-h-[300px]" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      # Basic
      %VariationGroup{
        id: :basic,
        description: "Basic dropdown menus",
        variations: [
          %Variation{
            id: :default,
            description: "Default dropdown",
            attributes: %{id: "basic-dropdown"},
            slots: [
              """
              <:trigger>
                <button class="btn m-1">Open Menu</button>
              </:trigger>
              <:item>Profile</:item>
              <:item>Settings</:item>
              <:item>Logout</:item>
              """
            ]
          },
          %Variation{
            id: :hover,
            description: "Hover-triggered dropdown",
            attributes: %{id: "hover-dropdown", hover: true},
            slots: [
              """
              <:trigger>
                <button class="btn m-1">Hover Me</button>
              </:trigger>
              <:item>Item 1</:item>
              <:item>Item 2</:item>
              <:item>Item 3</:item>
              """
            ]
          }
        ]
      },

      # Positions
      %VariationGroup{
        id: :positions,
        description: "Dropdown positioning options",
        variations: [
          %Variation{
            id: :default_pos,
            description: "Default (bottom-start)",
            attributes: %{id: "pos-default"},
            slots: [
              """
              <:trigger>
                <button class="btn btn-sm m-1">Default</button>
              </:trigger>
              <:item>Menu opens below</:item>
              """
            ]
          },
          %Variation{
            id: :end,
            description: "End aligned",
            attributes: %{id: "pos-end", position: "end"},
            slots: [
              """
              <:trigger>
                <button class="btn btn-sm m-1">End</button>
              </:trigger>
              <:item>Aligned to end</:item>
              """
            ]
          },
          %Variation{
            id: :top,
            description: "Opens upward",
            attributes: %{id: "pos-top", position: "top"},
            slots: [
              """
              <:trigger>
                <button class="btn btn-sm m-1">Top</button>
              </:trigger>
              <:item>Opens above</:item>
              """
            ]
          },
          %Variation{
            id: :left,
            description: "Opens to left",
            attributes: %{id: "pos-left", position: "left"},
            slots: [
              """
              <:trigger>
                <button class="btn btn-sm m-1">Left</button>
              </:trigger>
              <:item>Opens left</:item>
              """
            ]
          },
          %Variation{
            id: :right,
            description: "Opens to right",
            attributes: %{id: "pos-right", position: "right"},
            slots: [
              """
              <:trigger>
                <button class="btn btn-sm m-1">Right</button>
              </:trigger>
              <:item>Opens right</:item>
              """
            ]
          }
        ]
      },

      # With dividers
      %VariationGroup{
        id: :dividers,
        description: "Dropdowns with dividers",
        variations: [
          %Variation{
            id: :with_divider,
            description: "Menu with section divider",
            attributes: %{id: "divider-dropdown"},
            slots: [
              """
              <:trigger>
                <button class="btn btn-primary m-1">User Menu</button>
              </:trigger>
              <:item>View Profile</:item>
              <:item>Edit Profile</:item>
              <:divider />
              <:item>Settings</:item>
              <:item>Help</:item>
              <:divider />
              <:item>Sign Out</:item>
              """
            ]
          }
        ]
      },

      # States
      %VariationGroup{
        id: :states,
        description: "Item states",
        variations: [
          %Variation{
            id: :with_disabled,
            description: "With disabled item",
            attributes: %{id: "disabled-item-dropdown"},
            slots: [
              """
              <:trigger>
                <button class="btn m-1">Actions</button>
              </:trigger>
              <:item>Available Action</:item>
              <:item disabled>Unavailable Action</:item>
              <:item>Another Action</:item>
              """
            ]
          },
          %Variation{
            id: :open,
            description: "Forced open state",
            attributes: %{id: "open-dropdown", open: true},
            slots: [
              """
              <:trigger>
                <button class="btn btn-secondary m-1">Always Open</button>
              </:trigger>
              <:item>This menu</:item>
              <:item>stays open</:item>
              """
            ]
          }
        ]
      },

      # Styled items
      %VariationGroup{
        id: :styled,
        description: "Custom styled items",
        variations: [
          %Variation{
            id: :danger_item,
            description: "With danger-styled item",
            attributes: %{id: "styled-dropdown"},
            slots: [
              """
              <:trigger>
                <button class="btn m-1">Options</button>
              </:trigger>
              <:item>Edit</:item>
              <:item>Duplicate</:item>
              <:divider />
              <:item class="text-error">Delete</:item>
              """
            ]
          }
        ]
      },

      # Custom content
      %VariationGroup{
        id: :custom,
        description: "Custom content in dropdowns",
        variations: [
          %Variation{
            id: :custom_content,
            description: "With custom HTML content",
            attributes: %{id: "custom-dropdown"},
            slots: [
              """
              <:trigger>
                <button class="btn btn-accent m-1">Custom Content</button>
              </:trigger>
              <:content>
                <div class="p-4">
                  <p class="font-bold mb-2">Custom Section</p>
                  <p class="text-sm opacity-70">This is custom HTML content inside the dropdown.</p>
                </div>
              </:content>
              <:divider />
              <:item>Regular Item</:item>
              """
            ]
          }
        ]
      }
    ]
  end
end
