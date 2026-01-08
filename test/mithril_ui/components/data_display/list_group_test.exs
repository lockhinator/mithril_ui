defmodule MithrilUI.Components.ListGroupTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.ListGroup

  describe "list_group/1 rendering" do
    test "renders basic list group" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ListGroup.list_group>
          <:item>Item 1</:item>
          <:item>Item 2</:item>
        </ListGroup.list_group>
        """)

      assert html =~ "menu"
      assert html =~ "Item 1"
      assert html =~ "Item 2"
    end

    test "renders as unordered list" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ListGroup.list_group>
          <:item>Item</:item>
        </ListGroup.list_group>
        """)

      assert html =~ "<ul"
      assert html =~ "<li"
    end
  end

  describe "list_group variants" do
    test "renders bordered by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ListGroup.list_group>
          <:item>Item</:item>
        </ListGroup.list_group>
        """)

      assert html =~ "border"
    end

    test "renders without border" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ListGroup.list_group bordered={false}>
          <:item>Item</:item>
        </ListGroup.list_group>
        """)

      refute html =~ "border-base-300"
    end

    test "renders rounded by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ListGroup.list_group>
          <:item>Item</:item>
        </ListGroup.list_group>
        """)

      assert html =~ "rounded-box"
    end

    test "renders horizontal" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ListGroup.list_group horizontal>
          <:item>Item</:item>
        </ListGroup.list_group>
        """)

      assert html =~ "menu-horizontal"
    end

    test "renders vertical by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ListGroup.list_group>
          <:item>Item</:item>
        </ListGroup.list_group>
        """)

      assert html =~ "menu-vertical"
    end
  end

  describe "list_group item states" do
    test "renders active item" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ListGroup.list_group>
          <:item active>Active</:item>
        </ListGroup.list_group>
        """)

      assert html =~ "active"
    end

    test "renders disabled item" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ListGroup.list_group>
          <:item disabled>Disabled</:item>
        </ListGroup.list_group>
        """)

      assert html =~ "disabled"
    end
  end

  describe "list_group links" do
    test "renders item with href" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ListGroup.list_group>
          <:item href="/path">Link</:item>
        </ListGroup.list_group>
        """)

      assert html =~ ~s(href="/path")
    end

    test "renders item with navigate" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ListGroup.list_group>
          <:item navigate="/dashboard">Dashboard</:item>
        </ListGroup.list_group>
        """)

      assert html =~ "data-phx-link"
    end
  end

  describe "list_group title slot" do
    test "renders title" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ListGroup.list_group>
          <:title>Menu</:title>
          <:item>Item</:item>
        </ListGroup.list_group>
        """)

      assert html =~ "menu-title"
      assert html =~ "Menu"
    end
  end

  describe "simple_list/1" do
    test "renders simple list from items" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ListGroup.simple_list items={["Apple", "Banana", "Cherry"]} />
        """)

      assert html =~ "Apple"
      assert html =~ "Banana"
      assert html =~ "Cherry"
    end

    test "applies item_class to each item" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ListGroup.simple_list items={["Item"]} item_class="text-primary" />
        """)

      assert html =~ "text-primary"
    end
  end

  describe "custom classes" do
    test "applies custom class to list_group" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ListGroup.list_group class="my-list">
          <:item>Item</:item>
        </ListGroup.list_group>
        """)

      assert html =~ "my-list"
    end

    test "applies custom class to item" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ListGroup.list_group>
          <:item class="item-class">Item</:item>
        </ListGroup.list_group>
        """)

      assert html =~ "item-class"
    end
  end
end
