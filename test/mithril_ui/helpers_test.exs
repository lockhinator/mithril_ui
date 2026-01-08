defmodule MithrilUI.HelpersTest do
  use ExUnit.Case, async: true

  alias MithrilUI.Helpers

  describe "translate_error/1" do
    test "returns message unchanged when no interpolations" do
      assert Helpers.translate_error({"is required", []}) == "is required"
    end

    test "interpolates count placeholder" do
      result = Helpers.translate_error({"must be at least %{count} characters", [count: 8]})
      assert result == "must be at least 8 characters"
    end

    test "interpolates multiple placeholders" do
      result =
        Helpers.translate_error(
          {"%{field} must be between %{min} and %{max}", [field: "age", min: 18, max: 100]}
        )

      assert result == "age must be between 18 and 100"
    end
  end

  describe "class_names/1" do
    test "joins string classes" do
      assert Helpers.class_names(["btn", "btn-primary"]) == "btn btn-primary"
    end

    test "filters out nil values" do
      assert Helpers.class_names(["btn", nil, "btn-primary"]) == "btn btn-primary"
    end

    test "filters out empty strings" do
      assert Helpers.class_names(["btn", "", "btn-primary"]) == "btn btn-primary"
    end

    test "handles conditional tuples - true condition" do
      assert Helpers.class_names(["btn", {"btn-primary", true}]) == "btn btn-primary"
    end

    test "handles conditional tuples - false condition" do
      assert Helpers.class_names(["btn", {"btn-primary", false}]) == "btn"
    end

    test "handles nested lists" do
      result = Helpers.class_names(["btn", ["btn-primary", "btn-lg"]])
      assert result == "btn btn-primary btn-lg"
    end

    test "returns empty string for empty list" do
      assert Helpers.class_names([]) == ""
    end

    test "handles mixed inputs" do
      result =
        Helpers.class_names([
          "btn",
          nil,
          {"btn-primary", true},
          {"btn-disabled", false},
          "",
          ["extra", "classes"]
        ])

      assert result == "btn btn-primary extra classes"
    end
  end

  describe "unique_id/1" do
    test "generates string with prefix" do
      id = Helpers.unique_id("modal")
      assert String.starts_with?(id, "modal-")
    end

    test "uses default prefix when not provided" do
      id = Helpers.unique_id()
      assert String.starts_with?(id, "mithril-")
    end

    test "generates unique IDs" do
      id1 = Helpers.unique_id("test")
      id2 = Helpers.unique_id("test")
      assert id1 != id2
    end

    test "generated ID contains hex characters" do
      id = Helpers.unique_id("test")
      suffix = String.replace_prefix(id, "test-", "")
      assert Regex.match?(~r/^[0-9a-f]+$/, suffix)
    end
  end

  describe "field_errors/1" do
    test "returns empty list for nil" do
      assert Helpers.field_errors(nil) == []
    end

    test "returns empty list for field with no errors" do
      field = %Phoenix.HTML.FormField{errors: [], id: "test", name: "test", value: nil, field: :test, form: nil}
      assert Helpers.field_errors(field) == []
    end

    test "translates errors from form field" do
      field = %Phoenix.HTML.FormField{
        errors: [{"is required", []}],
        id: "test",
        name: "test",
        value: nil,
        field: :test,
        form: nil
      }

      assert Helpers.field_errors(field) == ["is required"]
    end

    test "translates multiple errors" do
      field = %Phoenix.HTML.FormField{
        errors: [{"is required", []}, {"must be at least %{count} characters", [count: 8]}],
        id: "test",
        name: "test",
        value: nil,
        field: :test,
        form: nil
      }

      errors = Helpers.field_errors(field)
      assert length(errors) == 2
      assert "is required" in errors
      assert "must be at least 8 characters" in errors
    end
  end

  describe "has_errors?/1" do
    test "returns false for nil" do
      refute Helpers.has_errors?(nil)
    end

    test "returns false for field with no errors" do
      field = %Phoenix.HTML.FormField{errors: [], id: "test", name: "test", value: nil, field: :test, form: nil}
      refute Helpers.has_errors?(field)
    end

    test "returns true for field with errors" do
      field = %Phoenix.HTML.FormField{
        errors: [{"is required", []}],
        id: "test",
        name: "test",
        value: nil,
        field: :test,
        form: nil
      }

      assert Helpers.has_errors?(field)
    end
  end
end
