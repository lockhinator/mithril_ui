defmodule MithrilUI.AI.ComponentRegistryTest do
  use ExUnit.Case, async: true

  alias MithrilUI.AI.ComponentRegistry

  describe "all_components/0" do
    test "returns list of all components" do
      components = ComponentRegistry.all_components()

      assert is_list(components)
      assert length(components) > 40
    end

    test "each component has required fields" do
      for component <- ComponentRegistry.all_components() do
        assert Map.has_key?(component, :name)
        assert Map.has_key?(component, :module)
        assert Map.has_key?(component, :category)
        assert Map.has_key?(component, :description)
        assert Map.has_key?(component, :use_when)
        assert Map.has_key?(component, :do_not_use_when)
      end
    end

    test "all component names are atoms" do
      for component <- ComponentRegistry.all_components() do
        assert is_atom(component.name)
      end
    end
  end

  describe "get_component/1" do
    test "returns component by atom name" do
      component = ComponentRegistry.get_component(:button)

      assert component.name == :button
      assert component.category == :actions
      assert is_binary(component.description)
    end

    test "returns component by string name" do
      component = ComponentRegistry.get_component("button")

      assert component.name == :button
    end

    test "returns nil for unknown component" do
      assert ComponentRegistry.get_component(:unknown_component) == nil
    end

    test "returns nil for unknown string component" do
      assert ComponentRegistry.get_component("unknown_component") == nil
    end
  end

  describe "by_category/1" do
    test "returns components in actions category" do
      components = ComponentRegistry.by_category(:actions)

      assert length(components) >= 3
      assert Enum.all?(components, &(&1.category == :actions))
      assert Enum.any?(components, &(&1.name == :button))
    end

    test "returns components in forms category" do
      components = ComponentRegistry.by_category(:forms)

      assert length(components) >= 7
      assert Enum.all?(components, &(&1.category == :forms))
      assert Enum.any?(components, &(&1.name == :input))
    end

    test "returns components in feedback category" do
      components = ComponentRegistry.by_category(:feedback)

      assert length(components) >= 5
      assert Enum.any?(components, &(&1.name == :alert))
      assert Enum.any?(components, &(&1.name == :modal))
    end

    test "returns empty list for unknown category" do
      assert ComponentRegistry.by_category(:unknown) == []
    end
  end

  describe "categories/0" do
    test "returns list of all categories" do
      categories = ComponentRegistry.categories()

      assert :actions in categories
      assert :forms in categories
      assert :feedback in categories
      assert :data_display in categories
      assert :navigation in categories
      assert :overlays in categories
      assert :typography in categories
      assert :extended in categories
      assert :utility in categories
    end
  end

  describe "component_names/0" do
    test "returns list of all component names" do
      names = ComponentRegistry.component_names()

      assert :button in names
      assert :input in names
      assert :modal in names
      assert :card in names
      assert :tabs in names
    end
  end

  describe "component metadata quality" do
    test "use_when is a non-empty list of strings" do
      for component <- ComponentRegistry.all_components() do
        assert is_list(component.use_when)
        assert length(component.use_when) > 0
        assert Enum.all?(component.use_when, &is_binary/1)
      end
    end

    test "do_not_use_when is a non-empty list of strings" do
      for component <- ComponentRegistry.all_components() do
        assert is_list(component.do_not_use_when)
        assert length(component.do_not_use_when) > 0
        assert Enum.all?(component.do_not_use_when, &is_binary/1)
      end
    end

    test "related is a list of atoms" do
      for component <- ComponentRegistry.all_components() do
        related = Map.get(component, :related, [])
        assert is_list(related)
        assert Enum.all?(related, &is_atom/1)
      end
    end

    test "alternatives is a map" do
      for component <- ComponentRegistry.all_components() do
        alternatives = Map.get(component, :alternatives, %{})
        assert is_map(alternatives)
      end
    end
  end
end
