defmodule MithrilUI.Components.SpinnerTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Spinner

  describe "spinner/1 rendering" do
    test "renders basic spinner" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner />
        """)

      assert html =~ "loading"
      assert html =~ "loading-spinner"
    end

    test "has status role" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner />
        """)

      assert html =~ ~s(role="status")
    end

    test "has screen reader text" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner />
        """)

      assert html =~ "sr-only"
      assert html =~ "Loading"
    end

    test "renders custom label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner label="Processing" />
        """)

      assert html =~ ~s(aria-label="Processing")
      assert html =~ "Processing"
    end
  end

  describe "spinner types" do
    test "renders spinner type" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner type="spinner" />
        """)

      assert html =~ "loading-spinner"
    end

    test "renders dots type" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner type="dots" />
        """)

      assert html =~ "loading-dots"
    end

    test "renders ring type" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner type="ring" />
        """)

      assert html =~ "loading-ring"
    end

    test "renders ball type" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner type="ball" />
        """)

      assert html =~ "loading-ball"
    end

    test "renders bars type" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner type="bars" />
        """)

      assert html =~ "loading-bars"
    end

    test "renders infinity type" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner type="infinity" />
        """)

      assert html =~ "loading-infinity"
    end
  end

  describe "spinner sizes" do
    test "renders xs size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner size="xs" />
        """)

      assert html =~ "loading-xs"
    end

    test "renders sm size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner size="sm" />
        """)

      assert html =~ "loading-sm"
    end

    test "renders md size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner size="md" />
        """)

      assert html =~ "loading-md"
    end

    test "renders lg size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner size="lg" />
        """)

      assert html =~ "loading-lg"
    end
  end

  describe "spinner variants" do
    test "renders primary variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner variant="primary" />
        """)

      assert html =~ "text-primary"
    end

    test "renders success variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner variant="success" />
        """)

      assert html =~ "text-success"
    end

    test "renders error variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner variant="error" />
        """)

      assert html =~ "text-error"
    end
  end

  describe "spinner_with_text/1" do
    test "renders spinner with text" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner_with_text text="Loading..." />
        """)

      assert html =~ "loading"
      assert html =~ "Loading..."
    end

    test "has status role" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner_with_text text="Loading" />
        """)

      assert html =~ ~s(role="status")
    end

    test "renders with right position by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner_with_text text="Loading" />
        """)

      # Text should come after spinner (not flex-col)
      refute html =~ "flex-col"
    end

    test "renders with bottom position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner_with_text text="Loading" position="bottom" />
        """)

      assert html =~ "flex-col"
    end

    test "applies spinner type" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner_with_text text="Loading" type="dots" />
        """)

      assert html =~ "loading-dots"
    end

    test "applies size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner_with_text text="Loading" size="lg" />
        """)

      assert html =~ "loading-lg"
    end

    test "applies variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner_with_text text="Loading" variant="primary" />
        """)

      assert html =~ "text-primary"
    end
  end

  describe "custom classes" do
    test "applies custom class to spinner" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner class="my-spinner" />
        """)

      assert html =~ "my-spinner"
    end

    test "applies custom class to spinner_with_text" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner_with_text text="Loading" class="my-container" />
        """)

      assert html =~ "my-container"
    end
  end
end
