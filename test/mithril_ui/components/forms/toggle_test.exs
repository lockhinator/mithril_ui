defmodule MithrilUI.Components.ToggleTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component
  import MithrilUI.Components.Toggle

  describe "toggle/1" do
    test "renders basic toggle" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.toggle name="notifications" />
        """)

      assert html =~ ~s(type="checkbox")
      assert html =~ ~s(name="notifications")
      assert html =~ "toggle toggle-primary"
    end

    test "renders with label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.toggle name="dark_mode" label="Dark mode" />
        """)

      assert html =~ "Dark mode"
      assert html =~ "label-text"
    end

    test "renders without label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.toggle name="enabled" />
        """)

      refute html =~ "label-text"
    end

    test "renders with custom id" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.toggle id="my-toggle" name="setting" />
        """)

      assert html =~ ~s(id="my-toggle")
    end

    test "renders checked state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.toggle name="auto_save" label="Auto-save" checked />
        """)

      assert html =~ "checked"
    end

    test "renders unchecked by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.toggle name="feature" label="Feature" />
        """)

      refute html =~ ~r/checked(?!=)/
    end

    test "renders disabled state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.toggle name="premium" label="Premium Feature" disabled />
        """)

      assert html =~ "disabled"
    end

    test "renders hidden input for form submission" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.toggle name="active" />
        """)

      assert html =~ ~s(type="hidden")
      assert html =~ ~s(value="false")
    end

    test "renders with errors" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.toggle name="consent" label="Consent" errors={["is required"]} />
        """)

      assert html =~ "is required"
      assert html =~ "text-error"
      assert html =~ "toggle-error"
    end

    test "renders with form field" do
      field = %Phoenix.HTML.FormField{
        id: "form_dark_mode",
        name: "form[dark_mode]",
        value: true,
        errors: [],
        field: :dark_mode,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.toggle field={@field} label="Dark mode" />
        """)

      assert html =~ ~s(id="form_dark_mode")
      assert html =~ ~s(name="form[dark_mode]")
      assert html =~ "checked"
    end

    test "renders unchecked with form field value false" do
      field = %Phoenix.HTML.FormField{
        id: "form_dark_mode",
        name: "form[dark_mode]",
        value: false,
        errors: [],
        field: :dark_mode,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.toggle field={@field} label="Dark mode" />
        """)

      refute html =~ ~r/checked(?!=)/
    end

    test "renders with form field errors" do
      field = %Phoenix.HTML.FormField{
        id: "form_consent",
        name: "form[consent]",
        value: false,
        errors: [{"must be enabled", []}],
        field: :consent,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.toggle field={@field} label="Consent" />
        """)

      assert html =~ "must be enabled"
      assert html =~ "toggle-error"
    end

    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.toggle name="setting" label="Setting" class="toggle-lg" />
        """)

      assert html =~ "toggle-lg"
    end

    test "renders aria-invalid when errors present" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.toggle name="consent" label="Consent" errors={["required"]} />
        """)

      assert html =~ ~s(aria-invalid)
    end

    test "renders aria-describedby pointing to error element" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.toggle id="my-toggle" name="consent" label="Consent" errors={["required"]} />
        """)

      assert html =~ ~s(aria-describedby="my-toggle-error")
      assert html =~ ~s(id="my-toggle-error")
    end

    test "always uses 'true' as the value" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.toggle name="enabled" />
        """)

      assert html =~ ~s(value="true")
    end
  end
end
