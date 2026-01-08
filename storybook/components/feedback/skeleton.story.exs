defmodule Storybook.Components.Feedback.Skeleton do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Skeleton.skeleton/1

  def description do
    """
    Skeleton loading placeholder component for content that is loading.
    Provides visual placeholders that mimic content shape while loading.
    """
  end

  def variations do
    [
      %Variation{
        id: :line,
        description: "Line skeleton",
        attributes: %{class: "h-4 w-64"}
      },
      %Variation{
        id: :box,
        description: "Box skeleton",
        attributes: %{class: "h-32 w-64"}
      },
      %Variation{
        id: :circle,
        description: "Circle skeleton",
        attributes: %{class: "h-12 w-12", rounded: "full"}
      },
      %VariationGroup{
        id: :rounded,
        description: "Rounded variants",
        variations: [
          %Variation{
            id: :rounded_none,
            attributes: %{class: "h-8 w-32", rounded: "none"}
          },
          %Variation{
            id: :rounded_sm,
            attributes: %{class: "h-8 w-32", rounded: "sm"}
          },
          %Variation{
            id: :rounded_md,
            attributes: %{class: "h-8 w-32", rounded: "md"}
          },
          %Variation{
            id: :rounded_lg,
            attributes: %{class: "h-8 w-32", rounded: "lg"}
          }
        ]
      }
    ]
  end
end
