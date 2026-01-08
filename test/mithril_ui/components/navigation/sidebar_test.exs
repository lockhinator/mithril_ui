defmodule MithrilUI.Components.SidebarTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Sidebar

  describe "sidebar/1" do
    test "renders basic sidebar with menu" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Sidebar.sidebar>
          <:item href="/">Home</:item>
        </Sidebar.sidebar>
        """)

      assert html =~ "<aside"
      assert html =~ "menu"
      assert html =~ "Home"
    end

    test "renders menu items with navigation" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Sidebar.sidebar>
          <:item navigate="/dashboard">Dashboard</:item>
          <:item patch="/settings">Settings</:item>
          <:item href="/about">About</:item>
        </Sidebar.sidebar>
        """)

      assert html =~ "navigate="
      assert html =~ "/dashboard"
      assert html =~ "patch="
      assert html =~ "/settings"
      assert html =~ ~s(href="/about")
    end

    test "renders active item" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Sidebar.sidebar>
          <:item href="/" active>Home</:item>
          <:item href="/about">About</:item>
        </Sidebar.sidebar>
        """)

      assert html =~ "active"
    end

    test "renders disabled item" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Sidebar.sidebar>
          <:item href="/" disabled>Disabled</:item>
        </Sidebar.sidebar>
        """)

      assert html =~ "disabled"
      assert html =~ "aria-disabled"
    end

    test "renders title sections" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Sidebar.sidebar>
          <:title>Main Menu</:title>
          <:item href="/">Home</:item>
        </Sidebar.sidebar>
        """)

      assert html =~ "menu-title"
      assert html =~ "Main Menu"
    end

    test "renders dividers" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Sidebar.sidebar>
          <:item href="/">Home</:item>
          <:divider />
          <:item href="/settings">Settings</:item>
        </Sidebar.sidebar>
        """)

      assert html =~ "border-t"
    end

    test "renders badges" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Sidebar.sidebar>
          <:item href="/" badge="New">Home</:item>
        </Sidebar.sidebar>
        """)

      assert html =~ "badge"
      assert html =~ "New"
    end

    test "renders badge with variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Sidebar.sidebar>
          <:item href="/" badge="5" badge_variant="primary">Messages</:item>
        </Sidebar.sidebar>
        """)

      assert html =~ "badge-primary"
    end

    test "renders submenus" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Sidebar.sidebar>
          <:submenu label="Settings">
            <li><a href="/profile">Profile</a></li>
          </:submenu>
        </Sidebar.sidebar>
        """)

      assert html =~ "<details"
      assert html =~ "<summary"
      assert html =~ "Settings"
      assert html =~ "Profile"
    end

    test "renders submenu open by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Sidebar.sidebar>
          <:submenu label="Menu" open>
            <li><a>Item</a></li>
          </:submenu>
        </Sidebar.sidebar>
        """)

      assert html =~ "open"
    end

    test "applies size variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Sidebar.sidebar size="lg">
          <:item href="/">Home</:item>
        </Sidebar.sidebar>
        """)

      assert html =~ "menu-lg"
    end

    test "applies default width" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Sidebar.sidebar>
          <:item href="/">Home</:item>
        </Sidebar.sidebar>
        """)

      assert html =~ "w-64"
    end

    test "applies custom width" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Sidebar.sidebar width="w-80">
          <:item href="/">Home</:item>
        </Sidebar.sidebar>
        """)

      assert html =~ "w-80"
    end
  end

  describe "menu/1" do
    test "renders horizontal menu" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Sidebar.menu horizontal>
          <:item href="/">Home</:item>
          <:item href="/about">About</:item>
        </Sidebar.menu>
        """)

      assert html =~ "menu-horizontal"
    end

    test "renders vertical menu by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Sidebar.menu>
          <:item href="/">Home</:item>
        </Sidebar.menu>
        """)

      assert html =~ "menu-vertical"
    end

    test "applies size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Sidebar.menu size="sm">
          <:item href="/">Home</:item>
        </Sidebar.menu>
        """)

      assert html =~ "menu-sm"
    end
  end

  describe "submenu_item/1" do
    test "renders submenu item" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Sidebar.submenu_item navigate="/profile">Profile</Sidebar.submenu_item>
        """)

      assert html =~ "<li>"
      assert html =~ "<a"
      assert html =~ "Profile"
    end

    test "renders active submenu item" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Sidebar.submenu_item href="/profile" active>Profile</Sidebar.submenu_item>
        """)

      assert html =~ "active"
    end

    test "renders disabled submenu item" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Sidebar.submenu_item href="/profile" disabled>Profile</Sidebar.submenu_item>
        """)

      assert html =~ "disabled"
      assert html =~ "aria-disabled"
    end
  end
end
