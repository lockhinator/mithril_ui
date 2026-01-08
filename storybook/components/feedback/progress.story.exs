defmodule Storybook.Components.Feedback.Progress do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Progress.progress/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="flex flex-col gap-6 w-full max-w-md" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :basic,
        description: "Basic progress bars",
        variations: [
          %Variation{
            id: :determinate,
            attributes: %{value: 50, max: 100}
          },
          %Variation{
            id: :indeterminate,
            description: "Loading state",
            attributes: %{}
          }
        ]
      },
      %VariationGroup{
        id: :variants,
        description: "Progress bar variants",
        variations: [
          %Variation{
            id: :primary,
            attributes: %{value: 40, variant: "primary"}
          },
          %Variation{
            id: :secondary,
            attributes: %{value: 50, variant: "secondary"}
          },
          %Variation{
            id: :accent,
            attributes: %{value: 60, variant: "accent"}
          },
          %Variation{
            id: :success,
            attributes: %{value: 100, variant: "success"}
          },
          %Variation{
            id: :warning,
            attributes: %{value: 30, variant: "warning"}
          },
          %Variation{
            id: :error,
            attributes: %{value: 15, variant: "error"}
          }
        ]
      },
      %VariationGroup{
        id: :with_label,
        description: "Progress with labels",
        variations: [
          %Variation{
            id: :labeled,
            attributes: %{value: 75, max: 100, label: "Uploading..."}
          },
          %Variation{
            id: :with_percentage,
            attributes: %{value: 65, max: 100, show_percentage: true}
          },
          %Variation{
            id: :labeled_percentage,
            attributes: %{value: 3, max: 5, label: "Step 3 of 5", show_percentage: true}
          }
        ]
      },
      %VariationGroup{
        id: :sizes,
        description: "Progress bar sizes",
        variations: [
          %Variation{
            id: :xs,
            attributes: %{value: 50, size: "xs"}
          },
          %Variation{
            id: :sm,
            attributes: %{value: 50, size: "sm"}
          },
          %Variation{
            id: :md,
            attributes: %{value: 50, size: "md"}
          },
          %Variation{
            id: :lg,
            attributes: %{value: 50, size: "lg"}
          }
        ]
      }
    ]
  end
end
