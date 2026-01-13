defmodule MithrilUI.MCP.ServerTest do
  use ExUnit.Case, async: true

  alias MithrilUI.MCP.Server
  alias MithrilUI.MCP.Tools

  # Note: These tests verify the request handling logic without starting the full server loop.
  # Integration testing of the stdio communication is done manually or via the mix task.

  # We test the internal request handling by calling the module functions directly
  # Since handle_request is private, we test through the public interface indirectly

  describe "MCP protocol compliance" do
    test "server module is defined" do
      assert Code.ensure_loaded?(Server)
    end

    test "start function is exported" do
      # Ensure module is loaded before checking function exports
      Code.ensure_loaded!(Server)
      assert function_exported?(Server, :start, 0)
    end
  end

  describe "tools module integration" do
    test "tools list is valid for MCP protocol" do
      tools = Tools.list_tools()

      # Verify each tool conforms to MCP tool schema
      for tool <- tools do
        assert is_binary(tool.name)
        assert is_binary(tool.description)
        assert is_map(tool.inputSchema)
        assert tool.inputSchema.type == "object"
      end
    end

    test "all tools can be called without errors" do
      # Test each tool with valid minimal arguments
      assert {:ok, _} = Tools.call_tool("list_components", %{})
      assert {:ok, _} = Tools.call_tool("list_categories", %{})
      assert {:ok, _} = Tools.call_tool("list_themes", %{})
      assert {:ok, _} = Tools.call_tool("get_component", %{"name" => "button"})
      assert {:ok, _} = Tools.call_tool("get_examples", %{"name" => "button"})
      assert {:ok, _} = Tools.call_tool("get_related", %{"name" => "button"})
      assert {:ok, _} = Tools.call_tool("suggest_components", %{"query" => "button"})
    end
  end
end
