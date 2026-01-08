defmodule Storybook.Components.Extended.Rating do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Rating.rating/1

  def description do
    """
    Rating component for displaying and collecting star ratings.
    Supports interactive input, read-only display, half-star ratings,
    and various shapes (stars, hearts).
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Interactive rating",
        attributes: %{name: "rating-default", value: 3.0}
      },
      %VariationGroup{
        id: :sizes,
        description: "Rating sizes",
        variations: [
          %Variation{
            id: :xs,
            attributes: %{name: "rating-xs", value: 4.0, size: "xs"}
          },
          %Variation{
            id: :sm,
            attributes: %{name: "rating-sm", value: 4.0, size: "sm"}
          },
          %Variation{
            id: :md,
            attributes: %{name: "rating-md", value: 4.0, size: "md"}
          },
          %Variation{
            id: :lg,
            attributes: %{name: "rating-lg", value: 4.0, size: "lg"}
          },
          %Variation{
            id: :xl,
            attributes: %{name: "rating-xl", value: 4.0, size: "xl"}
          }
        ]
      },
      %Variation{
        id: :half_star,
        description: "Half-star rating",
        attributes: %{name: "rating-half", value: 3.5, half: true}
      },
      %VariationGroup{
        id: :shapes,
        description: "Rating shapes",
        variations: [
          %Variation{
            id: :star,
            attributes: %{name: "shape-star", value: 4.0, shape: "star"}
          },
          %Variation{
            id: :star2,
            attributes: %{name: "shape-star2", value: 4.0, shape: "star-2"}
          },
          %Variation{
            id: :heart,
            attributes: %{name: "shape-heart", value: 4.0, shape: "heart", color: "bg-red-500"}
          }
        ]
      },
      %VariationGroup{
        id: :colors,
        description: "Rating colors",
        variations: [
          %Variation{
            id: :yellow,
            attributes: %{name: "color-yellow", value: 4.0, color: "bg-yellow-400"}
          },
          %Variation{
            id: :orange,
            attributes: %{name: "color-orange", value: 4.0, color: "bg-orange-400"}
          },
          %Variation{
            id: :green,
            attributes: %{name: "color-green", value: 4.0, color: "bg-green-500"}
          }
        ]
      }
    ]
  end
end
