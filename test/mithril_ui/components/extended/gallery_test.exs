defmodule MithrilUI.Components.GalleryTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Gallery

  describe "gallery/1" do
    test "renders basic gallery grid" do
      assigns = %{items: ["/a.jpg", "/b.jpg", "/c.jpg"]}

      html =
        rendered_to_string(~H"""
        <Gallery.gallery items={@items} />
        """)

      assert html =~ "grid"
      assert html =~ ~s(src="/a.jpg")
      assert html =~ ~s(src="/b.jpg")
      assert html =~ ~s(src="/c.jpg")
    end

    test "applies custom column count" do
      assigns = %{items: ["/a.jpg"]}

      html =
        rendered_to_string(~H"""
        <Gallery.gallery items={@items} columns="4" />
        """)

      assert html =~ "md:grid-cols-4"
    end

    test "applies custom gap" do
      assigns = %{items: ["/a.jpg"]}

      html =
        rendered_to_string(~H"""
        <Gallery.gallery items={@items} gap="2" />
        """)

      assert html =~ "gap-2"
    end

    test "applies rounded corners" do
      assigns = %{items: ["/a.jpg"]}

      html =
        rendered_to_string(~H"""
        <Gallery.gallery items={@items} rounded />
        """)

      assert html =~ "rounded-lg"
    end

    test "removes rounded corners when disabled" do
      assigns = %{items: ["/a.jpg"]}

      html =
        rendered_to_string(~H"""
        <Gallery.gallery items={@items} rounded={false} />
        """)

      refute html =~ "rounded-lg"
    end
  end

  describe "gallery_masonry/1" do
    test "renders masonry layout" do
      assigns = %{items: ["/1.jpg", "/2.jpg", "/3.jpg", "/4.jpg"]}

      html =
        rendered_to_string(~H"""
        <Gallery.gallery_masonry items={@items} />
        """)

      assert html =~ "grid"
      assert html =~ ~s(src="/1.jpg")
    end

    test "applies custom column count" do
      assigns = %{items: ["/1.jpg", "/2.jpg"]}

      html =
        rendered_to_string(~H"""
        <Gallery.gallery_masonry items={@items} columns="2" />
        """)

      assert html =~ "grid-cols-2"
    end
  end

  describe "gallery_featured/1" do
    test "renders featured image gallery" do
      assigns = %{items: ["/a.jpg", "/b.jpg", "/c.jpg", "/d.jpg", "/e.jpg"]}

      html =
        rendered_to_string(~H"""
        <Gallery.gallery_featured featured="/hero.jpg" items={@items} />
        """)

      assert html =~ ~s(src="/hero.jpg")
      assert html =~ "grid-cols-5"
    end
  end

  describe "gallery_quad/1" do
    test "renders 2x2 quad gallery" do
      assigns = %{items: ["/a.jpg", "/b.jpg", "/c.jpg", "/d.jpg"]}

      html =
        rendered_to_string(~H"""
        <Gallery.gallery_quad items={@items} />
        """)

      assert html =~ "grid-cols-2"
      assert html =~ ~s(src="/a.jpg")
      assert html =~ ~s(src="/d.jpg")
    end

    test "limits to 4 items" do
      assigns = %{items: ["/1.jpg", "/2.jpg", "/3.jpg", "/4.jpg", "/5.jpg", "/6.jpg"]}

      html =
        rendered_to_string(~H"""
        <Gallery.gallery_quad items={@items} />
        """)

      assert html =~ ~s(src="/4.jpg")
      refute html =~ ~s(src="/5.jpg")
    end

    test "applies custom gap" do
      assigns = %{items: ["/a.jpg", "/b.jpg", "/c.jpg", "/d.jpg"]}

      html =
        rendered_to_string(~H"""
        <Gallery.gallery_quad items={@items} gap="4" />
        """)

      assert html =~ "gap-4"
    end
  end

  describe "gallery_item/1" do
    test "renders gallery item with image" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Gallery.gallery_item src="/photo.jpg" />
        """)

      assert html =~ ~s(src="/photo.jpg")
    end

    test "renders with hover overlay" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Gallery.gallery_item src="/photo.jpg">
          <:overlay>View</:overlay>
        </Gallery.gallery_item>
        """)

      assert html =~ "group"
      assert html =~ "group-hover:opacity-100"
      assert html =~ "View"
    end

    test "applies alt text" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Gallery.gallery_item src="/photo.jpg" alt="Beautiful sunset" />
        """)

      assert html =~ ~s(alt="Beautiful sunset")
    end
  end

  describe "gallery_filtered/1" do
    test "renders gallery with filter buttons" do
      assigns = %{
        items: [
          %{src: "/a.jpg", category: "nature"},
          %{src: "/b.jpg", category: "city"}
        ],
        categories: ["all", "nature", "city"]
      }

      html =
        rendered_to_string(~H"""
        <Gallery.gallery_filtered items={@items} categories={@categories} />
        """)

      assert html =~ "All"
      assert html =~ "Nature"
      assert html =~ "City"
    end

    test "highlights active category" do
      assigns = %{
        items: [%{src: "/a.jpg", category: "nature"}],
        categories: ["all", "nature"]
      }

      html =
        rendered_to_string(~H"""
        <Gallery.gallery_filtered items={@items} categories={@categories} active_category="nature" />
        """)

      assert html =~ "btn-primary"
    end

    test "renders images" do
      assigns = %{
        items: [
          %{src: "/a.jpg", category: "nature"},
          %{src: "/b.jpg", category: "city"}
        ],
        categories: ["all", "nature", "city"]
      }

      html =
        rendered_to_string(~H"""
        <Gallery.gallery_filtered items={@items} categories={@categories} active_category="all" />
        """)

      assert html =~ ~s(src="/a.jpg")
      assert html =~ ~s(src="/b.jpg")
    end
  end
end
