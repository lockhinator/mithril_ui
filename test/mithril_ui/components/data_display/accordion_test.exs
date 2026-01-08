defmodule MithrilUI.Components.AccordionTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Accordion

  describe "accordion/1 rendering" do
    test "renders accordion with items" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Accordion.accordion>
          <:item title="Section 1">Content 1</:item>
          <:item title="Section 2">Content 2</:item>
        </Accordion.accordion>
        """)

      assert html =~ "collapse"
      assert html =~ "Section 1"
      assert html =~ "Section 2"
      assert html =~ "Content 1"
      assert html =~ "Content 2"
    end

    test "renders with radio inputs for single-open behavior" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Accordion.accordion>
          <:item title="Item 1">Content</:item>
          <:item title="Item 2">Content</:item>
        </Accordion.accordion>
        """)

      assert html =~ ~s(type="radio")
    end

    test "uses same name for radio group" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Accordion.accordion name="my-accordion">
          <:item title="Item 1">Content</:item>
          <:item title="Item 2">Content</:item>
        </Accordion.accordion>
        """)

      assert html =~ ~s(name="my-accordion")
    end
  end

  describe "accordion icons" do
    test "renders arrow icon by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Accordion.accordion>
          <:item title="Item">Content</:item>
        </Accordion.accordion>
        """)

      assert html =~ "collapse-arrow"
    end

    test "renders plus icon" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Accordion.accordion icon="plus">
          <:item title="Item">Content</:item>
        </Accordion.accordion>
        """)

      assert html =~ "collapse-plus"
    end

    test "renders no icon" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Accordion.accordion icon="none">
          <:item title="Item">Content</:item>
        </Accordion.accordion>
        """)

      refute html =~ "collapse-arrow"
      refute html =~ "collapse-plus"
    end
  end

  describe "accordion join" do
    test "joins items by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Accordion.accordion>
          <:item title="Item">Content</:item>
        </Accordion.accordion>
        """)

      assert html =~ "join"
      assert html =~ "join-item"
    end

    test "does not join when join=false" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Accordion.accordion join={false}>
          <:item title="Item">Content</:item>
        </Accordion.accordion>
        """)

      refute html =~ "join-item"
    end
  end

  describe "accordion item open state" do
    test "renders item as checked when open" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Accordion.accordion>
          <:item title="Closed">Content</:item>
          <:item title="Open" open>Content</:item>
        </Accordion.accordion>
        """)

      assert html =~ "checked"
    end
  end

  describe "collapse/1" do
    test "renders standalone collapse" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Accordion.collapse title="Click me">
          Hidden content
        </Accordion.collapse>
        """)

      assert html =~ "collapse"
      assert html =~ "Click me"
      assert html =~ "Hidden content"
    end

    test "renders with checkbox" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Accordion.collapse title="Toggle">Content</Accordion.collapse>
        """)

      assert html =~ ~s(type="checkbox")
    end

    test "renders open collapse" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Accordion.collapse title="Open" open>Content</Accordion.collapse>
        """)

      assert html =~ "checked"
    end

    test "renders with icon style" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Accordion.collapse title="Plus" icon="plus">Content</Accordion.collapse>
        """)

      assert html =~ "collapse-plus"
    end
  end

  describe "custom classes" do
    test "applies custom class to accordion" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Accordion.accordion class="my-accordion">
          <:item title="Item">Content</:item>
        </Accordion.accordion>
        """)

      assert html =~ "my-accordion"
    end

    test "applies custom class to collapse" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Accordion.collapse title="Item" class="my-collapse">Content</Accordion.collapse>
        """)

      assert html =~ "my-collapse"
    end
  end
end
