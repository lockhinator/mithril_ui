defmodule MithrilUI.Components.TextTest do
  use ExUnit.Case, async: true

  import Phoenix.Component
  import Phoenix.LiveViewTest

  alias MithrilUI.Components.Text

  describe "text/1" do
    test "renders paragraph by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Text.text>Paragraph text</Text.text>
        """)

      assert html =~ "<p"
      assert html =~ "Paragraph text"
      assert html =~ "</p>"
    end

    test "renders as span" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Text.text tag="span">Span text</Text.text>
        """)

      assert html =~ "<span"
      assert html =~ "</span>"
    end

    test "renders as div" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Text.text tag="div">Div text</Text.text>
        """)

      assert html =~ "<div"
      assert html =~ "</div>"
    end

    test "applies size classes" do
      assigns = %{}

      for {size, class} <- [xs: "text-xs", sm: "text-sm", lg: "text-lg"] do
        html =
          rendered_to_string(~H"""
          <Text.text size={size}>Text</Text.text>
          """)

        assert html =~ class
      end
    end

    test "applies color classes" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Text.text color={:error}>Error text</Text.text>
        """)

      assert html =~ "text-error"
    end

    test "applies weight" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Text.text weight={:bold}>Bold text</Text.text>
        """)

      assert html =~ "font-bold"
    end

    test "applies alignment" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Text.text align={:center}>Centered</Text.text>
        """)

      assert html =~ "text-center"
    end

    test "applies line height" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Text.text leading={:relaxed}>Relaxed</Text.text>
        """)

      assert html =~ "leading-relaxed"
    end

    test "applies italic style" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Text.text italic>Italic text</Text.text>
        """)

      assert html =~ "italic"
    end

    test "applies underline" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Text.text underline>Underlined</Text.text>
        """)

      assert html =~ "underline"
    end

    test "applies strikethrough" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Text.text strikethrough>Strikethrough</Text.text>
        """)

      assert html =~ "line-through"
    end

    test "applies uppercase" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Text.text uppercase>Uppercase</Text.text>
        """)

      assert html =~ "uppercase"
    end
  end

  describe "lead/1" do
    test "renders lead paragraph" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Text.lead>Lead paragraph</Text.lead>
        """)

      assert html =~ "<p"
      assert html =~ "text-xl"
      assert html =~ "leading-relaxed"
    end
  end

  describe "small/1" do
    test "renders small text" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Text.small>Small text</Text.small>
        """)

      assert html =~ "<small"
      assert html =~ "text-sm"
    end
  end

  describe "mark/1" do
    test "renders highlighted text" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Text.mark>Highlighted</Text.mark>
        """)

      assert html =~ "<mark"
      assert html =~ "Highlighted"
    end

    test "applies primary color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Text.mark color={:primary}>Primary</Text.mark>
        """)

      assert html =~ "bg-primary"
    end
  end
end
