defmodule Mix.Tasks.MithrilUi.Mcp do
  @moduledoc """
  Starts the Mithril UI MCP server for AI assistant integration.

      $ mix mithril_ui.mcp

  The MCP server provides AI assistants (like Claude Code) with access to:

  - Component discovery and documentation
  - Natural language component suggestions
  - Usage examples and code snippets
  - Theme information
  - Accessibility guidelines

  ## Claude Code Configuration

  Add to your project's `.mcp.json` or Claude Code settings:

      {
        "mcpServers": {
          "mithril-ui": {
            "command": "mix",
            "args": ["mithril_ui.mcp"],
            "cwd": "/path/to/your/project"
          }
        }
      }

  ## Available Tools

  Once connected, AI assistants can use these tools:

  - `list_components` - List all components or filter by category
  - `get_component` - Get detailed schema for a component
  - `suggest_components` - Natural language search
  - `get_examples` - Get usage examples
  - `list_categories` - List component categories
  - `list_themes` - List available themes
  - `get_related` - Get related components and alternatives
  """

  use Mix.Task

  alias MithrilUI.MCP.Server

  @shortdoc "Starts the Mithril UI MCP server"

  @impl true
  def run(_args) do
    # Ensure the application is started so we can access component metadata
    Mix.Task.run("app.start")

    # Start the MCP server
    Server.start()
  end
end
