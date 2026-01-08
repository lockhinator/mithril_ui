defmodule MithrilUI.MCP.Server do
  @moduledoc """
  MCP (Model Context Protocol) server for Mithril UI.

  Provides AI assistants with access to component metadata, documentation,
  and intelligent component suggestions.

  ## Protocol

  Uses JSON-RPC 2.0 over stdio, compatible with Claude Code and other MCP clients.

  ## Available Tools

  - `list_components` - List all components or filter by category
  - `get_component` - Get detailed schema for a specific component
  - `suggest_components` - Natural language search for components
  - `get_examples` - Get usage examples for a component
  - `list_categories` - List all component categories
  - `list_themes` - List available DaisyUI themes
  """

  alias MithrilUI.MCP.Tools

  @server_info %{
    name: "mithril-ui",
    version: Mix.Project.config()[:version] || "0.1.0"
  }

  @capabilities %{
    tools: %{}
  }

  @doc """
  Starts the MCP server, reading from stdin and writing to stdout.
  """
  def start do
    IO.puts(:stderr, "[MithrilUI MCP] Server starting...")
    loop()
  end

  defp loop do
    case IO.read(:stdio, :line) do
      :eof ->
        IO.puts(:stderr, "[MithrilUI MCP] EOF received, shutting down")
        :ok

      {:error, reason} ->
        IO.puts(:stderr, "[MithrilUI MCP] Error reading input: #{inspect(reason)}")
        :error

      line ->
        line
        |> String.trim()
        |> handle_line()

        loop()
    end
  end

  defp handle_line(""), do: :ok

  defp handle_line(line) do
    case Jason.decode(line) do
      {:ok, request} ->
        response = handle_request(request)
        send_response(response)

      {:error, error} ->
        send_error(nil, -32_700, "Parse error: #{inspect(error)}")
    end
  end

  defp handle_request(%{"jsonrpc" => "2.0", "id" => id, "method" => method} = request) do
    params = Map.get(request, "params", %{})

    case handle_method(method, params) do
      {:ok, result} ->
        %{jsonrpc: "2.0", id: id, result: result}

      {:error, code, message} ->
        %{jsonrpc: "2.0", id: id, error: %{code: code, message: message}}
    end
  end

  defp handle_request(%{"jsonrpc" => "2.0", "method" => method} = request) do
    # Notification (no id) - handle but don't respond
    params = Map.get(request, "params", %{})
    handle_method(method, params)
    nil
  end

  defp handle_request(_invalid) do
    %{jsonrpc: "2.0", id: nil, error: %{code: -32_600, message: "Invalid Request"}}
  end

  # MCP Protocol Methods

  defp handle_method("initialize", _params) do
    {:ok,
     %{
       protocolVersion: "2024-11-05",
       serverInfo: @server_info,
       capabilities: @capabilities
     }}
  end

  defp handle_method("notifications/initialized", _params) do
    IO.puts(:stderr, "[MithrilUI MCP] Client initialized")
    {:ok, nil}
  end

  defp handle_method("tools/list", _params) do
    {:ok, %{tools: Tools.list_tools()}}
  end

  defp handle_method("tools/call", %{"name" => name, "arguments" => args}) do
    case Tools.call_tool(name, args) do
      {:ok, result} ->
        {:ok, %{content: [%{type: "text", text: result}]}}

      {:error, message} ->
        {:ok, %{content: [%{type: "text", text: "Error: #{message}"}], isError: true}}
    end
  end

  defp handle_method("tools/call", %{"name" => name}) do
    handle_method("tools/call", %{"name" => name, "arguments" => %{}})
  end

  defp handle_method("ping", _params) do
    {:ok, %{}}
  end

  defp handle_method(method, _params) do
    {:error, -32_601, "Method not found: #{method}"}
  end

  defp send_response(nil), do: :ok

  defp send_response(response) do
    json = Jason.encode!(response)
    IO.puts(json)
  end

  defp send_error(id, code, message) do
    response = %{
      jsonrpc: "2.0",
      id: id,
      error: %{code: code, message: message}
    }

    send_response(response)
  end
end
