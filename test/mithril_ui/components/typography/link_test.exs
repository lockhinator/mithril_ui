defmodule MithrilUI.Components.LinkTest do
  use ExUnit.Case, async: true

  import Phoenix.Component
  import Phoenix.LiveViewTest

  alias MithrilUI.Components.Link

  describe "styled_link/1" do
    test "renders basic link with href" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.styled_link href="/about">About</Link.styled_link>
        """)

      assert html =~ "<a"
      assert html =~ ~s(href="/about")
      assert html =~ "About"
    end

    test "renders link with navigate attribute" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.styled_link navigate="/dashboard">Dashboard</Link.styled_link>
        """)

      assert html =~ "<a"
      assert html =~ ~s(href="/dashboard")
      assert html =~ ~s(data-phx-link="redirect")
      assert html =~ "Dashboard"
    end

    test "renders link with patch attribute" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.styled_link patch="/users?page=2">Page 2</Link.styled_link>
        """)

      assert html =~ "<a"
      assert html =~ ~s(href="/users?page=2")
      assert html =~ ~s(data-phx-link="patch")
      assert html =~ "Page 2"
    end

    test "applies variant classes" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.styled_link href="/" variant={:secondary}>Link</Link.styled_link>
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

    test "navigate takes precedence over patch and href" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.styled_link navigate="/nav" patch="/patch" href="/href">Link</Link.styled_link>
        """)

      assert html =~ ~s(href="/nav")
      assert html =~ ~s(data-phx-link="redirect")
    end

    test "patch takes precedence over href" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.styled_link patch="/patch" href="/href">Link</Link.styled_link>
        """)

      assert html =~ ~s(href="/patch")
      assert html =~ ~s(data-phx-link="patch")
    end
  end

  describe "nav_link/1" do
    test "renders navigation link with href" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.nav_link href="/">Home</Link.nav_link>
        """)

      assert html =~ "<a"
      assert html =~ "Home"
    end

    test "renders navigation link with navigate" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.nav_link navigate="/dashboard">Dashboard</Link.nav_link>
        """)

      assert html =~ "<a"
      assert html =~ ~s(href="/dashboard")
      assert html =~ ~s(data-phx-link="redirect")
    end

    test "renders navigation link with patch" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.nav_link patch="/settings">Settings</Link.nav_link>
        """)

      assert html =~ "<a"
      assert html =~ ~s(href="/settings")
      assert html =~ ~s(data-phx-link="patch")
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

    test "applies active state with navigate" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.nav_link navigate="/dashboard" active>Dashboard</Link.nav_link>
        """)

      assert html =~ "text-primary"
      assert html =~ ~s(aria-current="page")
      assert html =~ ~s(data-phx-link="redirect")
    end
  end

  describe "button_link/1" do
    test "renders button-styled link with href" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.button_link href="/signup">Sign Up</Link.button_link>
        """)

      assert html =~ "<a"
      assert html =~ "btn"
      assert html =~ "Sign Up"
    end

    test "renders button-styled link with navigate" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.button_link navigate="/dashboard">Go to Dashboard</Link.button_link>
        """)

      assert html =~ "<a"
      assert html =~ "btn"
      assert html =~ ~s(href="/dashboard")
      assert html =~ ~s(data-phx-link="redirect")
    end

    test "renders button-styled link with patch" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.button_link patch="/settings">Settings</Link.button_link>
        """)

      assert html =~ "<a"
      assert html =~ "btn"
      assert html =~ ~s(href="/settings")
      assert html =~ ~s(data-phx-link="patch")
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

    test "applies variant with navigate" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Link.button_link navigate="/dashboard" variant={:primary} size={:sm}>Dashboard</Link.button_link>
        """)

      assert html =~ "btn-primary"
      assert html =~ "btn-sm"
      assert html =~ ~s(data-phx-link="redirect")
    end
  end
end
