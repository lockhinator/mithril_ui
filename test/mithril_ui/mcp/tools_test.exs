defmodule MithrilUI.MCP.ToolsTest do
  use ExUnit.Case, async: true

  alias MithrilUI.MCP.Tools

  describe "list_tools/0" do
    test "returns list of available tools" do
      tools = Tools.list_tools()

      assert is_list(tools)
      assert length(tools) == 7

      tool_names = Enum.map(tools, & &1.name)
      assert "list_components" in tool_names
      assert "get_component" in tool_names
      assert "suggest_components" in tool_names
      assert "get_examples" in tool_names
      assert "list_categories" in tool_names
      assert "list_themes" in tool_names
      assert "get_related" in tool_names
    end

    test "each tool has required fields" do
      for tool <- Tools.list_tools() do
        assert Map.has_key?(tool, :name)
        assert Map.has_key?(tool, :description)
        assert Map.has_key?(tool, :inputSchema)
        assert is_binary(tool.name)
        assert is_binary(tool.description)
        assert is_map(tool.inputSchema)
      end
    end

    test "input schemas have correct structure" do
      for tool <- Tools.list_tools() do
        schema = tool.inputSchema
        assert schema.type == "object"
        assert Map.has_key?(schema, :properties)
      end
    end
  end

  describe "call_tool/2 - list_components" do
    test "returns all components without filter" do
      {:ok, result} = Tools.call_tool("list_components", %{})

      assert is_binary(result)
      assert result =~ "## Components"
      assert result =~ "button"
      assert result =~ "card"
      assert result =~ "modal"
    end

    test "filters by category" do
      {:ok, result} = Tools.call_tool("list_components", %{"category" => "actions"})

      assert result =~ "button"
      assert result =~ "actions"
    end

    test "returns error for invalid category" do
      {:error, message} = Tools.call_tool("list_components", %{"category" => "invalid_category"})

      assert message =~ "Invalid category"
    end
  end

  describe "call_tool/2 - get_component" do
    test "returns component schema" do
      {:ok, result} = Tools.call_tool("get_component", %{"name" => "button"})

      assert is_binary(result)
      assert result =~ "## button"
      assert result =~ "Category:"
      assert result =~ "When to Use"
      assert result =~ "Variants"
      assert result =~ "Accessibility"
    end

    test "returns error for unknown component" do
      {:error, message} = Tools.call_tool("get_component", %{"name" => "nonexistent"})

      assert message =~ "not found"
    end

    test "returns error when name is missing" do
      {:error, message} = Tools.call_tool("get_component", %{})

      assert message =~ "Missing required parameter: name"
    end
  end

  describe "call_tool/2 - suggest_components" do
    test "returns suggestions for query" do
      {:ok, result} = Tools.call_tool("suggest_components", %{"query" => "button click"})

      assert is_binary(result)
      assert result =~ "## Suggested Components"
      assert result =~ "button"
    end

    test "returns suggestions for loading-related query" do
      {:ok, result} = Tools.call_tool("suggest_components", %{"query" => "loading spinner"})

      assert result =~ "spinner" or result =~ "progress" or result =~ "skeleton"
    end

    test "returns message when no matches found" do
      {:ok, result} =
        Tools.call_tool("suggest_components", %{"query" => "xyznonexistentfeature123"})

      assert result =~ "No components found"
    end

    test "returns error when query is missing" do
      {:error, message} = Tools.call_tool("suggest_components", %{})

      assert message =~ "Missing required parameter: query"
    end
  end

  describe "call_tool/2 - get_examples" do
    test "returns examples for component" do
      {:ok, result} = Tools.call_tool("get_examples", %{"name" => "button"})

      assert is_binary(result)
      assert result =~ "## Examples for button"
      assert result =~ "```heex"
      assert result =~ "<.button"
    end

    test "returns error for unknown component" do
      {:error, message} = Tools.call_tool("get_examples", %{"name" => "nonexistent"})

      assert message =~ "not found"
    end

    test "returns error when name is missing" do
      {:error, message} = Tools.call_tool("get_examples", %{})

      assert message =~ "Missing required parameter: name"
    end
  end

  describe "call_tool/2 - list_categories" do
    test "returns all categories" do
      {:ok, result} = Tools.call_tool("list_categories", %{})

      assert is_binary(result)
      assert result =~ "## Component Categories"
      assert result =~ "actions"
      assert result =~ "forms"
      assert result =~ "feedback"
      assert result =~ "navigation"
    end

    test "includes component lists for each category" do
      {:ok, result} = Tools.call_tool("list_categories", %{})

      assert result =~ "**Components:**"
    end
  end

  describe "call_tool/2 - list_themes" do
    test "returns all themes" do
      {:ok, result} = Tools.call_tool("list_themes", %{})

      assert is_binary(result)
      assert result =~ "## Available Themes"
      assert result =~ "light"
      assert result =~ "dark"
    end

    test "includes color scheme info" do
      {:ok, result} = Tools.call_tool("list_themes", %{})

      assert result =~ "(light)" or result =~ "(dark)"
    end
  end

  describe "call_tool/2 - get_related" do
    test "returns related components" do
      {:ok, result} = Tools.call_tool("get_related", %{"name" => "button"})

      assert is_binary(result)
      assert result =~ "## Related Components"
      assert result =~ "## Alternatives"
    end

    test "returns error for unknown component" do
      {:error, message} = Tools.call_tool("get_related", %{"name" => "nonexistent"})

      assert message =~ "not found"
    end

    test "returns error when name is missing" do
      {:error, message} = Tools.call_tool("get_related", %{})

      assert message =~ "Missing required parameter: name"
    end
  end

  describe "call_tool/2 - unknown tool" do
    test "returns error for unknown tool" do
      {:error, message} = Tools.call_tool("unknown_tool", %{})

      assert message =~ "Unknown tool"
    end
  end
end
