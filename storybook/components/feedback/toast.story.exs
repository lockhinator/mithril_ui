defmodule Storybook.Components.Feedback.Toast do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Toast.toast/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="flex flex-col gap-4" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :variants,
        description: "Toast variants",
        variations: [
          %Variation{
            id: :info,
            attributes: %{id: "toast-info", variant: "info"},
            slots: ["New message received."]
          },
          %Variation{
            id: :success,
            attributes: %{id: "toast-success", variant: "success"},
            slots: ["File uploaded successfully!"]
          },
          %Variation{
            id: :warning,
            attributes: %{id: "toast-warning", variant: "warning"},
            slots: ["Low disk space warning."]
          },
          %Variation{
            id: :error,
            attributes: %{id: "toast-error", variant: "error"},
            slots: ["Connection lost."]
          }
        ]
      },
      %VariationGroup{
        id: :dismissible,
        description: "Dismissible options",
        variations: [
          %Variation{
            id: :with_dismiss,
            attributes: %{id: "toast-dismiss", variant: "info", dismissible: true},
            slots: ["Dismissible toast"]
          },
          %Variation{
            id: :no_dismiss,
            attributes: %{id: "toast-no-dismiss", variant: "info", dismissible: false},
            slots: ["Non-dismissible toast"]
          }
        ]
      }
    ]
  end
end
