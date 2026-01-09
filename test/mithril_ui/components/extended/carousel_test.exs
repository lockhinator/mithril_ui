defmodule MithrilUI.Components.CarouselTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Carousel

  describe "carousel/1" do
    test "renders carousel with images" do
      assigns = %{items: ["/a.jpg", "/b.jpg", "/c.jpg"]}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel id="test-carousel" items={@items} />
        """)

      assert html =~ ~s(id="test-carousel")
      assert html =~ ~s(src="/a.jpg")
      assert html =~ ~s(src="/b.jpg")
      assert html =~ ~s(src="/c.jpg")
    end

    test "renders with controls by default" do
      assigns = %{items: ["/a.jpg", "/b.jpg"]}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel id="with-controls" items={@items} />
        """)

      # Previous button
      assert html =~ "Previous"
      # Next button
      assert html =~ "Next"
    end

    test "renders with indicators by default" do
      assigns = %{items: ["/a.jpg", "/b.jpg", "/c.jpg"]}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel id="with-indicators" items={@items} />
        """)

      assert html =~ ~s(data-carousel-indicator="0")
      assert html =~ ~s(data-carousel-indicator="1")
      assert html =~ ~s(data-carousel-indicator="2")
    end

    test "can hide controls" do
      assigns = %{items: ["/a.jpg", "/b.jpg"]}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel id="no-controls" items={@items} show_controls={false} />
        """)

      refute html =~ "Previous"
      refute html =~ "Next"
    end

    test "can hide indicators" do
      assigns = %{items: ["/a.jpg", "/b.jpg"]}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel id="no-indicators" items={@items} show_indicators={false} />
        """)

      refute html =~ "data-carousel-indicator"
    end

    test "applies custom class" do
      assigns = %{items: ["/a.jpg"]}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel id="styled" items={@items} class="rounded-xl shadow-2xl" />
        """)

      assert html =~ "rounded-xl"
      assert html =~ "shadow-2xl"
    end

    test "first slide is visible by default" do
      assigns = %{items: ["/a.jpg", "/b.jpg"]}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel id="first-visible" items={@items} />
        """)

      # First slide should have opacity-100
      assert html =~ ~s(id="first-visible-slide-0")
      assert html =~ "opacity-100"
    end

    test "generates correct slide IDs" do
      assigns = %{items: ["/a.jpg", "/b.jpg", "/c.jpg"]}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel id="my-carousel" items={@items} />
        """)

      assert html =~ ~s(id="my-carousel-slide-0")
      assert html =~ ~s(id="my-carousel-slide-1")
      assert html =~ ~s(id="my-carousel-slide-2")
    end

    test "single item carousel hides controls" do
      assigns = %{items: ["/a.jpg"]}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel id="single" items={@items} />
        """)

      # Controls should not appear for single item
      refute html =~ "Previous"
      refute html =~ "Next"
    end
  end

  describe "carousel_container/1" do
    test "renders container for custom content" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_container id="custom-carousel">
          <div>Custom content</div>
        </Carousel.carousel_container>
        """)

      assert html =~ ~s(id="custom-carousel")
      assert html =~ "Custom content"
      assert html =~ ~s(data-carousel-active="0")
    end

    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_container id="styled-container" class="my-class">
          <div>Content</div>
        </Carousel.carousel_container>
        """)

      assert html =~ "my-class"
    end
  end

  describe "carousel_slide/1" do
    test "renders slide with content" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_slide index={0} total={3}>
          <img src="/image.jpg" />
        </Carousel.carousel_slide>
        """)

      assert html =~ ~s(src="/image.jpg")
      assert html =~ "transition-opacity"
    end

    test "first slide is visible" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_slide index={0} total={3}>
          Content
        </Carousel.carousel_slide>
        """)

      assert html =~ "opacity-100"
      refute html =~ "opacity-0"
    end

    test "other slides are hidden" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_slide index={1} total={3}>
          Content
        </Carousel.carousel_slide>
        """)

      assert html =~ "opacity-0"
      assert html =~ "pointer-events-none"
    end

    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_slide index={0} total={2} class="custom-slide">
          Content
        </Carousel.carousel_slide>
        """)

      assert html =~ "custom-slide"
    end
  end

  describe "carousel_controls/1" do
    test "renders prev and next buttons" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_controls id="my-carousel" total={3} />
        """)

      assert html =~ "Previous"
      assert html =~ "Next"
    end

    test "buttons trigger carousel events" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_controls id="event-carousel" total={3} />
        """)

      assert html =~ "carousel:prev"
      assert html =~ "carousel:next"
    end
  end

  describe "carousel_indicators/1" do
    test "renders indicator dots" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_indicators id="ind-carousel" total={4} />
        """)

      assert html =~ ~s(data-carousel-indicator="0")
      assert html =~ ~s(data-carousel-indicator="1")
      assert html =~ ~s(data-carousel-indicator="2")
      assert html =~ ~s(data-carousel-indicator="3")
    end

    test "first indicator is active" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_indicators id="active-carousel" total={3} />
        """)

      # First indicator should have bg-white (active state)
      assert html =~ ~s(aria-current="true")
    end

    test "has correct aria labels" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_indicators id="aria-carousel" total={3} />
        """)

      assert html =~ ~s(aria-label="Slide 1")
      assert html =~ ~s(aria-label="Slide 2")
      assert html =~ ~s(aria-label="Slide 3")
    end
  end

  describe "carousel_js/0" do
    test "returns JavaScript code" do
      js = Carousel.carousel_js()

      assert is_binary(js)
      assert js =~ "carousel:next"
      assert js =~ "carousel:prev"
      assert js =~ "carouselGoTo"
    end
  end
end
