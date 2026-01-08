defmodule MithrilUI.Components.BlockquoteTest do
  use ExUnit.Case, async: true

  import Phoenix.Component
  import Phoenix.LiveViewTest

  alias MithrilUI.Components.Blockquote

  describe "blockquote/1" do
    test "renders basic blockquote" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Blockquote.blockquote>
          Quote content here
        </Blockquote.blockquote>
        """)

      assert html =~ "<figure"
      assert html =~ "<blockquote"
      assert html =~ "Quote content here"
      assert html =~ "italic"
    end

    test "renders with citation" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Blockquote.blockquote cite="Steve Jobs">
          Stay hungry, stay foolish.
        </Blockquote.blockquote>
        """)

      assert html =~ "<cite"
      assert html =~ "Steve Jobs"
    end

    test "renders citation with URL" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Blockquote.blockquote cite="Author" cite_url="https://example.com">
          Quote text
        </Blockquote.blockquote>
        """)

      assert html =~ ~s(href="https://example.com")
    end

    test "renders bordered variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Blockquote.blockquote variant={:bordered}>
          Bordered quote
        </Blockquote.blockquote>
        """)

      assert html =~ "border-l-4"
      assert html =~ "border-primary"
    end

    test "renders solid variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Blockquote.blockquote variant={:solid}>
          Solid quote
        </Blockquote.blockquote>
        """)

      assert html =~ "bg-base-200"
      assert html =~ "rounded-box"
    end

    test "renders with icon" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Blockquote.blockquote icon>
          Quote with icon
        </Blockquote.blockquote>
        """)

      assert html =~ "<svg"
    end

    test "applies size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Blockquote.blockquote size={:xl}>
          Large quote
        </Blockquote.blockquote>
        """)

      assert html =~ "text-2xl"
    end

    test "applies alignment" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Blockquote.blockquote align={:center}>
          Centered
        </Blockquote.blockquote>
        """)

      assert html =~ "text-center"
    end
  end

  describe "testimonial/1" do
    test "renders testimonial with author" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Blockquote.testimonial author="John Doe">
          Great product!
        </Blockquote.testimonial>
        """)

      assert html =~ "<figure"
      assert html =~ "John Doe"
      assert html =~ "Great product!"
    end

    test "renders with title" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Blockquote.testimonial author="Jane" title="CEO">
          Amazing service
        </Blockquote.testimonial>
        """)

      assert html =~ "CEO"
    end

    test "renders with avatar" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Blockquote.testimonial author="Bob" avatar="/images/bob.jpg">
          Testimonial content
        </Blockquote.testimonial>
        """)

      assert html =~ ~s(src="/images/bob.jpg")
    end

    test "renders placeholder avatar when no image" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Blockquote.testimonial author="Alice Smith">
          Content
        </Blockquote.testimonial>
        """)

      assert html =~ "placeholder"
      assert html =~ "AS"
    end

    test "renders with rating" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Blockquote.testimonial author="Test" rating={4}>
          Rated content
        </Blockquote.testimonial>
        """)

      # Should have 5 stars, 4 filled
      assert html =~ "text-warning"
    end
  end
end
