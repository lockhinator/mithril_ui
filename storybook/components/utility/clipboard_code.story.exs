defmodule Storybook.Components.Utility.ClipboardCode do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Clipboard.clipboard_code/1

  def description do
    """
    Code block with copy button. Shows a code snippet with a
    hover-activated copy button for easy copying.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Basic code block",
        attributes: %{
          id: "code-default",
          code: "mix deps.get"
        }
      },
      %Variation{
        id: :with_language,
        description: "With language",
        attributes: %{
          id: "code-bash",
          code: "curl -X POST https://api.example.com/data",
          language: "bash"
        }
      },
      %Variation{
        id: :multiline,
        description: "Multiline code",
        attributes: %{
          id: "code-multi",
          code: "defmodule Hello do\n  def world, do: :ok\nend",
          language: "elixir"
        }
      }
    ]
  end
end
