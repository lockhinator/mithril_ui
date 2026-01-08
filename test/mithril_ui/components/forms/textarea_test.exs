defmodule MithrilUI.Components.TextareaTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Textarea

  describe "textarea/1" do
    test "renders basic textarea with name" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea name="description" />
        """)

      assert html =~ ~s(<textarea)
      assert html =~ ~s(name="description")
      assert html =~ "textarea textarea-bordered w-full"
    end

    test "renders textarea with value" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea name="description" value="Hello world" />
        """)

      assert html =~ "Hello world"
    end

    test "renders textarea with label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea name="description" label="Description" />
        """)

      assert html =~ ~s(<span class="label-text">)
      assert html =~ "Description"
    end

    test "renders textarea with required indicator" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea name="description" label="Description" required />
        """)

      assert html =~ "Description *"
      assert html =~ ~s(required)
      # Phoenix renders boolean attributes without ="true"
      assert html =~ ~s(aria-required)
    end

    test "renders textarea with placeholder" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea name="description" placeholder="Enter text here..." />
        """)

      assert html =~ ~s(placeholder="Enter text here...")
    end

    test "renders textarea with custom rows" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea name="description" rows={5} />
        """)

      assert html =~ ~s(rows="5")
    end

    test "renders textarea with default rows of 3" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea name="description" />
        """)

      assert html =~ ~s(rows="3")
    end

    test "renders textarea with help_text" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea name="description" id="desc" help_text="Maximum 500 characters" />
        """)

      assert html =~ "Maximum 500 characters"
      assert html =~ ~s(id="desc-help")
      assert html =~ ~s(aria-describedby="desc-help")
    end

    test "renders textarea in disabled state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea name="description" disabled />
        """)

      assert html =~ ~s(disabled)
    end

    test "renders textarea in readonly state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea name="description" readonly />
        """)

      assert html =~ ~s(readonly)
    end

    test "renders textarea with errors" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea name="description" id="desc" errors={["is required", "is too short"]} />
        """)

      assert html =~ "is required"
      assert html =~ "is too short"
      assert html =~ ~s(textarea-error)
      # Phoenix renders boolean attributes without ="true"
      assert html =~ ~s(aria-invalid)
      assert html =~ ~s(role="alert")
      assert html =~ ~s(aria-describedby="desc-errors")
    end

    test "does not show help_text when errors are present" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea
          name="description"
          id="desc"
          help_text="This should be hidden"
          errors={["is required"]}
        />
        """)

      refute html =~ "This should be hidden"
      assert html =~ "is required"
    end

    test "renders textarea with custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea name="description" class="min-h-32" />
        """)

      assert html =~ "min-h-32"
      assert html =~ "textarea textarea-bordered w-full"
    end

    test "renders textarea with global attributes" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea name="description" maxlength="500" autocomplete="off" />
        """)

      assert html =~ ~s(maxlength="500")
      assert html =~ ~s(autocomplete="off")
    end

    test "renders textarea with id" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea name="description" id="my-textarea" label="Description" />
        """)

      assert html =~ ~s(id="my-textarea")
      assert html =~ ~s(for="my-textarea")
    end
  end

  describe "textarea/1 with form field" do
    test "extracts values from form field" do
      field = %Phoenix.HTML.FormField{
        id: "post_body",
        name: "post[body]",
        value: "Some content",
        errors: [],
        field: :body,
        form: %Phoenix.HTML.Form{
          source: %{},
          impl: Phoenix.HTML.FormData.Map,
          id: "post",
          name: "post",
          data: %{},
          action: nil,
          hidden: [],
          params: %{},
          errors: [],
          options: []
        }
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea field={@field} />
        """)

      assert html =~ ~s(id="post_body")
      assert html =~ ~s(name="post[body]")
      assert html =~ "Some content"
    end

    test "extracts and translates errors from form field when used" do
      form = %Phoenix.HTML.Form{
        source: %{},
        impl: Phoenix.HTML.FormData.Map,
        id: "post",
        name: "post",
        data: %{},
        action: :validate,
        hidden: [],
        params: %{"body" => ""},
        errors: [],
        options: []
      }

      field = %Phoenix.HTML.FormField{
        id: "post_body",
        name: "post[body]",
        value: "",
        errors: [{"can't be blank", []}],
        field: :body,
        form: form
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea field={@field} />
        """)

      assert html =~ "can&#39;t be blank"
      assert html =~ ~s(textarea-error)
    end

    test "allows overriding id from form field" do
      field = %Phoenix.HTML.FormField{
        id: "post_body",
        name: "post[body]",
        value: nil,
        errors: [],
        field: :body,
        form: %Phoenix.HTML.Form{
          source: %{},
          impl: Phoenix.HTML.FormData.Map,
          id: "post",
          name: "post",
          data: %{},
          action: nil,
          hidden: [],
          params: %{},
          errors: [],
          options: []
        }
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea field={@field} id="custom-id" />
        """)

      assert html =~ ~s(id="custom-id")
    end

    test "renders with label when using form field" do
      field = %Phoenix.HTML.FormField{
        id: "post_body",
        name: "post[body]",
        value: nil,
        errors: [],
        field: :body,
        form: %Phoenix.HTML.Form{
          source: %{},
          impl: Phoenix.HTML.FormData.Map,
          id: "post",
          name: "post",
          data: %{},
          action: nil,
          hidden: [],
          params: %{},
          errors: [],
          options: []
        }
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea field={@field} label="Post Body" rows={10} />
        """)

      assert html =~ "Post Body"
      assert html =~ ~s(rows="10")
    end
  end

  describe "aria attributes" do
    test "does not set aria-invalid when no errors" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea name="description" />
        """)

      # Phoenix omits boolean attributes when false
      refute html =~ ~s(aria-invalid)
    end

    test "sets aria-describedby to help text when no errors" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea name="description" id="desc" help_text="Some help" />
        """)

      assert html =~ ~s(aria-describedby="desc-help")
    end

    test "sets aria-describedby to errors when present" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea name="description" id="desc" help_text="Some help" errors={["Error"]} />
        """)

      assert html =~ ~s(aria-describedby="desc-errors")
    end

    test "does not set aria-describedby when no help text or errors" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Textarea.textarea name="description" id="desc" />
        """)

      refute html =~ ~s(aria-describedby)
    end
  end
end
