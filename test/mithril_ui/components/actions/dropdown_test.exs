defmodule MithrilUI.Components.DropdownTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Dropdown

  describe "dropdown/1 rendering" do
    test "renders dropdown with trigger and items" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test-dropdown">
          <:trigger>Open Menu</:trigger>
          <:item>Item 1</:item>
          <:item>Item 2</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ "dropdown"
      assert html =~ "Open Menu"
      assert html =~ "Item 1"
      assert html =~ "Item 2"
    end

    test "renders with dropdown-content class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test">
          <:trigger>Trigger</:trigger>
          <:item>Item</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ "dropdown-content"
    end

    test "renders menu items with menu class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test">
          <:trigger>Trigger</:trigger>
          <:item>Item</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ "menu"
    end
  end

  describe "dropdown positions" do
    test "renders with end position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test" position="end">
          <:trigger>Trigger</:trigger>
          <:item>Item</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ "dropdown-end"
    end

    test "renders with top position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test" position="top">
          <:trigger>Trigger</:trigger>
          <:item>Item</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ "dropdown-top"
    end

    test "renders with bottom position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test" position="bottom">
          <:trigger>Trigger</:trigger>
          <:item>Item</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ "dropdown-bottom"
    end

    test "renders with left position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test" position="left">
          <:trigger>Trigger</:trigger>
          <:item>Item</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ "dropdown-left"
    end

    test "renders with right position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test" position="right">
          <:trigger>Trigger</:trigger>
          <:item>Item</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ "dropdown-right"
    end
  end

  describe "dropdown states" do
    test "renders with hover trigger" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test" hover>
          <:trigger>Trigger</:trigger>
          <:item>Item</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ "dropdown-hover"
    end

    test "renders with open state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test" open>
          <:trigger>Trigger</:trigger>
          <:item>Item</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ "dropdown-open"
    end
  end

  describe "dropdown items" do
    test "renders disabled item" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test">
          <:trigger>Trigger</:trigger>
          <:item disabled>Disabled Item</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ "disabled"
      assert html =~ "aria-disabled"
    end

    test "renders item with custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test">
          <:trigger>Trigger</:trigger>
          <:item class="text-error">Delete</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ "text-error"
    end

    test "renders item with phx-click" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test">
          <:trigger>Trigger</:trigger>
          <:item phx-click="do_action">Action</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ ~s(phx-click="do_action")
    end

    test "renders item with navigate" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test">
          <:trigger>Trigger</:trigger>
          <:item navigate="/path">Navigate</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ ~s(navigate="/path")
    end

    test "renders item with href" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test">
          <:trigger>Trigger</:trigger>
          <:item href="/external">External</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ ~s(href="/external")
    end
  end

  describe "dropdown dividers" do
    test "renders divider between items" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test">
          <:trigger>Trigger</:trigger>
          <:item>Item 1</:item>
          <:divider />
          <:item>Item 2</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ "divider"
      assert html =~ ~s(role="separator")
    end
  end

  describe "dropdown custom content" do
    test "renders custom content slot" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test">
          <:trigger>Trigger</:trigger>
          <:content>
            <div class="custom-content">Custom HTML here</div>
          </:content>
        </Dropdown.dropdown>
        """)

      assert html =~ "custom-content"
      assert html =~ "Custom HTML here"
    end
  end

  describe "dropdown accessibility" do
    test "has aria-haspopup on trigger" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test">
          <:trigger>Trigger</:trigger>
          <:item>Item</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ ~s(aria-haspopup="true")
    end

    test "has role=menu on menu container" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test">
          <:trigger>Trigger</:trigger>
          <:item>Item</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ ~s(role="menu")
    end

    test "has role=menuitem on items" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test">
          <:trigger>Trigger</:trigger>
          <:item>Item</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ ~s(role="menuitem")
    end

    test "disabled items have tabindex=-1" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test">
          <:trigger>Trigger</:trigger>
          <:item disabled>Disabled</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ ~s(tabindex="-1")
    end
  end

  describe "dropdown custom classes" do
    test "applies custom class to container" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test" class="my-dropdown">
          <:trigger>Trigger</:trigger>
          <:item>Item</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ "my-dropdown"
    end

    test "applies custom class to menu" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.dropdown id="test" menu_class="my-menu">
          <:trigger>Trigger</:trigger>
          <:item>Item</:item>
        </Dropdown.dropdown>
        """)

      assert html =~ "my-menu"
    end
  end

  describe "animated_dropdown/1" do
    test "renders animated dropdown" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.animated_dropdown id="animated-test">
          <:trigger>Open</:trigger>
          <:item>Item 1</:item>
        </Dropdown.animated_dropdown>
        """)

      assert html =~ "dropdown"
      assert html =~ "Open"
      assert html =~ "Item 1"
    end

    test "has phx-click on trigger" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.animated_dropdown id="animated-test">
          <:trigger>Open</:trigger>
          <:item>Item</:item>
        </Dropdown.animated_dropdown>
        """)

      assert html =~ "phx-click"
    end

    test "has phx-click-away on menu" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.animated_dropdown id="animated-test">
          <:trigger>Open</:trigger>
          <:item>Item</:item>
        </Dropdown.animated_dropdown>
        """)

      assert html =~ "phx-click-away"
    end

    test "menu has hidden class by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.animated_dropdown id="animated-test">
          <:trigger>Open</:trigger>
          <:item>Item</:item>
        </Dropdown.animated_dropdown>
        """)

      assert html =~ "hidden"
    end

    test "menu has correct id based on dropdown id" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.animated_dropdown id="my-dropdown">
          <:trigger>Open</:trigger>
          <:item>Item</:item>
        </Dropdown.animated_dropdown>
        """)

      assert html =~ ~s(id="my-dropdown-menu")
    end

    test "trigger has aria-controls pointing to menu" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.animated_dropdown id="my-dropdown">
          <:trigger>Open</:trigger>
          <:item>Item</:item>
        </Dropdown.animated_dropdown>
        """)

      assert html =~ ~s(aria-controls="my-dropdown-menu")
    end

    test "applies position class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Dropdown.animated_dropdown id="test" position="end">
          <:trigger>Open</:trigger>
          <:item>Item</:item>
        </Dropdown.animated_dropdown>
        """)

      assert html =~ "dropdown-end"
    end
  end

  describe "JS functions" do
    test "show_dropdown returns JS struct" do
      js = Dropdown.show_dropdown("test")
      assert %Phoenix.LiveView.JS{} = js
    end

    test "hide_dropdown returns JS struct" do
      js = Dropdown.hide_dropdown("test")
      assert %Phoenix.LiveView.JS{} = js
    end

    test "toggle_dropdown returns JS struct" do
      js = Dropdown.toggle_dropdown("test")
      assert %Phoenix.LiveView.JS{} = js
    end
  end
end
