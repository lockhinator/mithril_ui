defmodule Storybook.Components.Extended.Gallery do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Gallery.gallery/1

  def description do
    """
    Gallery component for displaying collections of images in various layouts.
    Supports grid, masonry, featured image, and quad layouts with customizable
    columns and gaps.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Basic 3-column grid",
        attributes: %{
          items: [
            "https://img.daisyui.com/images/stock/photo-1559703248-dcaaec9fab78.webp",
            "https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp",
            "https://img.daisyui.com/images/stock/photo-1572635148818-ef6fd45eb394.webp",
            "https://img.daisyui.com/images/stock/photo-1494253109108-2e30c049369b.webp",
            "https://img.daisyui.com/images/stock/photo-1550258987-190a2d41a8ba.webp",
            "https://img.daisyui.com/images/stock/photo-1559181567-c3190ca9959b.webp"
          ]
        }
      },
      %VariationGroup{
        id: :columns,
        description: "Column variations",
        variations: [
          %Variation{
            id: :two_cols,
            attributes: %{
              columns: "2",
              items: [
                "https://img.daisyui.com/images/stock/photo-1559703248-dcaaec9fab78.webp",
                "https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp"
              ]
            }
          },
          %Variation{
            id: :four_cols,
            attributes: %{
              columns: "4",
              items: [
                "https://img.daisyui.com/images/stock/photo-1559703248-dcaaec9fab78.webp",
                "https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp",
                "https://img.daisyui.com/images/stock/photo-1572635148818-ef6fd45eb394.webp",
                "https://img.daisyui.com/images/stock/photo-1494253109108-2e30c049369b.webp"
              ]
            }
          }
        ]
      },
      %VariationGroup{
        id: :gaps,
        description: "Gap variations",
        variations: [
          %Variation{
            id: :small_gap,
            attributes: %{
              gap: "2",
              items: [
                "https://img.daisyui.com/images/stock/photo-1559703248-dcaaec9fab78.webp",
                "https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp",
                "https://img.daisyui.com/images/stock/photo-1572635148818-ef6fd45eb394.webp"
              ]
            }
          },
          %Variation{
            id: :large_gap,
            attributes: %{
              gap: "6",
              items: [
                "https://img.daisyui.com/images/stock/photo-1559703248-dcaaec9fab78.webp",
                "https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp",
                "https://img.daisyui.com/images/stock/photo-1572635148818-ef6fd45eb394.webp"
              ]
            }
          }
        ]
      }
    ]
  end
end
