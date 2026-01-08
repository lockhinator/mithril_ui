defmodule MithrilUI.Components.DrawerTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Drawer

  describe "drawer/1 rendering" do
    test "renders basic drawer" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Drawer.drawer id="my-drawer">
          Drawer content
        </Drawer.drawer>
        """)

      assert html =~ "drawer"
      assert html =~ "Drawer content"
    end

    test "renders drawer toggle checkbox" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Drawer.drawer id="d1">Content</Drawer.drawer>
        """)

      assert html =~ "drawer-toggle"
      assert html =~ ~s(type="checkbox")
    end

    test "renders drawer-side container" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Drawer.drawer id="d1">Content</Drawer.drawer>
        """)

      assert html =~ "drawer-side"
    end
  end

  describe "drawer sides" do
    test "renders left drawer by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Drawer.drawer id="d1">Content</Drawer.drawer>
        """)

      refute html =~ "drawer-end"
    end

    test "renders right drawer with drawer-end" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Drawer.drawer id="d1" side="right">Content</Drawer.drawer>
        """)

      assert html =~ "drawer-end"
    end
  end

  describe "drawer trigger slot" do
    test "renders trigger when provided" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Drawer.drawer id="d1">
          <:trigger>
            <button>Open</button>
          </:trigger>
          Content
        </Drawer.drawer>
        """)

      assert html =~ "drawer-button"
      assert html =~ "Open"
    end
  end

  describe "drawer overlay" do
    test "renders overlay by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Drawer.drawer id="d1">Content</Drawer.drawer>
        """)

      assert html =~ "drawer-overlay"
    end

    test "hides overlay when overlay=false" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Drawer.drawer id="d1" overlay={false}>Content</Drawer.drawer>
        """)

      refute html =~ "drawer-overlay"
    end
  end

  describe "drawer open state" do
    test "checkbox unchecked by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Drawer.drawer id="d1">Content</Drawer.drawer>
        """)

      refute html =~ "checked"
    end

    test "checkbox checked when open=true" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Drawer.drawer id="d1" open>Content</Drawer.drawer>
        """)

      assert html =~ "checked"
    end
  end

  describe "drawer accessibility" do
    test "has role=dialog" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Drawer.drawer id="d1">Content</Drawer.drawer>
        """)

      assert html =~ ~s(role="dialog")
    end

    test "has aria-modal=true" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Drawer.drawer id="d1">Content</Drawer.drawer>
        """)

      assert html =~ ~s(aria-modal="true")
    end
  end

  describe "animated_drawer/1" do
    test "renders animated drawer" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Drawer.animated_drawer id="ad1">Content</Drawer.animated_drawer>
        """)

      assert html =~ ~s(id="ad1")
      assert html =~ "Content"
    end

    test "has hidden class by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Drawer.animated_drawer id="ad1">Content</Drawer.animated_drawer>
        """)

      assert html =~ "hidden"
    end

    test "renders close button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Drawer.animated_drawer id="ad1">Content</Drawer.animated_drawer>
        """)

      assert html =~ ~s(aria-label="Close drawer")
    end

    test "renders left side by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Drawer.animated_drawer id="ad1">Content</Drawer.animated_drawer>
        """)

      assert html =~ "left-0"
    end

    test "renders right side when specified" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Drawer.animated_drawer id="ad1" side="right">Content</Drawer.animated_drawer>
        """)

      assert html =~ "right-0"
    end
  end

  describe "custom classes" do
    test "applies custom class to drawer" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Drawer.drawer id="d1" class="w-80">Content</Drawer.drawer>
        """)

      assert html =~ "w-80"
    end
  end

  describe "JS functions" do
    test "show_drawer returns JS struct" do
      js = Drawer.show_drawer("test")
      assert %Phoenix.LiveView.JS{} = js
    end

    test "hide_drawer returns JS struct" do
      js = Drawer.hide_drawer("test")
      assert %Phoenix.LiveView.JS{} = js
    end

    test "show_drawer with right side" do
      js = Drawer.show_drawer("test", :right)
      assert %Phoenix.LiveView.JS{} = js
    end
  end
end
