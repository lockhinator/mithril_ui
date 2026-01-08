defmodule MithrilUI.Components.RangeTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component
  import MithrilUI.Components.Range

  describe "range/1" do
    test "renders basic range input" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.range name="volume" />
        """)

      assert html =~ ~s(type="range")
      assert html =~ ~s(name="volume")
      assert html =~ "class=" <> ~s(") <> "range"
    end

    test "renders with min, max, and step" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.range name="rating" min={1} max={5} step={1} />
        """)

      assert html =~ ~s(min="1")
      assert html =~ ~s(max="5")
      assert html =~ ~s(step="1")
    end

    test "renders with value" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.range name="volume" value={50} />
        """)

      assert html =~ ~s(value="50")
    end

    test "renders with label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.range name="volume" label="Volume" />
        """)

      assert html =~ "Volume"
      assert html =~ "label-text"
    end

    test "shows current value when show_value is true" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.range name="volume" value={75} show_value />
        """)

      assert html =~ "75"
      assert html =~ "label-text-alt"
    end

    test "renders disabled state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.range name="volume" disabled />
        """)

      assert html =~ "disabled"
    end

    test "renders with errors" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.range name="volume" errors={["must be at least 10"]} />
        """)

      assert html =~ "must be at least 10"
      assert html =~ "text-error"
      assert html =~ "range-error"
    end

    test "renders with form field" do
      field = %Phoenix.HTML.FormField{
        id: "form_volume",
        name: "form[volume]",
        value: 42,
        errors: [],
        field: :volume,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.range field={@field} />
        """)

      assert html =~ ~s(id="form_volume")
      assert html =~ ~s(name="form[volume]")
      assert html =~ ~s(value="42")
    end

    test "renders with form field errors" do
      field = %Phoenix.HTML.FormField{
        id: "form_volume",
        name: "form[volume]",
        value: nil,
        errors: [{"is required", []}],
        field: :volume,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.range field={@field} />
        """)

      assert html =~ "is required"
      assert html =~ "range-error"
    end

    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.range name="volume" class="my-custom-class" />
        """)

      assert html =~ "my-custom-class"
    end

    test "uses default min value when no value provided" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.range name="volume" min={10} />
        """)

      assert html =~ ~s(value="10")
    end
  end
end
