defmodule MithrilUI.Components.BottomNavigationTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.BottomNavigation

  describe "bottom_nav/1" do
    test "renders dock container" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <BottomNavigation.bottom_nav>
          <:item label="Home">H</:item>
        </BottomNavigation.bottom_nav>
        """)

      assert html =~ "dock"
    end

    test "renders items with labels" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <BottomNavigation.bottom_nav>
          <:item label="Home">H</:item>
          <:item label="Search">S</:item>
        </BottomNavigation.bottom_nav>
        """)

      assert html =~ "dock-label"
      assert html =~ "Home"
      assert html =~ "Search"
    end

    test "renders active item" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <BottomNavigation.bottom_nav>
          <:item label="Home" active>H</:item>
          <:item label="Search">S</:item>
        </BottomNavigation.bottom_nav>
        """)

      assert html =~ "dock-active"
    end

    test "renders disabled item" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <BottomNavigation.bottom_nav>
          <:item label="Home" disabled>H</:item>
        </BottomNavigation.bottom_nav>
        """)

      assert html =~ "opacity-50"
      assert html =~ "disabled"
    end

    test "renders links for navigation items" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <BottomNavigation.bottom_nav>
          <:item label="Home" navigate="/">H</:item>
          <:item label="About" href="/about">A</:item>
        </BottomNavigation.bottom_nav>
        """)

      assert html =~ "<a"
      assert html =~ "navigate="
      assert html =~ ~s(href="/about")
    end

    test "renders buttons for non-link items" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <BottomNavigation.bottom_nav on_select="nav">
          <:item label="Home" value="home">H</:item>
        </BottomNavigation.bottom_nav>
        """)

      assert html =~ "<button"
      assert html =~ ~s(phx-click="nav")
      assert html =~ "phx-value-item"
    end

    test "renders badges" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <BottomNavigation.bottom_nav>
          <:item label="Messages" badge="5">M</:item>
        </BottomNavigation.bottom_nav>
        """)

      assert html =~ "badge"
      assert html =~ "5"
    end

    test "applies size variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <BottomNavigation.bottom_nav size="lg">
          <:item label="Home">H</:item>
        </BottomNavigation.bottom_nav>
        """)

      assert html =~ "dock-lg"
    end

    test "applies fixed positioning by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <BottomNavigation.bottom_nav>
          <:item label="Home">H</:item>
        </BottomNavigation.bottom_nav>
        """)

      assert html =~ "fixed"
      assert html =~ "bottom-0"
      assert html =~ "z-50"
    end

    test "removes fixed positioning when fixed=false" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <BottomNavigation.bottom_nav fixed={false}>
          <:item label="Home">H</:item>
        </BottomNavigation.bottom_nav>
        """)

      refute html =~ "fixed"
    end
  end

  describe "icon_bottom_nav/1" do
    test "renders icon-only navigation" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <BottomNavigation.icon_bottom_nav>
          <:item value="home" aria_label="Home">H</:item>
          <:item value="search" aria_label="Search">S</:item>
        </BottomNavigation.icon_bottom_nav>
        """)

      assert html =~ "dock"
      refute html =~ "dock-label"
    end

    test "includes aria labels" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <BottomNavigation.icon_bottom_nav>
          <:item value="home" aria_label="Go to Home">H</:item>
        </BottomNavigation.icon_bottom_nav>
        """)

      assert html =~ ~s(aria-label="Go to Home")
    end

    test "renders active item" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <BottomNavigation.icon_bottom_nav>
          <:item value="home" active>H</:item>
        </BottomNavigation.icon_bottom_nav>
        """)

      assert html =~ "dock-active"
    end

    test "includes phx-click event" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <BottomNavigation.icon_bottom_nav on_select="select_nav">
          <:item value="home">H</:item>
        </BottomNavigation.icon_bottom_nav>
        """)

      assert html =~ ~s(phx-click="select_nav")
      assert html =~ ~s(phx-value-item="home")
    end
  end

  describe "app_bar/1" do
    test "renders application bar with center action" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <BottomNavigation.app_bar>
          <:item value="home" label="Home">H</:item>
          <:item value="search" label="Search">S</:item>
          <:action>+</:action>
          <:item value="alerts" label="Alerts">A</:item>
          <:item value="profile" label="Profile">P</:item>
        </BottomNavigation.app_bar>
        """)

      assert html =~ "grid-cols-5"
      assert html =~ "btn-primary"
      assert html =~ "btn-circle"
    end

    test "renders all items" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <BottomNavigation.app_bar>
          <:item value="home" label="Home">H</:item>
          <:item value="search" label="Search">S</:item>
          <:action>+</:action>
          <:item value="alerts" label="Alerts">A</:item>
          <:item value="profile" label="Profile">P</:item>
        </BottomNavigation.app_bar>
        """)

      assert html =~ "Home"
      assert html =~ "Search"
      assert html =~ "Alerts"
      assert html =~ "Profile"
    end

    test "includes phx-click events" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <BottomNavigation.app_bar on_select="nav" on_action="create">
          <:item value="home">H</:item>
          <:action>+</:action>
          <:item value="profile">P</:item>
        </BottomNavigation.app_bar>
        """)

      assert html =~ ~s(phx-click="nav")
      assert html =~ ~s(phx-click="create")
    end

    test "renders active item" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <BottomNavigation.app_bar>
          <:item value="home" label="Home" active>H</:item>
          <:action>+</:action>
          <:item value="profile" label="Profile">P</:item>
        </BottomNavigation.app_bar>
        """)

      assert html =~ "text-primary"
    end

    test "is fixed to bottom" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <BottomNavigation.app_bar>
          <:item value="home">H</:item>
          <:action>+</:action>
          <:item value="profile">P</:item>
        </BottomNavigation.app_bar>
        """)

      assert html =~ "fixed"
      assert html =~ "bottom-0"
    end
  end
end
