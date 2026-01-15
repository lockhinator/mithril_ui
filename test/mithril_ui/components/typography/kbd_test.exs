defmodule MithrilUI.Components.KbdTest do
  use ExUnit.Case, async: true

  import Phoenix.Component
  import Phoenix.LiveViewTest

  alias MithrilUI.Components.Kbd

  describe "kbd/1" do
    test "renders keyboard key" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Kbd.kbd>Enter</Kbd.kbd>
        """)

      assert html =~ "<kbd"
      assert html =~ "Enter"
      assert html =~ "kbd"
    end

    test "applies size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Kbd.kbd size={:lg}>Space</Kbd.kbd>
        """)

      assert html =~ "kbd-lg"
    end

    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Kbd.kbd class="my-class">Tab</Kbd.kbd>
        """)

      assert html =~ "my-class"
    end
  end

  describe "kbd_combo/1" do
    test "renders key combination" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Kbd.kbd_combo keys={["Ctrl", "C"]} />
        """)

      assert html =~ "Ctrl"
      assert html =~ "C"
      assert html =~ "+"
    end

    test "renders multiple keys" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Kbd.kbd_combo keys={["Cmd", "Shift", "P"]} />
        """)

      assert html =~ "Cmd"
      assert html =~ "Shift"
      assert html =~ "P"
    end

    test "uses custom separator" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Kbd.kbd_combo keys={["Alt", "Tab"]} separator=" then " />
        """)

      assert html =~ "then"
    end
  end

  describe "kbd_shortcut/1" do
    test "renders shortcut with description" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Kbd.kbd_shortcut keys={["Ctrl", "S"]} description="Save file" />
        """)

      assert html =~ "Save file"
      assert html =~ "Ctrl"
      assert html =~ "S"
    end
  end

  describe "kbd_table/1" do
    test "renders shortcuts table" do
      assigns = %{
        shortcuts: [
          %{keys: ["Ctrl", "S"], description: "Save"},
          %{keys: ["Ctrl", "Z"], description: "Undo"}
        ]
      }

      html =
        rendered_to_string(~H"""
        <Kbd.kbd_table shortcuts={@shortcuts} />
        """)

      assert html =~ "Save"
      assert html =~ "Undo"
    end

    test "renders with title" do
      assigns = %{shortcuts: [%{keys: ["Esc"], description: "Close"}]}

      html =
        rendered_to_string(~H"""
        <Kbd.kbd_table shortcuts={@shortcuts} title="Shortcuts" />
        """)

      assert html =~ "Shortcuts"
    end
  end

  describe "kbd_arrow/1" do
    test "renders arrow keys" do
      for direction <- [:up, :down, :left, :right] do
        assigns = %{direction: direction}

        html =
          rendered_to_string(~H"""
          <Kbd.kbd_arrow direction={@direction} />
          """)

        assert html =~ "<kbd"
        assert html =~ "<svg"
        assert html =~ "sr-only"
      end
    end

    test "applies size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Kbd.kbd_arrow direction={:up} size={:lg} />
        """)

      assert html =~ "kbd-lg"
    end
  end
end
