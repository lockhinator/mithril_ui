defmodule Storybook.Components.Extended.Carousel do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Carousel.carousel/1

  def description do
    """
    Carousel component for image sliders and content carousels.
    Uses Phoenix.LiveView.JS for smooth client-side slide transitions.
    Supports navigation controls, indicator dots, and various styling options.

    **Note:** For prev/next navigation to work, include the carousel JavaScript
    in your app.js or use a script tag with `MithrilUI.Components.Carousel.carousel_js()`.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Basic carousel with controls and indicators",
        attributes: %{
          id: "default-carousel",
          items: [
            "https://img.daisyui.com/images/stock/photo-1559703248-dcaaec9fab78.webp",
            "https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp",
            "https://img.daisyui.com/images/stock/photo-1572635148818-ef6fd45eb394.webp",
            "https://img.daisyui.com/images/stock/photo-1494253109108-2e30c049369b.webp",
            "https://img.daisyui.com/images/stock/photo-1550258987-190a2d41a8ba.webp"
          ]
        }
      },
      %Variation{
        id: :no_indicators,
        description: "Carousel without indicator dots",
        attributes: %{
          id: "no-indicators-carousel",
          show_indicators: false,
          items: [
            "https://img.daisyui.com/images/stock/photo-1559703248-dcaaec9fab78.webp",
            "https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp",
            "https://img.daisyui.com/images/stock/photo-1572635148818-ef6fd45eb394.webp"
          ]
        }
      },
      %Variation{
        id: :no_controls,
        description: "Carousel without navigation controls (indicators only)",
        attributes: %{
          id: "no-controls-carousel",
          show_controls: false,
          items: [
            "https://img.daisyui.com/images/stock/photo-1559703248-dcaaec9fab78.webp",
            "https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp",
            "https://img.daisyui.com/images/stock/photo-1572635148818-ef6fd45eb394.webp"
          ]
        }
      },
      %Variation{
        id: :styled,
        description: "Carousel with custom styling",
        attributes: %{
          id: "styled-carousel",
          class: "rounded-xl shadow-2xl",
          items: [
            "https://img.daisyui.com/images/stock/photo-1559703248-dcaaec9fab78.webp",
            "https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp",
            "https://img.daisyui.com/images/stock/photo-1572635148818-ef6fd45eb394.webp"
          ]
        }
      }
    ]
  end
end
