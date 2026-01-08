defmodule MithrilUI.Components.TooltipTest do
  use ExUnit.Case, async: true

  import Phoenix.Component
  import Phoenix.LiveViewTest

  alias MithrilUI.Components.Tooltip

  describe "tooltip/1" do
    test "renders basic tooltip with text" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tooltip.tooltip text="Hello world">
          <button>Hover me</button>
        </Tooltip.tooltip>
        """)

      assert html =~ "tooltip"
      assert html =~ ~s(data-tip="Hello world")
      assert html =~ "Hover me"
    end

    test "renders with default top position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tooltip.tooltip text="Top tooltip">
          <span>Trigger</span>
        </Tooltip.tooltip>
        """)

      assert html =~ "tooltip-top"
    end

    test "renders with bottom position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tooltip.tooltip text="Bottom" position={:bottom}>
          <span>Trigger</span>
        </Tooltip.tooltip>
        """)

      assert html =~ "tooltip-bottom"
    end

    test "renders with left position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tooltip.tooltip text="Left" position={:left}>
          <span>Trigger</span>
        </Tooltip.tooltip>
        """)

      assert html =~ "tooltip-left"
    end

    test "renders with right position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tooltip.tooltip text="Right" position={:right}>
          <span>Trigger</span>
        </Tooltip.tooltip>
        """)

      assert html =~ "tooltip-right"
    end

    test "renders with primary color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tooltip.tooltip text="Primary" color={:primary}>
          <span>Trigger</span>
        </Tooltip.tooltip>
        """)

      assert html =~ "tooltip-primary"
    end

    test "renders with secondary color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tooltip.tooltip text="Secondary" color={:secondary}>
          <span>Trigger</span>
        </Tooltip.tooltip>
        """)

      assert html =~ "tooltip-secondary"
    end

    test "renders with error color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tooltip.tooltip text="Error" color={:error}>
          <span>Trigger</span>
        </Tooltip.tooltip>
        """)

      assert html =~ "tooltip-error"
    end

    test "renders with success color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tooltip.tooltip text="Success" color={:success}>
          <span>Trigger</span>
        </Tooltip.tooltip>
        """)

      assert html =~ "tooltip-success"
    end

    test "renders with warning color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tooltip.tooltip text="Warning" color={:warning}>
          <span>Trigger</span>
        </Tooltip.tooltip>
        """)

      assert html =~ "tooltip-warning"
    end

    test "renders with info color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tooltip.tooltip text="Info" color={:info}>
          <span>Trigger</span>
        </Tooltip.tooltip>
        """)

      assert html =~ "tooltip-info"
    end

    test "renders with open state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tooltip.tooltip text="Always visible" open>
          <span>Trigger</span>
        </Tooltip.tooltip>
        """)

      assert html =~ "tooltip-open"
    end

    test "renders with custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tooltip.tooltip text="Custom" class="my-custom-class">
          <span>Trigger</span>
        </Tooltip.tooltip>
        """)

      assert html =~ "my-custom-class"
    end

    test "renders without color class when nil" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tooltip.tooltip text="Default" color={nil}>
          <span>Trigger</span>
        </Tooltip.tooltip>
        """)

      refute html =~ "tooltip-primary"
      refute html =~ "tooltip-secondary"
    end
  end

  describe "tooltip_content/1" do
    test "renders tooltip with custom content" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tooltip.tooltip_content>
          <:content>
            <div class="custom-content">Rich content</div>
          </:content>
          <button>Hover me</button>
        </Tooltip.tooltip_content>
        """)

      assert html =~ "tooltip"
      assert html =~ "tooltip-content"
      assert html =~ "custom-content"
      assert html =~ "Rich content"
    end

    test "renders with position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tooltip.tooltip_content position={:bottom}>
          <:content>Content</:content>
          <span>Trigger</span>
        </Tooltip.tooltip_content>
        """)

      assert html =~ "tooltip-bottom"
    end

    test "renders with color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tooltip.tooltip_content color={:accent}>
          <:content>Accent</:content>
          <span>Trigger</span>
        </Tooltip.tooltip_content>
        """)

      assert html =~ "tooltip-accent"
    end

    test "renders with open state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tooltip.tooltip_content open>
          <:content>Always open</:content>
          <span>Trigger</span>
        </Tooltip.tooltip_content>
        """)

      assert html =~ "tooltip-open"
    end
  end
end
