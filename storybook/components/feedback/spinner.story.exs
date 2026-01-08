defmodule Storybook.Components.Feedback.Spinner do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Spinner.spinner/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="flex flex-wrap gap-8 items-center" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :types,
        description: "Spinner animation types",
        variations: [
          %Variation{
            id: :spinner,
            attributes: %{type: "spinner"}
          },
          %Variation{
            id: :dots,
            attributes: %{type: "dots"}
          },
          %Variation{
            id: :ring,
            attributes: %{type: "ring"}
          },
          %Variation{
            id: :ball,
            attributes: %{type: "ball"}
          },
          %Variation{
            id: :bars,
            attributes: %{type: "bars"}
          },
          %Variation{
            id: :infinity,
            attributes: %{type: "infinity"}
          }
        ]
      },
      %VariationGroup{
        id: :sizes,
        description: "Spinner sizes",
        variations: [
          %Variation{
            id: :xs,
            attributes: %{size: "xs"}
          },
          %Variation{
            id: :sm,
            attributes: %{size: "sm"}
          },
          %Variation{
            id: :md,
            attributes: %{size: "md"}
          },
          %Variation{
            id: :lg,
            attributes: %{size: "lg"}
          }
        ]
      },
      %VariationGroup{
        id: :variants,
        description: "Spinner color variants",
        variations: [
          %Variation{
            id: :primary,
            attributes: %{variant: "primary", size: "lg"}
          },
          %Variation{
            id: :secondary,
            attributes: %{variant: "secondary", size: "lg"}
          },
          %Variation{
            id: :accent,
            attributes: %{variant: "accent", size: "lg"}
          },
          %Variation{
            id: :success,
            attributes: %{variant: "success", size: "lg"}
          },
          %Variation{
            id: :warning,
            attributes: %{variant: "warning", size: "lg"}
          },
          %Variation{
            id: :error,
            attributes: %{variant: "error", size: "lg"}
          }
        ]
      }
    ]
  end
end
