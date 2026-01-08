defmodule MithrilUI.Components.HeadingTest do
  use ExUnit.Case, async: true

  import Phoenix.Component
  import Phoenix.LiveViewTest

  alias MithrilUI.Components.Heading

  describe "heading/1" do
    test "renders h1 by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Heading.heading>Page Title</Heading.heading>
        """)

      assert html =~ "<h1"
      assert html =~ "Page Title"
      assert html =~ "</h1>"
    end

    test "renders h2" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Heading.heading level={2}>Section Title</Heading.heading>
        """)

      assert html =~ "<h2"
      assert html =~ "</h2>"
    end

    test "renders h3 through h6" do
      assigns = %{}

      for level <- 3..6 do
        html =
          rendered_to_string(~H"""
          <Heading.heading level={level}>Heading</Heading.heading>
          """)

        assert html =~ "<h#{level}"
        assert html =~ "</h#{level}>"
      end
    end

    test "applies default size classes for each level" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Heading.heading level={1}>H1</Heading.heading>
        """)

      assert html =~ "text-4xl"
    end

    test "applies custom size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Heading.heading size={:xl}>Custom Size</Heading.heading>
        """)

      assert html =~ "text-xl"
    end

    test "applies primary color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Heading.heading color={:primary}>Primary</Heading.heading>
        """)

      assert html =~ "text-primary"
    end

    test "applies secondary color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Heading.heading color={:secondary}>Secondary</Heading.heading>
        """)

      assert html =~ "text-secondary"
    end

    test "applies muted color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Heading.heading color={:muted}>Muted</Heading.heading>
        """)

      assert html =~ "text-base-content/70"
    end

    test "applies font weight" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Heading.heading weight={:extrabold}>Bold</Heading.heading>
        """)

      assert html =~ "font-extrabold"
    end

    test "applies tracking" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Heading.heading tracking={:wide}>Wide</Heading.heading>
        """)

      assert html =~ "tracking-wide"
    end

    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Heading.heading class="my-custom-class">Custom</Heading.heading>
        """)

      assert html =~ "my-custom-class"
    end
  end
end
