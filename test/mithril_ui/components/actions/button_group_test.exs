defmodule MithrilUI.Components.ButtonGroupTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.ButtonGroup

  describe "button_group/1 rendering" do
    test "renders button group with multiple buttons" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.button_group>
          <:button>Left</:button>
          <:button>Center</:button>
          <:button>Right</:button>
        </ButtonGroup.button_group>
        """)

      assert html =~ "join"
      assert html =~ "join-item"
      assert html =~ "Left"
      assert html =~ "Center"
      assert html =~ "Right"
    end

    test "renders horizontal orientation by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.button_group>
          <:button>A</:button>
          <:button>B</:button>
        </ButtonGroup.button_group>
        """)

      assert html =~ "join-horizontal"
    end

    test "renders vertical orientation" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.button_group orientation="vertical">
          <:button>A</:button>
          <:button>B</:button>
        </ButtonGroup.button_group>
        """)

      assert html =~ "join-vertical"
    end

    test "renders with role=group" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.button_group>
          <:button>A</:button>
        </ButtonGroup.button_group>
        """)

      assert html =~ ~s(role="group")
    end
  end

  describe "button_group variants" do
    test "applies variant to all buttons" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.button_group variant="primary">
          <:button>A</:button>
          <:button>B</:button>
        </ButtonGroup.button_group>
        """)

      # Should have btn-primary for each button
      assert html =~ "btn-primary"
      # Count occurrences
      count = length(String.split(html, "btn-primary")) - 1
      assert count == 2
    end

    test "applies secondary variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.button_group variant="secondary">
          <:button>A</:button>
        </ButtonGroup.button_group>
        """)

      assert html =~ "btn-secondary"
    end

    test "applies outline style" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.button_group variant="primary" outline>
          <:button>A</:button>
        </ButtonGroup.button_group>
        """)

      assert html =~ "btn-outline"
      assert html =~ "btn-primary"
    end
  end

  describe "button_group sizes" do
    test "applies size to all buttons" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.button_group size="sm">
          <:button>A</:button>
          <:button>B</:button>
        </ButtonGroup.button_group>
        """)

      count = length(String.split(html, "btn-sm")) - 1
      assert count == 2
    end

    test "applies lg size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.button_group size="lg">
          <:button>A</:button>
        </ButtonGroup.button_group>
        """)

      assert html =~ "btn-lg"
    end
  end

  describe "button_group states" do
    test "disables all buttons when group is disabled" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.button_group disabled>
          <:button>A</:button>
          <:button>B</:button>
        </ButtonGroup.button_group>
        """)

      assert html =~ "btn-disabled"
      assert html =~ "disabled"
    end

    test "disables individual button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.button_group>
          <:button>Enabled</:button>
          <:button disabled>Disabled</:button>
        </ButtonGroup.button_group>
        """)

      # Only one button should have btn-disabled
      count = length(String.split(html, "btn-disabled")) - 1
      assert count == 1
    end

    test "shows active state on button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.button_group>
          <:button>Normal</:button>
          <:button active>Active</:button>
        </ButtonGroup.button_group>
        """)

      assert html =~ "btn-active"
    end
  end

  describe "button_group slot attributes" do
    test "applies custom class to individual button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.button_group>
          <:button>Normal</:button>
          <:button class="custom-class">Custom</:button>
        </ButtonGroup.button_group>
        """)

      assert html =~ "custom-class"
    end

    test "passes through phx-click to button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.button_group>
          <:button phx-click="do_something">Click</:button>
        </ButtonGroup.button_group>
        """)

      assert html =~ ~s(phx-click="do_something")
    end

    test "passes through phx-value to button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.button_group>
          <:button phx-click="select" phx-value-item="test">Select</:button>
        </ButtonGroup.button_group>
        """)

      assert html =~ ~s(phx-value-item="test")
    end

    test "renders button with custom type" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.button_group>
          <:button type="submit">Submit</:button>
        </ButtonGroup.button_group>
        """)

      assert html =~ ~s(type="submit")
    end

    test "defaults to button type" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.button_group>
          <:button>Click</:button>
        </ButtonGroup.button_group>
        """)

      assert html =~ ~s(type="button")
    end
  end

  describe "button_group custom classes" do
    test "applies custom class to container" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.button_group class="my-custom-class">
          <:button>A</:button>
        </ButtonGroup.button_group>
        """)

      assert html =~ "my-custom-class"
      assert html =~ "join"
    end
  end

  describe "radio_button_group/1" do
    test "renders radio buttons with options" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.radio_button_group
          name="choice"
          options={[{"Option A", "a"}, {"Option B", "b"}]}
        />
        """)

      assert html =~ ~s(type="radio")
      assert html =~ ~s(name="choice")
      assert html =~ ~s(value="a")
      assert html =~ ~s(value="b")
    end

    test "marks selected value as checked" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.radio_button_group
          name="choice"
          value="b"
          options={[{"A", "a"}, {"B", "b"}]}
        />
        """)

      assert html =~ "checked"
    end

    test "applies variant to radio buttons" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.radio_button_group
          name="choice"
          options={[{"A", "a"}]}
          variant="primary"
        />
        """)

      assert html =~ "btn-primary"
    end

    test "applies size to radio buttons" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.radio_button_group
          name="choice"
          options={[{"A", "a"}]}
          size="sm"
        />
        """)

      assert html =~ "btn-sm"
    end

    test "renders with role=radiogroup" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.radio_button_group
          name="choice"
          options={[{"A", "a"}]}
        />
        """)

      assert html =~ ~s(role="radiogroup")
    end

    test "supports outline style" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.radio_button_group
          name="choice"
          options={[{"A", "a"}]}
          variant="primary"
          outline
        />
        """)

      assert html =~ "btn-outline"
    end

    test "disables all radio buttons when disabled" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.radio_button_group
          name="choice"
          options={[{"A", "a"}, {"B", "b"}]}
          disabled
        />
        """)

      # Both should be disabled
      assert html =~ "disabled"
    end

    test "renders vertical orientation" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.radio_button_group
          name="choice"
          options={[{"A", "a"}]}
          orientation="vertical"
        />
        """)

      assert html =~ "join-vertical"
    end

    test "passes through phx-change" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.radio_button_group
          name="choice"
          options={[{"A", "a"}]}
          phx-change="changed"
        />
        """)

      assert html =~ ~s(phx-change="changed")
    end

    test "sets aria-label from option label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.radio_button_group
          name="choice"
          options={[{"Option A", "a"}]}
        />
        """)

      assert html =~ ~s(aria-label="Option A")
    end

    test "handles simple string options" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ButtonGroup.radio_button_group
          name="choice"
          options={["one", "two"]}
        />
        """)

      assert html =~ ~s(value="one")
      assert html =~ ~s(value="two")
      assert html =~ ~s(aria-label="one")
      assert html =~ ~s(aria-label="two")
    end
  end
end
