defmodule MithrilUI.Components.NavbarTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Navbar

  describe "navbar/1" do
    test "renders basic navbar container" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Navbar.navbar>
          <:start_section>Start</:start_section>
        </Navbar.navbar>
        """)

      assert html =~ "navbar"
      assert html =~ "navbar-start"
      assert html =~ "Start"
    end

    test "renders all three sections" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Navbar.navbar>
          <:start_section>Left</:start_section>
          <:center_section>Middle</:center_section>
          <:end_section>Right</:end_section>
        </Navbar.navbar>
        """)

      assert html =~ "navbar-start"
      assert html =~ "navbar-center"
      assert html =~ "navbar-end"
      assert html =~ "Left"
      assert html =~ "Middle"
      assert html =~ "Right"
    end

    test "applies shadow by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Navbar.navbar>
          <:start_section>Content</:start_section>
        </Navbar.navbar>
        """)

      assert html =~ "shadow-sm"
    end

    test "removes shadow when shadow=false" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Navbar.navbar shadow={false}>
          <:start_section>Content</:start_section>
        </Navbar.navbar>
        """)

      refute html =~ "shadow-sm"
    end

    test "applies sticky positioning" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Navbar.navbar sticky>
          <:start_section>Content</:start_section>
        </Navbar.navbar>
        """)

      assert html =~ "sticky"
      assert html =~ "top-0"
      assert html =~ "z-50"
    end

    test "applies bordered style" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Navbar.navbar bordered>
          <:start_section>Content</:start_section>
        </Navbar.navbar>
        """)

      assert html =~ "border-b"
      assert html =~ "border-base-200"
    end

    test "applies transparent background" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Navbar.navbar transparent>
          <:start_section>Content</:start_section>
        </Navbar.navbar>
        """)

      refute html =~ "bg-base-100"
    end

    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Navbar.navbar class="custom-class">
          <:start_section>Content</:start_section>
        </Navbar.navbar>
        """)

      assert html =~ "custom-class"
    end

    test "only renders sections that have content" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Navbar.navbar>
          <:start_section>Only Start</:start_section>
        </Navbar.navbar>
        """)

      assert html =~ "navbar-start"
      refute html =~ "navbar-center"
      refute html =~ "navbar-end"
    end
  end

  describe "navbar_dropdown/1" do
    test "renders dropdown structure" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Navbar.navbar_dropdown>
          <:trigger>Menu</:trigger>
          <:content>
            <li><a>Item 1</a></li>
          </:content>
        </Navbar.navbar_dropdown>
        """)

      assert html =~ "dropdown"
      assert html =~ "Menu"
      assert html =~ "dropdown-content"
      assert html =~ "Item 1"
    end

    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Navbar.navbar_dropdown class="dropdown-end">
          <:trigger>Menu</:trigger>
          <:content><li>Item</li></:content>
        </Navbar.navbar_dropdown>
        """)

      assert html =~ "dropdown-end"
    end

    test "includes menu styling" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Navbar.navbar_dropdown>
          <:trigger>Menu</:trigger>
          <:content><li>Item</li></:content>
        </Navbar.navbar_dropdown>
        """)

      assert html =~ "menu"
      assert html =~ "menu-sm"
      assert html =~ "rounded-box"
    end
  end

  describe "simple_navbar/1" do
    test "renders with title" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Navbar.simple_navbar title="My App" />
        """)

      assert html =~ "navbar"
      assert html =~ "My App"
      assert html =~ "btn-ghost"
    end

    test "renders with default href" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Navbar.simple_navbar title="Brand" />
        """)

      assert html =~ ~s(href="/")
    end

    test "renders with custom href" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Navbar.simple_navbar title="Brand" href="/home" />
        """)

      assert html =~ ~s(href="/home")
    end

    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Navbar.simple_navbar title="Brand" class="custom" />
        """)

      assert html =~ "custom"
    end
  end
end
