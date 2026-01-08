defmodule Storybook.Components.Extended.ChatBubble do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.ChatBubble.chat_message/1

  def description do
    """
    Chat bubble component for displaying conversation messages.
    Supports avatars, timestamps, delivery status, and various
    message types including text, images, and files.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Incoming message",
        attributes: %{position: "start"},
        slots: ["Hello! How are you?"]
      },
      %Variation{
        id: :outgoing,
        description: "Outgoing message",
        attributes: %{position: "end", color: "primary"},
        slots: ["I'm doing great, thanks!"]
      },
      %Variation{
        id: :with_sender,
        description: "With sender info",
        attributes: %{position: "start", sender: "Alice", time: "12:45"},
        slots: ["Hey, did you see the news?"]
      },
      %Variation{
        id: :with_status,
        description: "With delivery status",
        attributes: %{position: "end", color: "primary", status: "Delivered"},
        slots: ["Yes, amazing stuff!"]
      },
      %VariationGroup{
        id: :colors,
        description: "Bubble colors",
        variations: [
          %Variation{
            id: :primary,
            attributes: %{position: "end", color: "primary"},
            slots: ["Primary bubble"]
          },
          %Variation{
            id: :secondary,
            attributes: %{position: "end", color: "secondary"},
            slots: ["Secondary bubble"]
          },
          %Variation{
            id: :accent,
            attributes: %{position: "end", color: "accent"},
            slots: ["Accent bubble"]
          },
          %Variation{
            id: :info,
            attributes: %{position: "end", color: "info"},
            slots: ["Info bubble"]
          }
        ]
      }
    ]
  end
end
