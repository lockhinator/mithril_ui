defmodule MithrilUI.Components.SpeedDialTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.SpeedDial

  describe "speed_dial/1" do
    test "renders basic speed dial" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <SpeedDial.speed_dial id="actions">
          <:action icon="share" label="Share" />
          <:action icon="print" label="Print" />
        </SpeedDial.speed_dial>
        """)

      assert html =~ ~s(id="actions")
      assert html =~ "fixed"
      assert html =~ "group"
      assert html =~ ~s(data-dial-init)
    end

    test "renders with different positions" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <SpeedDial.speed_dial id="top-left" position="top-left">
          <:action icon="share" label="Share" />
        </SpeedDial.speed_dial>
        """)

      assert html =~ "start-6"
      assert html =~ "top-6"
    end

    test "renders with bottom-left position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <SpeedDial.speed_dial id="bottom-left" position="bottom-left">
          <:action icon="share" label="Share" />
        </SpeedDial.speed_dial>
        """)

      assert html =~ "start-6"
      assert html =~ "bottom-6"
    end

    test "renders with horizontal orientation" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <SpeedDial.speed_dial id="horizontal" orientation="horizontal">
          <:action icon="share" label="Share" />
        </SpeedDial.speed_dial>
        """)

      assert html =~ "flex-row"
    end

    test "renders with custom color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <SpeedDial.speed_dial id="colored" color="secondary">
          <:action icon="share" label="Share" />
        </SpeedDial.speed_dial>
        """)

      assert html =~ "btn-secondary"
    end

    test "renders with different trigger icon" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <SpeedDial.speed_dial id="menu-icon" icon="menu">
          <:action icon="share" label="Share" />
        </SpeedDial.speed_dial>
        """)

      assert html =~ "svg"
    end

    test "renders action buttons" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <SpeedDial.speed_dial id="with-actions">
          <:action icon="share" label="Share" />
          <:action icon="download" label="Download" />
        </SpeedDial.speed_dial>
        """)

      assert html =~ "Share"
      assert html =~ "Download"
    end
  end

  describe "speed_dial_simple/1" do
    test "renders simple speed dial with slots" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <SpeedDial.speed_dial_simple id="simple">
          <:trigger>
            <span>+</span>
          </:trigger>
          <:menu>
            <button class="btn btn-circle">A</button>
          </:menu>
        </SpeedDial.speed_dial_simple>
        """)

      assert html =~ ~s(id="simple")
      assert html =~ "fixed"
      assert html =~ "+"
      assert html =~ "A"
    end

    test "renders with custom position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <SpeedDial.speed_dial_simple id="positioned" position="top-right">
          <:trigger><span>T</span></:trigger>
          <:menu><span>Menu</span></:menu>
        </SpeedDial.speed_dial_simple>
        """)

      assert html =~ "end-6"
      assert html =~ "top-6"
    end
  end

  describe "speed_dial_labeled/1" do
    test "renders labeled speed dial" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <SpeedDial.speed_dial_labeled id="labeled">
          <:action icon="share" label="Share this" />
          <:action icon="edit" label="Edit item" />
        </SpeedDial.speed_dial_labeled>
        """)

      assert html =~ ~s(id="labeled")
      assert html =~ "Share this"
      assert html =~ "Edit item"
      assert html =~ "badge"
    end

    test "renders with custom color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <SpeedDial.speed_dial_labeled id="colored" color="accent">
          <:action icon="share" label="Share" />
        </SpeedDial.speed_dial_labeled>
        """)

      assert html =~ "btn-accent"
    end
  end

  describe "speed_dial_horizontal/1" do
    test "renders horizontal speed dial" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <SpeedDial.speed_dial_horizontal id="h-dial">
          <:action icon="share" label="Share" />
          <:action icon="print" label="Print" />
        </SpeedDial.speed_dial_horizontal>
        """)

      assert html =~ ~s(id="h-dial")
      assert html =~ "flex items-center"
      assert html =~ "space-x-2"
    end

    test "renders with custom position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <SpeedDial.speed_dial_horizontal id="h-pos" position="bottom-left">
          <:action icon="share" label="Share" />
        </SpeedDial.speed_dial_horizontal>
        """)

      assert html =~ "start-6"
      assert html =~ "bottom-6"
    end
  end

  describe "action slots" do
    test "renders action with href" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <SpeedDial.speed_dial id="links">
          <:action icon="share" label="Share" href="/share" />
        </SpeedDial.speed_dial>
        """)

      assert html =~ ~s(href="/share")
      assert html =~ "<a"
    end

    test "renders action with custom color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <SpeedDial.speed_dial id="colors">
          <:action icon="share" label="Share" color="success" />
        </SpeedDial.speed_dial>
        """)

      assert html =~ "btn-success"
    end
  end
end
