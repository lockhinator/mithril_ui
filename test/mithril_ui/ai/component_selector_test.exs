defmodule MithrilUI.AI.ComponentSelectorTest do
  use ExUnit.Case, async: true

  alias MithrilUI.AI.ComponentSelector

  describe "list_components/1" do
    test "returns all components by default" do
      components = ComponentSelector.list_components()

      assert is_list(components)
      assert length(components) > 40
    end

    test "filters by category" do
      components = ComponentSelector.list_components(category: :forms)

      assert length(components) >= 7
      assert Enum.all?(components, &(&1.category == :forms))
    end

    test "returns names only with format option" do
      names = ComponentSelector.list_components(format: :names_only)

      assert is_list(names)
      assert :button in names
      assert :input in names
    end

    test "returns summary with format option" do
      summaries = ComponentSelector.list_components(format: :summary)

      assert is_list(summaries)
      first = hd(summaries)
      assert Map.has_key?(first, :name)
      assert Map.has_key?(first, :category)
      assert Map.has_key?(first, :description)
      refute Map.has_key?(first, :use_when)
    end
  end

  describe "get_schema/1" do
    test "returns schema for valid component" do
      {:ok, schema} = ComponentSelector.get_schema(:button)

      assert schema["component"] == "button"
      assert schema["category"] == "actions"
      assert is_binary(schema["description"])
      assert is_map(schema["semantic"])
      assert is_list(schema["semantic"]["use_when"])
    end

    test "returns error for invalid component" do
      assert {:error, :not_found} = ComponentSelector.get_schema(:unknown)
    end

    test "schema includes accessibility info" do
      {:ok, schema} = ComponentSelector.get_schema(:button)

      assert is_map(schema["accessibility"])
    end

    test "schema includes variants and sizes when available" do
      {:ok, schema} = ComponentSelector.get_schema(:button)

      assert is_list(schema["variants"])
      assert "primary" in schema["variants"]
      assert is_list(schema["sizes"])
    end
  end

  describe "all_schemas/0" do
    test "returns map of all component schemas" do
      schemas = ComponentSelector.all_schemas()

      assert is_map(schemas)
      assert Map.has_key?(schemas, :button)
      assert Map.has_key?(schemas, :input)
      assert Map.has_key?(schemas, :modal)
    end
  end

  describe "suggest_components/1" do
    test "suggests button for form submission" do
      suggestions = ComponentSelector.suggest_components("submit form")

      assert length(suggestions) > 0
      names = Enum.map(suggestions, & &1.name)
      assert :button in names
    end

    test "suggests input for text input" do
      suggestions = ComponentSelector.suggest_components("text input field")

      names = Enum.map(suggestions, & &1.name)
      assert :input in names or :textarea in names
    end

    test "suggests modal for dialog" do
      suggestions = ComponentSelector.suggest_components("dialog popup")

      names = Enum.map(suggestions, & &1.name)
      assert :modal in names or :popover in names
    end

    test "suggests spinner for loading" do
      suggestions = ComponentSelector.suggest_components("loading indicator")

      names = Enum.map(suggestions, & &1.name)
      assert :spinner in names or :skeleton in names or :progress in names
    end

    test "returns relevance levels" do
      suggestions = ComponentSelector.suggest_components("button click")

      assert Enum.all?(suggestions, fn s ->
               s.relevance in [:high, :medium, :low]
             end)
    end

    test "returns reasons for suggestions" do
      suggestions = ComponentSelector.suggest_components("button")

      assert Enum.all?(suggestions, fn s ->
               is_binary(s.reason) and String.length(s.reason) > 0
             end)
    end

    test "limits results to 5" do
      suggestions = ComponentSelector.suggest_components("form input select button")

      assert length(suggestions) <= 5
    end
  end

  describe "get_usage_examples/1" do
    test "returns examples for valid component" do
      {:ok, examples} = ComponentSelector.get_usage_examples(:button)

      assert is_list(examples)
      assert length(examples) > 0

      first = hd(examples)
      assert is_binary(first.name)
      assert is_binary(first.code)
    end

    test "returns error for invalid component" do
      assert {:error, :not_found} = ComponentSelector.get_usage_examples(:unknown)
    end

    test "examples include variant examples for components with variants" do
      {:ok, examples} = ComponentSelector.get_usage_examples(:button)

      codes = Enum.map(examples, & &1.code)
      code_str = Enum.join(codes, " ")

      assert String.contains?(code_str, "variant")
    end
  end

  describe "list_categories/0" do
    test "returns all categories with descriptions" do
      categories = ComponentSelector.list_categories()

      assert length(categories) == 9

      category_names = Enum.map(categories, & &1.name)
      assert :actions in category_names
      assert :forms in category_names
      assert :feedback in category_names
    end

    test "each category has description and components" do
      for category <- ComponentSelector.list_categories() do
        assert is_atom(category.name)
        assert is_binary(category.description)
        assert is_list(category.components)
        assert length(category.components) > 0
      end
    end
  end

  describe "get_related/1" do
    test "returns related and alternatives for valid component" do
      {:ok, result} = ComponentSelector.get_related(:button)

      assert is_list(result.related)
      assert is_list(result.alternatives)
    end

    test "related components have name and description" do
      {:ok, result} = ComponentSelector.get_related(:button)

      for related <- result.related do
        assert is_atom(related.name)
        assert is_binary(related.description)
      end
    end

    test "alternatives have name and reason" do
      {:ok, result} = ComponentSelector.get_related(:button)

      for alt <- result.alternatives do
        assert is_atom(alt.name)
        assert is_binary(alt.reason)
      end
    end

    test "returns error for invalid component" do
      assert {:error, :not_found} = ComponentSelector.get_related(:unknown)
    end
  end

  describe "export_json/1" do
    test "exports valid JSON" do
      json = ComponentSelector.export_json()

      assert is_binary(json)
      assert {:ok, _} = Jason.decode(json)
    end

    test "exported JSON has correct structure" do
      json = ComponentSelector.export_json()
      {:ok, data} = Jason.decode(json)

      assert Map.has_key?(data, "$schema")
      assert Map.has_key?(data, "version")
      assert Map.has_key?(data, "categories")
      assert Map.has_key?(data, "components")
    end

    test "can export without pretty printing" do
      json = ComponentSelector.export_json(pretty: false)

      assert is_binary(json)
      refute String.contains?(json, "\n  ")
    end
  end
end
