defmodule MithrilUI.Components.SelectTest do
  use ExUnit.Case, async: true
  use Phoenix.Component

  import Phoenix.LiveViewTest
  import MithrilUI.Components.Select

  describe "select/1" do
    test "renders basic select with tuple options" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select
          name="country"
          options={[{"United States", "us"}, {"Canada", "ca"}, {"Mexico", "mx"}]}
        />
        """)

      assert html =~ ~s(<select)
      assert html =~ ~s(name="country")
      assert html =~ "select select-bordered"
      assert html =~ ~s(value="us")
      assert html =~ "United States"
      assert html =~ ~s(value="ca")
      assert html =~ "Canada"
      assert html =~ ~s(value="mx")
      assert html =~ "Mexico"
    end

    test "renders with simple value options" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select name="color" options={["Red", "Green", "Blue"]} />
        """)

      assert html =~ ~s(value="Red")
      assert html =~ ">Red<" || html =~ ">\n        Red\n"
      assert html =~ ~s(value="Green")
      assert html =~ ~s(value="Blue")
    end

    test "renders with prompt placeholder" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select name="category" options={[{"Books", "books"}]} prompt="Select a category" />
        """)

      assert html =~ ~s(<option value="" disabled)
      assert html =~ ~s(selected)
      assert html =~ "Select a category"
    end

    test "prompt is not selected when value is set" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select
          name="category"
          options={[{"Books", "books"}, {"Electronics", "electronics"}]}
          prompt="Select a category"
          value="books"
        />
        """)

      # Prompt should not have selected when a value is set
      assert html =~ ~s(<option value="" disabled>)
      refute html =~ ~r/<option value="" disabled selected>/
    end

    test "renders with label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select name="country" label="Country" options={[{"US", "us"}]} />
        """)

      assert html =~ ~s(<label)
      assert html =~ "Country"
      assert html =~ "label-text"
    end

    test "renders required indicator in label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select name="country" label="Country" options={[{"US", "us"}]} required />
        """)

      assert html =~ "Country"
      assert html =~ "text-error"
      assert html =~ "*"
      assert html =~ ~s(aria-hidden="true")
    end

    test "renders with selected value" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select name="country" options={[{"US", "us"}, {"Canada", "ca"}]} value="ca" />
        """)

      # Canada should be selected
      assert html =~ ~s(<option value="ca" selected>)
      assert html =~ "Canada"
      # US should not be selected - no selected attribute
      assert html =~ ~s(<option value="us">)
    end

    test "renders disabled state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select name="country" options={[{"US", "us"}]} disabled />
        """)

      assert html =~ "disabled"
    end

    test "renders required attribute" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select name="country" options={[{"US", "us"}]} required />
        """)

      assert html =~ ~s(required)
      # Boolean attributes may render without ="true"
      assert html =~ "aria-required"
    end

    test "renders multiple selection" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select name="tags[]" options={[{"Elixir", "elixir"}, {"Phoenix", "phoenix"}]} multiple />
        """)

      assert html =~ "multiple"
    end

    test "renders with multiple selected values" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select
          name="tags[]"
          options={[{"Elixir", "elixir"}, {"Phoenix", "phoenix"}, {"LiveView", "liveview"}]}
          value={["elixir", "liveview"]}
          multiple
        />
        """)

      assert html =~ ~s(<option value="elixir" selected>)
      assert html =~ "Elixir"
      assert html =~ ~s(<option value="phoenix">)
      assert html =~ "Phoenix"
      assert html =~ ~s(<option value="liveview" selected>)
      assert html =~ "LiveView"
    end

    test "renders with errors" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select name="country" options={[{"US", "us"}]} errors={["is required"]} />
        """)

      assert html =~ "is required"
      assert html =~ "text-error"
      assert html =~ "select-error"
      # Boolean attributes may render without ="true"
      assert html =~ "aria-invalid"
    end

    test "renders with help text" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select
          id="country-select"
          name="country"
          options={[{"US", "us"}]}
          help_text="Select your country of residence"
        />
        """)

      assert html =~ "Select your country of residence"
      assert html =~ "label-text-alt"
      assert html =~ ~s(aria-describedby="country-select-description")
    end

    test "errors take precedence over help text display" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select
          id="country-select"
          name="country"
          options={[{"US", "us"}]}
          help_text="Select your country"
          errors={["is required"]}
        />
        """)

      # Error should be displayed
      assert html =~ "is required"
      # Help text should not be displayed when there are errors
      refute html =~ "Select your country"
    end

    test "renders with form field" do
      field = %Phoenix.HTML.FormField{
        id: "user_role",
        name: "user[role]",
        value: "admin",
        errors: [],
        field: :role,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.select field={@field} options={[{"Admin", "admin"}, {"User", "user"}]} />
        """)

      assert html =~ ~s(id="user_role")
      assert html =~ ~s(name="user[role]")
      assert html =~ ~s(<option value="admin" selected>)
      assert html =~ "Admin"
    end

    test "renders with form field errors" do
      field = %Phoenix.HTML.FormField{
        id: "user_role",
        name: "user[role]",
        value: nil,
        errors: [{"is required", []}],
        field: :role,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.select field={@field} options={[{"Admin", "admin"}, {"User", "user"}]} />
        """)

      assert html =~ "is required"
      assert html =~ "select-error"
    end

    test "renders with form field and interpolated errors" do
      field = %Phoenix.HTML.FormField{
        id: "user_priority",
        name: "user[priority]",
        value: nil,
        errors: [{"must be at least %{count}", [count: 1]}],
        field: :priority,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.select field={@field} options={[{"Low", 0}, {"High", 1}]} />
        """)

      assert html =~ "must be at least 1"
    end

    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select name="country" options={[{"US", "us"}]} class="my-custom-class" />
        """)

      assert html =~ "my-custom-class"
    end

    test "renders with id attribute" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select id="country-select" name="country" options={[{"US", "us"}]} />
        """)

      assert html =~ ~s(id="country-select")
    end

    test "renders integer value options correctly" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select name="rating" options={[{"One", 1}, {"Two", 2}, {"Three", 3}]} value={2} />
        """)

      assert html =~ ~s(value="1")
      assert html =~ "One"
      assert html =~ ~s(<option value="2" selected>)
      assert html =~ "Two"
      assert html =~ ~s(value="3")
      assert html =~ "Three"
    end

    test "renders atom value options correctly" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select name="status" options={[{"Active", :active}, {"Inactive", :inactive}]} value={:active} />
        """)

      assert html =~ ~s(value="active")
      assert html =~ ~s(<option value="active" selected>)
      assert html =~ "Active"
    end

    test "passes through global attributes" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select name="country" options={[{"US", "us"}]} data-testid="country-select" />
        """)

      assert html =~ ~s(data-testid="country-select")
    end

    test "multiple selection with integer values" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.select
          name="numbers[]"
          options={[{"One", 1}, {"Two", 2}, {"Three", 3}]}
          value={[1, 3]}
          multiple
        />
        """)

      assert html =~ ~s(<option value="1" selected>)
      assert html =~ "One"
      assert html =~ ~s(<option value="2">)
      assert html =~ "Two"
      assert html =~ ~s(<option value="3" selected>)
      assert html =~ "Three"
    end
  end
end
