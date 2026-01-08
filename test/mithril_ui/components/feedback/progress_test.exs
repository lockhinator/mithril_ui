defmodule MithrilUI.Components.ProgressTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Progress

  describe "progress/1 rendering" do
    test "renders basic progress bar" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.progress value={50} />
        """)

      assert html =~ "progress"
      assert html =~ ~s(value="50")
    end

    test "renders with max value" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.progress value={25} max={50} />
        """)

      assert html =~ ~s(max="50")
    end

    test "renders indeterminate when no value" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.progress />
        """)

      assert html =~ "progress"
      refute html =~ ~s(value=")
    end

    test "has progressbar role" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.progress value={50} />
        """)

      assert html =~ ~s(role="progressbar")
    end

    test "has aria attributes" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.progress value={75} max={100} />
        """)

      assert html =~ ~s(aria-valuenow="75")
      assert html =~ ~s(aria-valuemin="0")
      assert html =~ ~s(aria-valuemax="100")
    end
  end

  describe "progress variants" do
    test "renders primary variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.progress value={50} variant="primary" />
        """)

      assert html =~ "progress-primary"
    end

    test "renders success variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.progress value={100} variant="success" />
        """)

      assert html =~ "progress-success"
    end

    test "renders warning variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.progress value={30} variant="warning" />
        """)

      assert html =~ "progress-warning"
    end

    test "renders error variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.progress value={10} variant="error" />
        """)

      assert html =~ "progress-error"
    end
  end

  describe "progress label" do
    test "renders label when provided" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.progress value={50} label="Uploading..." />
        """)

      assert html =~ "Uploading..."
    end

    test "shows percentage when enabled" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.progress value={75} max={100} show_percentage />
        """)

      assert html =~ "75%"
    end

    test "calculates correct percentage" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.progress value={1} max={4} show_percentage />
        """)

      assert html =~ "25%"
    end
  end

  describe "progress sizes" do
    test "renders xs size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.progress value={50} size="xs" />
        """)

      assert html =~ "h-1"
    end

    test "renders lg size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.progress value={50} size="lg" />
        """)

      assert html =~ "h-4"
    end
  end

  describe "radial_progress/1" do
    test "renders radial progress" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.radial_progress value={70} />
        """)

      assert html =~ "radial-progress"
      assert html =~ "70%"
    end

    test "renders custom size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.radial_progress value={50} size="6rem" />
        """)

      assert html =~ "--size:6rem"
    end

    test "renders custom thickness" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.radial_progress value={50} thickness="8px" />
        """)

      assert html =~ "--thickness:8px"
    end

    test "renders variant color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.radial_progress value={100} variant="success" />
        """)

      assert html =~ "text-success"
    end

    test "has progressbar role" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.radial_progress value={50} />
        """)

      assert html =~ ~s(role="progressbar")
    end

    test "renders custom inner content" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.radial_progress value={50}>
          <span>Custom</span>
        </Progress.radial_progress>
        """)

      assert html =~ "Custom"
      refute html =~ "50%"
    end
  end

  describe "custom classes" do
    test "applies custom class to progress" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.progress value={50} class="my-progress" />
        """)

      assert html =~ "my-progress"
    end

    test "applies custom class to radial_progress" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Progress.radial_progress value={50} class="my-radial" />
        """)

      assert html =~ "my-radial"
    end
  end
end
