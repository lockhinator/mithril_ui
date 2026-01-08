defmodule MithrilUI.Components.PopoverTest do
  use ExUnit.Case, async: true

  import Phoenix.Component
  import Phoenix.LiveViewTest

  alias MithrilUI.Components.Popover

  describe "popover/1" do
    test "renders basic popover with trigger and content" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Popover.popover>
          <:trigger>
            <button>Show Info</button>
          </:trigger>
          <:content>
            <p>Popover content here</p>
          </:content>
        </Popover.popover>
        """)

      assert html =~ "group relative"
      assert html =~ "Show Info"
      assert html =~ "Popover content here"
      assert html =~ ~s(role="tooltip")
    end

    test "renders with title" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Popover.popover>
          <:trigger><button>Trigger</button></:trigger>
          <:title>My Title</:title>
          <:content>Content</:content>
        </Popover.popover>
        """)

      assert html =~ "My Title"
      assert html =~ "font-semibold"
    end

    test "renders with footer" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Popover.popover>
          <:trigger><button>Trigger</button></:trigger>
          <:content>Content</:content>
          <:footer>Footer actions</:footer>
        </Popover.popover>
        """)

      assert html =~ "Footer actions"
    end

    test "renders with bottom position (default)" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Popover.popover>
          <:trigger><button>Trigger</button></:trigger>
          <:content>Content</:content>
        </Popover.popover>
        """)

      assert html =~ "top-full"
      assert html =~ "mt-2"
    end

    test "renders with top position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Popover.popover position={:top}>
          <:trigger><button>Trigger</button></:trigger>
          <:content>Content</:content>
        </Popover.popover>
        """)

      assert html =~ "bottom-full"
      assert html =~ "mb-2"
    end

    test "renders with left position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Popover.popover position={:left}>
          <:trigger><button>Trigger</button></:trigger>
          <:content>Content</:content>
        </Popover.popover>
        """)

      assert html =~ "right-full"
      assert html =~ "mr-2"
    end

    test "renders with right position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Popover.popover position={:right}>
          <:trigger><button>Trigger</button></:trigger>
          <:content>Content</:content>
        </Popover.popover>
        """)

      assert html =~ "left-full"
      assert html =~ "ml-2"
    end

    test "renders with custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Popover.popover class="my-class">
          <:trigger><button>Trigger</button></:trigger>
          <:content>Content</:content>
        </Popover.popover>
        """)

      assert html =~ "my-class"
    end

    test "renders with id" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Popover.popover id="my-popover">
          <:trigger><button>Trigger</button></:trigger>
          <:content>Content</:content>
        </Popover.popover>
        """)

      assert html =~ ~s(id="my-popover")
    end

    test "renders arrow element" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Popover.popover>
          <:trigger><button>Trigger</button></:trigger>
          <:content>Content</:content>
        </Popover.popover>
        """)

      assert html =~ "rotate-45"
    end
  end

  describe "popover_click/1" do
    test "renders click-triggered popover" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Popover.popover_click id="click-pop">
          <:trigger><button>Click me</button></:trigger>
          <:content>Click content</:content>
        </Popover.popover_click>
        """)

      assert html =~ "dropdown"
      assert html =~ "dropdown-content"
      assert html =~ "Click me"
      assert html =~ "Click content"
    end

    test "renders with top position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Popover.popover_click id="top-pop" position={:top}>
          <:trigger><button>Trigger</button></:trigger>
          <:content>Content</:content>
        </Popover.popover_click>
        """)

      assert html =~ "dropdown-top"
    end

    test "renders with end alignment" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Popover.popover_click id="end-pop" align={:end}>
          <:trigger><button>Trigger</button></:trigger>
          <:content>Content</:content>
        </Popover.popover_click>
        """)

      assert html =~ "dropdown-end"
    end

    test "renders with title and footer" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Popover.popover_click id="full-pop">
          <:trigger><button>Trigger</button></:trigger>
          <:title>Title</:title>
          <:content>Content</:content>
          <:footer>Footer</:footer>
        </Popover.popover_click>
        """)

      assert html =~ "Title"
      assert html =~ "Content"
      assert html =~ "Footer"
    end
  end

  describe "popover_controlled/1" do
    test "renders controlled popover" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Popover.popover_controlled id="ctrl-pop">
          <:trigger><button>Trigger</button></:trigger>
          <:content>Controlled content</:content>
        </Popover.popover_controlled>
        """)

      assert html =~ ~s(id="ctrl-pop")
      assert html =~ "hidden"
      assert html =~ "Controlled content"
    end

    test "renders with initial show state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Popover.popover_controlled id="show-pop" show={true}>
          <:trigger><button>Trigger</button></:trigger>
          <:content>Content</:content>
        </Popover.popover_controlled>
        """)

      assert html =~ "phx-mounted"
    end
  end

  describe "show_popover/1" do
    test "returns JS struct" do
      result = Popover.show_popover("test-id")
      assert %Phoenix.LiveView.JS{} = result
    end
  end

  describe "hide_popover/1" do
    test "returns JS struct with string id" do
      result = Popover.hide_popover("test-id")
      assert %Phoenix.LiveView.JS{} = result
    end

    test "returns JS struct with existing JS and id" do
      js = Phoenix.LiveView.JS.push("event")
      result = Popover.hide_popover(js, "test-id")
      assert %Phoenix.LiveView.JS{} = result
    end
  end
end
