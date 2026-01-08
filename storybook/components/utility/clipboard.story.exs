defmodule Storybook.Components.Utility.Clipboard do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Clipboard.clipboard_input/1

  def description do
    """
    Clipboard component for copy-to-clipboard functionality.
    Provides various patterns for copying text including input fields
    with copy buttons and code blocks.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Input with copy button",
        attributes: %{
          id: "copy-default",
          value: "npm install mithril_ui"
        }
      },
      %Variation{
        id: :with_label,
        description: "With label",
        attributes: %{
          id: "copy-labeled",
          value: "sk-1234567890abcdef",
          label: "API Key"
        }
      },
      %Variation{
        id: :custom_text,
        description: "Custom button text",
        attributes: %{
          id: "copy-custom",
          value: "https://example.com/share/abc123",
          button_text: "Clone",
          success_text: "Cloned!"
        }
      }
    ]
  end
end
