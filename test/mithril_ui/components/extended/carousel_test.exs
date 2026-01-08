defmodule MithrilUI.Components.CarouselTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Carousel

  describe "carousel/1" do
    test "renders carousel container" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel>
          <span>Items</span>
        </Carousel.carousel>
        """)

      assert html =~ "carousel"
    end

    test "applies snap position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel snap="center">
          <span>Items</span>
        </Carousel.carousel>
        """)

      assert html =~ "carousel-center"
    end

    test "applies vertical layout" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel vertical>
          <span>Items</span>
        </Carousel.carousel>
        """)

      assert html =~ "carousel-vertical"
    end

    test "applies full width" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel full_width>
          <span>Items</span>
        </Carousel.carousel>
        """)

      assert html =~ "w-full"
    end
  end

  describe "carousel_item/1" do
    test "renders carousel item with image" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_item id="slide1" src="/image.jpg" />
        """)

      assert html =~ "carousel-item"
      assert html =~ ~s(id="slide1")
      assert html =~ ~s(src="/image.jpg")
    end

    test "renders navigation buttons" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_item id="slide2" src="/img.jpg" prev="slide1" next="slide3" />
        """)

      assert html =~ ~s(href="#slide1")
      assert html =~ ~s(href="#slide3")
    end

    test "applies full width" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_item id="s1" src="/img.jpg" full_width />
        """)

      assert html =~ "w-full"
    end

    test "applies alt text" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_item id="s1" src="/img.jpg" alt="Beautiful landscape" />
        """)

      assert html =~ ~s(alt="Beautiful landscape")
    end
  end

  describe "carousel_content/1" do
    test "renders carousel item with custom content" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_content id="card1">
          Custom content
        </Carousel.carousel_content>
        """)

      assert html =~ "carousel-item"
      assert html =~ ~s(id="card1")
      assert html =~ "Custom content"
    end

    test "renders navigation buttons" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_content id="c2" prev="c1" next="c3">
          Content
        </Carousel.carousel_content>
        """)

      assert html =~ ~s(href="#c1")
      assert html =~ ~s(href="#c3")
    end
  end

  describe "carousel_indicators/1" do
    test "renders indicator buttons" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_indicators count={5} />
        """)

      assert html =~ ~s(href="#slide0")
      assert html =~ ~s(href="#slide4")
    end

    test "uses custom prefix" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_indicators count={3} prefix="item" />
        """)

      assert html =~ ~s(href="#item0")
      assert html =~ ~s(href="#item1")
      assert html =~ ~s(href="#item2")
    end

    test "highlights active indicator" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_indicators count={3} active={1} />
        """)

      assert html =~ "btn-primary"
    end
  end

  describe "carousel_full/1" do
    test "renders full carousel with items" do
      assigns = %{items: ["/a.jpg", "/b.jpg", "/c.jpg"]}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_full items={@items} />
        """)

      assert html =~ "carousel"
      assert html =~ ~s(src="/a.jpg")
      assert html =~ ~s(src="/b.jpg")
      assert html =~ ~s(src="/c.jpg")
    end

    test "renders with navigation" do
      assigns = %{items: ["/a.jpg", "/b.jpg"]}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_full items={@items} show_navigation />
        """)

      assert html =~ "btn-circle"
    end

    test "renders with indicators" do
      assigns = %{items: ["/a.jpg", "/b.jpg", "/c.jpg"]}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_full items={@items} show_indicators />
        """)

      assert html =~ "btn-xs"
    end

    test "uses custom prefix" do
      assigns = %{items: ["/a.jpg"]}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_full items={@items} id_prefix="gallery" />
        """)

      assert html =~ ~s(id="gallery0")
    end
  end

  describe "carousel_thumbnails/1" do
    test "renders carousel with thumbnail navigation" do
      assigns = %{items: ["/a.jpg", "/b.jpg", "/c.jpg"]}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_thumbnails items={@items} />
        """)

      assert html =~ "carousel"
      # Thumbnails
      assert html =~ "w-16"
    end

    test "thumbnails link to correct slides" do
      assigns = %{items: ["/a.jpg", "/b.jpg"]}

      html =
        rendered_to_string(~H"""
        <Carousel.carousel_thumbnails items={@items} id_prefix="slide" />
        """)

      assert html =~ ~s(href="#slide0")
      assert html =~ ~s(href="#slide1")
    end
  end
end
