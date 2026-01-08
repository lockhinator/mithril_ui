defmodule Storybook.Components.Typography.Code do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Code.code/1

  def description do
    """
    Code component for displaying inline code and code blocks.
    Provides styled code snippets for documentation and technical content.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Inline code",
        slots: ["const x = 42"]
      },
      %VariationGroup{
        id: :colors,
        description: "Code colors",
        variations: [
          %Variation{
            id: :default_color,
            attributes: %{color: :default},
            slots: ["npm install"]
          },
          %Variation{
            id: :primary,
            attributes: %{color: :primary},
            slots: ["mix deps.get"]
          },
          %Variation{
            id: :secondary,
            attributes: %{color: :secondary},
            slots: ["git commit"]
          },
          %Variation{
            id: :accent,
            attributes: %{color: :accent},
            slots: ["cargo build"]
          }
        ]
      },
      %Variation{
        id: :in_text,
        description: "Code in text context",
        slots: [
          """
          <span>Run </span><MithrilUI.Components.Code.code>mix phx.server</MithrilUI.Components.Code.code><span> to start the server.</span>
          """
        ]
      }
    ]
  end
end
