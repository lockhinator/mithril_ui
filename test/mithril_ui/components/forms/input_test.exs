defmodule MithrilUI.Components.InputTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Input

  describe "input/1 rendering" do
    test "renders basic text input" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="username" />
        """)

      assert html =~ ~s(type="text")
      assert html =~ ~s(name="username")
      assert html =~ ~s(class="input input-bordered w-full")
    end

    test "renders with id attribute" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input id="user-email" name="email" />
        """)

      assert html =~ ~s(id="user-email")
    end

    test "renders with value" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="email" value="test@example.com" />
        """)

      assert html =~ ~s(value="test@example.com")
    end

    test "renders with placeholder" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="search" placeholder="Search..." />
        """)

      assert html =~ ~s(placeholder="Search...")
    end
  end

  describe "input types" do
    test "renders email input" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="email" type="email" />
        """)

      assert html =~ ~s(type="email")
    end

    test "renders password input" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="password" type="password" />
        """)

      assert html =~ ~s(type="password")
    end

    test "renders number input" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="quantity" type="number" min="0" max="100" />
        """)

      assert html =~ ~s(type="number")
      assert html =~ ~s(min="0")
      assert html =~ ~s(max="100")
    end

    test "renders tel input" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="phone" type="tel" />
        """)

      assert html =~ ~s(type="tel")
    end

    test "renders url input" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="website" type="url" />
        """)

      assert html =~ ~s(type="url")
    end

    test "renders search input" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="query" type="search" />
        """)

      assert html =~ ~s(type="search")
    end

    test "renders date input" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="birthday" type="date" />
        """)

      assert html =~ ~s(type="date")
    end

    test "renders time input" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="meeting_time" type="time" />
        """)

      assert html =~ ~s(type="time")
    end

    test "renders datetime-local input" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="event_start" type="datetime-local" />
        """)

      assert html =~ ~s(type="datetime-local")
    end

    test "renders hidden input without wrapper" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="csrf_token" type="hidden" value="abc123" />
        """)

      assert html =~ ~s(type="hidden")
      assert html =~ ~s(value="abc123")
      # Hidden inputs should not have form-control wrapper
      refute html =~ "form-control"
      refute html =~ "label"
    end
  end

  describe "label" do
    test "renders label when provided" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="email" label="Email Address" id="email" />
        """)

      assert html =~ "Email Address"
      assert html =~ ~s(<label)
      assert html =~ ~s(for="email")
      assert html =~ "label-text"
    end

    test "does not render label when not provided" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="email" />
        """)

      refute html =~ ~s(<label)
    end

    test "shows required indicator with label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="email" label="Email" required />
        """)

      assert html =~ "text-error"
      assert html =~ "*"
    end
  end

  describe "help_text" do
    test "renders help text when provided and no errors" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="password" help_text="Must be at least 8 characters" />
        """)

      assert html =~ "Must be at least 8 characters"
      assert html =~ "label-text-alt"
    end

    test "does not render help text when there are errors" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="password" help_text="Must be at least 8 characters" errors={["Too short"]} />
        """)

      # Should show error instead of help text
      assert html =~ "Too short"
      refute html =~ "Must be at least 8 characters"
    end
  end

  describe "error display" do
    test "renders error messages" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="email" errors={["is required", "must be valid"]} />
        """)

      assert html =~ "is required"
      assert html =~ "must be valid"
      assert html =~ "text-error"
    end

    test "applies input-error class when errors present" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="email" errors={["is required"]} />
        """)

      assert html =~ "input-error"
    end

    test "does not apply input-error class when no errors" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="email" />
        """)

      refute html =~ "input-error"
    end
  end

  describe "disabled and readonly states" do
    test "renders disabled input" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="locked" disabled />
        """)

      assert html =~ "disabled"
      assert html =~ "input-disabled"
    end

    test "renders readonly input" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="readonly_field" readonly />
        """)

      assert html =~ "readonly"
    end

    test "renders both disabled and readonly" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="field" disabled readonly />
        """)

      assert html =~ "disabled"
      assert html =~ "readonly"
    end
  end

  describe "DaisyUI classes" do
    test "includes base DaisyUI classes" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="test" />
        """)

      assert html =~ "input"
      assert html =~ "input-bordered"
      assert html =~ "form-control"
    end

    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="test" class="input-lg input-primary" />
        """)

      assert html =~ "input-lg"
      assert html =~ "input-primary"
    end
  end

  describe "accessibility" do
    test "sets aria-invalid when errors present" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="email" errors={["invalid"]} />
        """)

      # Phoenix renders boolean attributes without ="true"
      assert html =~ "aria-invalid"
    end

    test "does not set aria-invalid when no errors" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="email" />
        """)

      # When aria-invalid is false, Phoenix omits the attribute entirely
      refute html =~ "aria-invalid"
    end

    test "sets aria-required when required" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="email" required />
        """)

      # Phoenix renders boolean attributes without ="true"
      assert html =~ "aria-required"
      assert html =~ ~s(required)
    end

    test "sets aria-describedby when errors present" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input id="email" name="email" errors={["invalid"]} />
        """)

      assert html =~ ~s(aria-describedby="email-error")
      assert html =~ ~s(id="email-error")
    end

    test "sets aria-describedby for help text" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input id="password" name="password" help_text="Help text" />
        """)

      assert html =~ ~s(aria-describedby="password-help")
      assert html =~ ~s(id="password-help")
    end
  end

  describe "form field integration" do
    test "extracts values from form field" do
      field = %Phoenix.HTML.FormField{
        id: "user_email",
        name: "user[email]",
        value: "test@example.com",
        errors: [],
        field: :email,
        form: %Phoenix.HTML.Form{source: %{}, impl: Phoenix.HTML.FormData.Map}
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <Input.input field={@field} />
        """)

      assert html =~ ~s(id="user_email")
      assert html =~ ~s(name="user[email]")
      assert html =~ ~s(value="test@example.com")
    end

    test "allows overriding field id" do
      field = %Phoenix.HTML.FormField{
        id: "user_email",
        name: "user[email]",
        value: "test@example.com",
        errors: [],
        field: :email,
        form: %Phoenix.HTML.Form{source: %{}, impl: Phoenix.HTML.FormData.Map}
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <Input.input field={@field} id="custom-id" />
        """)

      assert html =~ ~s(id="custom-id")
    end

    test "renders label with form field" do
      field = %Phoenix.HTML.FormField{
        id: "user_email",
        name: "user[email]",
        value: nil,
        errors: [],
        field: :email,
        form: %Phoenix.HTML.Form{source: %{}, impl: Phoenix.HTML.FormData.Map}
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <Input.input field={@field} label="Email Address" />
        """)

      assert html =~ "Email Address"
      assert html =~ ~s(for="user_email")
    end
  end

  describe "global attributes" do
    test "passes through autocomplete attribute" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="email" autocomplete="email" />
        """)

      assert html =~ ~s(autocomplete="email")
    end

    test "passes through autofocus attribute" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="search" autofocus />
        """)

      assert html =~ "autofocus"
    end

    test "passes through minlength and maxlength" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="username" minlength="3" maxlength="20" />
        """)

      assert html =~ ~s(minlength="3")
      assert html =~ ~s(maxlength="20")
    end

    test "passes through pattern attribute" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="code" pattern="[A-Za-z]{3}" />
        """)

      assert html =~ ~s(pattern="[A-Za-z]{3}")
    end

    test "passes through step attribute for number input" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="price" type="number" step="0.01" />
        """)

      assert html =~ ~s(step="0.01")
    end

    test "passes through inputmode attribute" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Input.input name="phone" inputmode="tel" />
        """)

      assert html =~ ~s(inputmode="tel")
    end
  end
end
