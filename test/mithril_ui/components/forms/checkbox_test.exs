defmodule MithrilUI.Components.CheckboxTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component
  import MithrilUI.Components.Checkbox

  describe "checkbox/1" do
    test "renders basic checkbox with label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.checkbox name="terms" label="I agree to the terms" />
        """)

      assert html =~ ~s(type="checkbox")
      assert html =~ ~s(name="terms")
      assert html =~ "I agree to the terms"
      assert html =~ "checkbox checkbox-primary"
    end

    test "renders with custom id" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.checkbox id="my-checkbox" name="terms" label="Terms" />
        """)

      assert html =~ ~s(id="my-checkbox")
    end

    test "renders with custom value" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.checkbox name="accept" label="Accept" value="yes" />
        """)

      assert html =~ ~s(value="yes")
    end

    test "renders checked state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.checkbox name="subscribe" label="Subscribe" checked />
        """)

      assert html =~ "checked"
    end

    test "renders unchecked by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.checkbox name="subscribe" label="Subscribe" />
        """)

      refute html =~ ~r/checked(?!=)/
    end

    test "renders disabled state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.checkbox name="locked" label="Locked" disabled />
        """)

      assert html =~ "disabled"
    end

    test "renders hidden input for form submission" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.checkbox name="active" label="Active" />
        """)

      assert html =~ ~s(type="hidden")
      assert html =~ ~s(value="false")
    end

    test "renders with errors" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.checkbox name="terms" label="Terms" errors={["must be accepted"]} />
        """)

      assert html =~ "must be accepted"
      assert html =~ "text-error"
      assert html =~ "checkbox-error"
    end

    test "renders with form field" do
      field = %Phoenix.HTML.FormField{
        id: "form_subscribe",
        name: "form[subscribe]",
        value: true,
        errors: [],
        field: :subscribe,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.checkbox field={@field} label="Subscribe" />
        """)

      assert html =~ ~s(id="form_subscribe")
      assert html =~ ~s(name="form[subscribe]")
      assert html =~ "checked"
    end

    test "renders unchecked with form field value false" do
      field = %Phoenix.HTML.FormField{
        id: "form_subscribe",
        name: "form[subscribe]",
        value: false,
        errors: [],
        field: :subscribe,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.checkbox field={@field} label="Subscribe" />
        """)

      refute html =~ ~r/checked(?!=)/
    end

    test "renders with form field errors" do
      field = %Phoenix.HTML.FormField{
        id: "form_terms",
        name: "form[terms]",
        value: false,
        errors: [{"must be accepted", []}],
        field: :terms,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.checkbox field={@field} label="I agree" />
        """)

      assert html =~ "must be accepted"
      assert html =~ "checkbox-error"
    end

    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.checkbox name="terms" label="Terms" class="checkbox-lg" />
        """)

      assert html =~ "checkbox-lg"
    end

    test "renders aria-invalid when errors present" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.checkbox name="terms" label="Terms" errors={["required"]} />
        """)

      assert html =~ ~s(aria-invalid)
    end

    test "renders aria-describedby pointing to error element" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.checkbox id="my-cb" name="terms" label="Terms" errors={["required"]} />
        """)

      assert html =~ ~s(aria-describedby="my-cb-error")
      assert html =~ ~s(id="my-cb-error")
    end
  end
end
