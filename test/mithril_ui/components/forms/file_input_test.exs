defmodule MithrilUI.Components.FileInputTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component
  import MithrilUI.Components.FileInput

  describe "file_input/1" do
    test "renders basic file input" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.file_input name="avatar" />
        """)

      assert html =~ ~s(type="file")
      assert html =~ ~s(name="avatar")
      assert html =~ "file-input"
      assert html =~ "file-input-bordered"
    end

    test "renders with label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.file_input name="avatar" label="Profile Picture" />
        """)

      assert html =~ "Profile Picture"
      assert html =~ "label-text"
    end

    test "renders with required marker" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.file_input name="avatar" label="Avatar" required />
        """)

      assert html =~ "required"
      assert html =~ "text-error"
      assert html =~ "*"
    end

    test "renders with accept attribute" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.file_input name="image" accept=".jpg,.png,.gif" />
        """)

      assert html =~ ~s(accept=".jpg,.png,.gif")
    end

    test "renders with multiple attribute" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.file_input name="photos" multiple />
        """)

      assert html =~ "multiple"
    end

    test "renders disabled state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.file_input name="avatar" disabled />
        """)

      assert html =~ "disabled"
    end

    test "renders help text" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.file_input name="avatar" help_text="Max 5MB, JPG or PNG" />
        """)

      assert html =~ "Max 5MB, JPG or PNG"
    end

    test "renders with errors" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.file_input name="avatar" errors={["file is too large"]} />
        """)

      assert html =~ "file is too large"
      assert html =~ "text-error"
      assert html =~ "file-input-error"
    end

    test "hides help text when errors present" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.file_input name="avatar" help_text="Max 5MB" errors={["file is too large"]} />
        """)

      refute html =~ "Max 5MB"
      assert html =~ "file is too large"
    end

    test "renders with form field" do
      field = %Phoenix.HTML.FormField{
        id: "form_avatar",
        name: "form[avatar]",
        value: nil,
        errors: [],
        field: :avatar,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.file_input field={@field} />
        """)

      assert html =~ ~s(id="form_avatar")
      assert html =~ ~s(name="form[avatar]")
    end

    test "renders with form field errors" do
      field = %Phoenix.HTML.FormField{
        id: "form_avatar",
        name: "form[avatar]",
        value: nil,
        errors: [{"is required", []}],
        field: :avatar,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.file_input field={@field} />
        """)

      assert html =~ "is required"
      assert html =~ "file-input-error"
    end

    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.file_input name="avatar" class="my-custom-class" />
        """)

      assert html =~ "my-custom-class"
    end

    test "renders with id" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.file_input name="avatar" id="my-file-input" />
        """)

      assert html =~ ~s(id="my-file-input")
    end
  end
end
