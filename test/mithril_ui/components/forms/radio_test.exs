defmodule MithrilUI.Components.RadioTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component
  import MithrilUI.Components.Radio

  describe "radio/1" do
    test "renders basic radio with label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.radio name="plan" value="basic" label="Basic Plan" />
        """)

      assert html =~ ~s(type="radio")
      assert html =~ ~s(name="plan")
      assert html =~ ~s(value="basic")
      assert html =~ "Basic Plan"
      assert html =~ "radio radio-primary"
    end

    test "renders with custom id" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.radio id="my-radio" name="plan" value="pro" label="Pro" />
        """)

      assert html =~ ~s(id="my-radio")
    end

    test "renders checked state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.radio name="color" value="red" label="Red" checked />
        """)

      assert html =~ "checked"
    end

    test "renders unchecked by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.radio name="color" value="blue" label="Blue" />
        """)

      refute html =~ ~r/checked(?!=)/
    end

    test "renders disabled state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.radio name="tier" value="premium" label="Premium" disabled />
        """)

      assert html =~ "disabled"
    end

    test "renders multiple radios in a group" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.radio name="size" value="small" label="Small" />
        <.radio name="size" value="medium" label="Medium" checked />
        <.radio name="size" value="large" label="Large" />
        """)

      assert html =~ ~s(value="small")
      assert html =~ ~s(value="medium")
      assert html =~ ~s(value="large")
      assert html =~ "Small"
      assert html =~ "Medium"
      assert html =~ "Large"
    end

    test "renders with form field" do
      field = %Phoenix.HTML.FormField{
        id: "form_plan",
        name: "form[plan]",
        value: "pro",
        errors: [],
        field: :plan,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.radio field={@field} value="pro" label="Pro Plan" />
        """)

      assert html =~ ~s(id="form_plan_pro")
      assert html =~ ~s(name="form[plan]")
      assert html =~ "checked"
    end

    test "renders unchecked when form field value differs" do
      field = %Phoenix.HTML.FormField{
        id: "form_plan",
        name: "form[plan]",
        value: "basic",
        errors: [],
        field: :plan,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.radio field={@field} value="pro" label="Pro Plan" />
        """)

      refute html =~ ~r/checked(?!=)/
    end

    test "renders with form field errors" do
      field = %Phoenix.HTML.FormField{
        id: "form_plan",
        name: "form[plan]",
        value: nil,
        errors: [{"is required", []}],
        field: :plan,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.radio field={@field} value="basic" label="Basic" />
        """)

      assert html =~ "radio-error"
    end

    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.radio name="size" value="xl" label="Extra Large" class="radio-lg" />
        """)

      assert html =~ "radio-lg"
    end

    test "renders aria-invalid when errors present" do
      field = %Phoenix.HTML.FormField{
        id: "form_plan",
        name: "form[plan]",
        value: nil,
        errors: [{"is required", []}],
        field: :plan,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.radio field={@field} value="basic" label="Basic" />
        """)

      assert html =~ ~s(aria-invalid)
    end

    test "generates unique id for each radio in form field group" do
      field = %Phoenix.HTML.FormField{
        id: "form_plan",
        name: "form[plan]",
        value: "basic",
        errors: [],
        field: :plan,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.radio field={@field} value="basic" label="Basic" />
        <.radio field={@field} value="pro" label="Pro" />
        """)

      assert html =~ ~s(id="form_plan_basic")
      assert html =~ ~s(id="form_plan_pro")
    end
  end
end
