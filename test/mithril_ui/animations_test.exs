defmodule MithrilUI.AnimationsTest do
  use ExUnit.Case, async: true

  alias MithrilUI.Animations

  describe "animation tuples format" do
    # All animation functions should return a 3-tuple of strings:
    # {timing, from_classes, to_classes}

    test "modal_enter/0 returns valid transition tuple" do
      {timing, from, to} = Animations.modal_enter()

      assert is_binary(timing)
      assert is_binary(from)
      assert is_binary(to)
      assert timing =~ "ease"
      assert timing =~ "duration"
    end

    test "modal_leave/0 returns valid transition tuple" do
      {timing, from, to} = Animations.modal_leave()

      assert is_binary(timing)
      assert is_binary(from)
      assert is_binary(to)
    end

    test "dropdown_enter/0 returns valid transition tuple" do
      {timing, from, to} = Animations.dropdown_enter()

      assert is_binary(timing)
      assert is_binary(from)
      assert is_binary(to)
    end

    test "dropdown_leave/0 returns valid transition tuple" do
      {timing, from, to} = Animations.dropdown_leave()

      assert is_binary(timing)
      assert is_binary(from)
      assert is_binary(to)
    end

    test "toast_enter/0 returns valid transition tuple" do
      {timing, from, to} = Animations.toast_enter()

      assert is_binary(timing)
      assert is_binary(from)
      assert is_binary(to)
    end

    test "toast_leave/0 returns valid transition tuple" do
      {timing, from, to} = Animations.toast_leave()

      assert is_binary(timing)
      assert is_binary(from)
      assert is_binary(to)
    end

    test "drawer_enter/1 handles :left direction" do
      {timing, from, to} = Animations.drawer_enter(:left)

      assert is_binary(timing)
      assert is_binary(from)
      assert is_binary(to)
      assert from =~ "translate"
    end

    test "drawer_enter/1 handles :right direction" do
      {timing, from, to} = Animations.drawer_enter(:right)

      assert is_binary(timing)
      assert is_binary(from)
      assert is_binary(to)
    end

    test "drawer_leave/1 handles both directions" do
      {_, _, _} = Animations.drawer_leave(:left)
      {_, _, _} = Animations.drawer_leave(:right)
    end

    test "fade_in/0 returns valid transition tuple" do
      {timing, from, to} = Animations.fade_in()

      assert is_binary(timing)
      assert from =~ "opacity-0"
      assert to =~ "opacity-100"
    end

    test "fade_out/0 returns valid transition tuple" do
      {timing, from, to} = Animations.fade_out()

      assert is_binary(timing)
      assert from =~ "opacity-100"
      assert to =~ "opacity-0"
    end

    test "backdrop_enter/0 returns valid transition tuple" do
      {timing, from, to} = Animations.backdrop_enter()

      assert is_binary(timing)
      assert is_binary(from)
      assert is_binary(to)
    end

    test "backdrop_leave/0 returns valid transition tuple" do
      {timing, from, to} = Animations.backdrop_leave()

      assert is_binary(timing)
      assert is_binary(from)
      assert is_binary(to)
    end

    test "accordion_expand/0 returns valid transition tuple" do
      {timing, from, to} = Animations.accordion_expand()

      assert is_binary(timing)
      assert is_binary(from)
      assert is_binary(to)
    end

    test "accordion_collapse/0 returns valid transition tuple" do
      {timing, from, to} = Animations.accordion_collapse()

      assert is_binary(timing)
      assert is_binary(from)
      assert is_binary(to)
    end

    test "tooltip_enter/0 returns valid transition tuple" do
      {timing, from, to} = Animations.tooltip_enter()

      assert is_binary(timing)
      assert is_binary(from)
      assert is_binary(to)
    end

    test "tooltip_leave/0 returns valid transition tuple" do
      {timing, from, to} = Animations.tooltip_leave()

      assert is_binary(timing)
      assert is_binary(from)
      assert is_binary(to)
    end

    test "alert_enter/0 returns valid transition tuple" do
      {timing, from, to} = Animations.alert_enter()

      assert is_binary(timing)
      assert is_binary(from)
      assert is_binary(to)
    end

    test "alert_leave/0 returns valid transition tuple" do
      {timing, from, to} = Animations.alert_leave()

      assert is_binary(timing)
      assert is_binary(from)
      assert is_binary(to)
    end
  end

  describe "timing classes" do
    test "enter animations use ease-out" do
      {timing, _, _} = Animations.modal_enter()
      assert timing =~ "ease-out"

      {timing, _, _} = Animations.dropdown_enter()
      assert timing =~ "ease-out"

      {timing, _, _} = Animations.fade_in()
      assert timing =~ "ease-out"
    end

    test "leave animations use ease-in" do
      {timing, _, _} = Animations.modal_leave()
      assert timing =~ "ease-in"

      {timing, _, _} = Animations.dropdown_leave()
      assert timing =~ "ease-in"

      {timing, _, _} = Animations.fade_out()
      assert timing =~ "ease-in"
    end
  end
end
