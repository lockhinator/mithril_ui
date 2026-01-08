defmodule MithrilUI.Components.LinkTest do
  use ExUnit.Case, async: true

  import Phoenix.Component
  import Phoenix.LiveViewTest

  alias MithrilUI.Components.Link

  describe "styled_link/1" do
    test "renders basic link" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.styled_link href="/about">About</Link.styled_link>
        """)

      assert html =~ "<a"
      assert html =~ ~s(href="/about")
      assert html =~ "About"
    end

    test "applies color classes" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.styled_link href="/" color={:secondary}>Link</Link.styled_link>
        """)

      assert html =~ "text-secondary"
    end

    test "applies underline behavior" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.styled_link href="/" underline={:always}>Always underlined</Link.styled_link>
        """)

      assert html =~ "underline"

      html =
        rendered_to_string(~H"""
        <Link.styled_link href="/" underline={:none}>No underline</Link.styled_link>
        """)

      assert html =~ "no-underline"
    end

    test "renders external link" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.styled_link href="https://example.com" external>External</Link.styled_link>
        """)

      assert html =~ ~s(target="_blank")
      assert html =~ ~s(rel="noopener noreferrer")
      assert html =~ "<svg"
    end

    test "applies font weight" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.styled_link href="/" weight={:bold}>Bold link</Link.styled_link>
        """)

      assert html =~ "font-bold"
    end
  end

  describe "nav_link/1" do
    test "renders navigation link" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.nav_link href="/">Home</Link.nav_link>
        """)

      assert html =~ "<a"
      assert html =~ "Home"
    end

    test "applies active state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.nav_link href="/" active>Home</Link.nav_link>
        """)

      assert html =~ "text-primary"
      assert html =~ ~s(aria-current="page")
    end

    test "applies inactive state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.nav_link href="/about" active={false}>About</Link.nav_link>
        """)

      assert html =~ "text-base-content/70"
      refute html =~ ~s(aria-current)
    end
  end

  describe "button_link/1" do
    test "renders button-styled link" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.button_link href="/signup">Sign Up</Link.button_link>
        """)

      assert html =~ "<a"
      assert html =~ "btn"
      assert html =~ "Sign Up"
    end

    test "applies variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.button_link href="/" variant={:ghost}>Ghost</Link.button_link>
        """)

      assert html =~ "btn-ghost"
    end

    test "applies size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.button_link href="/" size={:lg}>Large</Link.button_link>
        """)

      assert html =~ "btn-lg"
    end

    test "renders external button link" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.button_link href="https://example.com" external>External</Link.button_link>
        """)

      assert html =~ ~s(target="_blank")
    end
  end
end
