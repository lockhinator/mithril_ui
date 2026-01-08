defmodule Storybook.Components.Feedback.Alert do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Alert.alert/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="flex flex-col gap-4 w-full max-w-xl" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :variants,
        description: "Alert variants",
        variations: [
          %Variation{
            id: :info,
            attributes: %{variant: "info"},
            slots: ["This is an informational message."]
          },
          %Variation{
            id: :success,
            attributes: %{variant: "success"},
            slots: ["Operation completed successfully!"]
          },
          %Variation{
            id: :warning,
            attributes: %{variant: "warning"},
            slots: ["Please review before proceeding."]
          },
          %Variation{
            id: :error,
            attributes: %{variant: "error"},
            slots: ["An error occurred. Please try again."]
          }
        ]
      },
      %VariationGroup{
        id: :with_title,
        description: "Alerts with titles",
        variations: [
          %Variation{
            id: :titled_success,
            attributes: %{variant: "success", title: "Success!"},
            slots: ["Your changes have been saved."]
          },
          %Variation{
            id: :titled_error,
            attributes: %{variant: "error", title: "Error"},
            slots: ["Failed to save changes. Please try again."]
          }
        ]
      },
      %VariationGroup{
        id: :dismissible,
        description: "Dismissible alerts",
        variations: [
          %Variation{
            id: :dismissible_info,
            attributes: %{id: "dismiss-info", variant: "info", dismissible: true},
            slots: ["This alert can be dismissed."]
          },
          %Variation{
            id: :dismissible_warning,
            attributes: %{id: "dismiss-warn", variant: "warning", dismissible: true, title: "Warning"},
            slots: ["Review this important notice."]
          }
        ]
      },
      %VariationGroup{
        id: :without_icon,
        description: "Alerts without icons",
        variations: [
          %Variation{
            id: :no_icon,
            attributes: %{variant: "info", icon: false},
            slots: ["A simple text-only alert."]
          }
        ]
      }
    ]
  end
end
