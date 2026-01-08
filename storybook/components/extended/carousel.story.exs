defmodule Storybook.Components.Extended.Carousel do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Carousel.carousel/1

  def description do
    """
    Carousel component for image sliders and content carousels.
    Supports horizontal/vertical scrolling, snap positions,
    navigation controls, and indicator dots.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Basic carousel",
        slots: [
          """
          <MithrilUI.Components.Carousel.carousel_item id="slide1" src="https://img.daisyui.com/images/stock/photo-1559703248-dcaaec9fab78.webp" />
          <MithrilUI.Components.Carousel.carousel_item id="slide2" src="https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp" />
          <MithrilUI.Components.Carousel.carousel_item id="slide3" src="https://img.daisyui.com/images/stock/photo-1572635148818-ef6fd45eb394.webp" />
          """
        ]
      },
      %Variation{
        id: :with_nav,
        description: "With navigation buttons",
        attributes: %{full_width: true},
        slots: [
          """
          <MithrilUI.Components.Carousel.carousel_item id="nav1" src="https://img.daisyui.com/images/stock/photo-1559703248-dcaaec9fab78.webp" prev="nav3" next="nav2" full_width />
          <MithrilUI.Components.Carousel.carousel_item id="nav2" src="https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp" prev="nav1" next="nav3" full_width />
          <MithrilUI.Components.Carousel.carousel_item id="nav3" src="https://img.daisyui.com/images/stock/photo-1572635148818-ef6fd45eb394.webp" prev="nav2" next="nav1" full_width />
          """
        ]
      },
      %Variation{
        id: :center_snap,
        description: "Center snap",
        attributes: %{snap: "center"},
        slots: [
          """
          <MithrilUI.Components.Carousel.carousel_item id="center1" src="https://img.daisyui.com/images/stock/photo-1559703248-dcaaec9fab78.webp" />
          <MithrilUI.Components.Carousel.carousel_item id="center2" src="https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp" />
          <MithrilUI.Components.Carousel.carousel_item id="center3" src="https://img.daisyui.com/images/stock/photo-1572635148818-ef6fd45eb394.webp" />
          """
        ]
      }
    ]
  end
end
