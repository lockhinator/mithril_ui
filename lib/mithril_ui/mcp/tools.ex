defmodule MithrilUI.MCP.Tools do
  @moduledoc """
  MCP tool implementations for Mithril UI.

  Wraps the ComponentRegistry and ComponentSelector modules to provide
  AI-friendly access to component metadata.
  """

  alias MithrilUI.AI.ComponentSelector
  alias MithrilUI.Theme

  @doc """
  Returns the list of available MCP tools.
  """
  def list_tools do
    [
      %{
        name: "list_components",
        description:
          "List all Mithril UI components. Optionally filter by category (actions, forms, feedback, data_display, navigation, overlays, typography, extended, utility).",
        inputSchema: %{
          type: "object",
          properties: %{
            category: %{
              type: "string",
              description: "Filter by category name",
              enum:
                ~w(actions forms feedback data_display navigation overlays typography extended utility)
            }
          }
        }
      },
      %{
        name: "get_component",
        description:
          "Get detailed schema and documentation for a specific component including attributes, slots, variants, and accessibility info.",
        inputSchema: %{
          type: "object",
          properties: %{
            name: %{
              type: "string",
              description: "Component name (e.g., 'button', 'card', 'modal')"
            }
          },
          required: ["name"]
        }
      },
      %{
        name: "suggest_components",
        description:
          "Get component suggestions based on a natural language description of what you need.",
        inputSchema: %{
          type: "object",
          properties: %{
            query: %{
              type: "string",
              description:
                "Natural language description (e.g., 'form input for email', 'loading indicator')"
            }
          },
          required: ["query"]
        }
      },
      %{
        name: "get_examples",
        description: "Get usage examples for a specific component.",
        inputSchema: %{
          type: "object",
          properties: %{
            name: %{
              type: "string",
              description: "Component name (e.g., 'button', 'card')"
            }
          },
          required: ["name"]
        }
      },
      %{
        name: "list_categories",
        description: "List all component categories with descriptions and component counts.",
        inputSchema: %{
          type: "object",
          properties: %{}
        }
      },
      %{
        name: "list_themes",
        description: "List all available DaisyUI themes with their color schemes (light/dark).",
        inputSchema: %{
          type: "object",
          properties: %{}
        }
      },
      %{
        name: "get_related",
        description: "Get related components and alternatives for a specific component.",
        inputSchema: %{
          type: "object",
          properties: %{
            name: %{
              type: "string",
              description: "Component name"
            }
          },
          required: ["name"]
        }
      }
    ]
  end

  @valid_categories ~w(actions forms feedback data_display navigation overlays typography extended utility)

  @doc """
  Calls a tool by name with the given arguments.
  """
  def call_tool("list_components", args) do
    category = Map.get(args, "category")

    if category && category not in @valid_categories do
      {:error, "Invalid category"}
    else
      components =
        if category do
          ComponentSelector.list_components(category: String.to_atom(category))
        else
          ComponentSelector.list_components()
        end

      result =
        Enum.map_join(components, "\n", fn c ->
          "- **#{c.name}** (#{c.category}): #{c.description}"
        end)

      {:ok, "## Components\n\n#{result}"}
    end
  end

  def call_tool("get_component", %{"name" => name}) do
    case ComponentSelector.get_schema(String.to_atom(name)) do
      {:ok, schema} ->
        {:ok, format_schema(schema)}

      {:error, :not_found} ->
        {:error, "Component '#{name}' not found"}
    end
  rescue
    ArgumentError -> {:error, "Invalid component name"}
  end

  def call_tool("get_component", _), do: {:error, "Missing required parameter: name"}

  def call_tool("suggest_components", %{"query" => query}) do
    suggestions = ComponentSelector.suggest_components(query)

    if Enum.empty?(suggestions) do
      {:ok, "No components found matching '#{query}'"}
    else
      result =
        Enum.map_join(suggestions, "\n\n", fn s ->
          "### #{s.name} (#{s.relevance} relevance)\n#{s.reason}"
        end)

      {:ok, "## Suggested Components\n\n#{result}"}
    end
  end

  def call_tool("suggest_components", _), do: {:error, "Missing required parameter: query"}

  def call_tool("get_examples", %{"name" => name}) do
    case ComponentSelector.get_usage_examples(String.to_atom(name)) do
      {:ok, examples} ->
        result =
          Enum.map_join(examples, "\n", fn ex ->
            """
            ### #{ex.name}

            ```heex
            #{ex.code}
            ```
            """
          end)

        {:ok, "## Examples for #{name}\n\n#{result}"}

      {:error, :not_found} ->
        {:error, "Component '#{name}' not found"}
    end
  rescue
    ArgumentError -> {:error, "Invalid component name"}
  end

  def call_tool("get_examples", _), do: {:error, "Missing required parameter: name"}

  def call_tool("list_categories", _args) do
    categories = ComponentSelector.list_categories()

    result =
      Enum.map_join(categories, "\n\n", fn cat ->
        components = Enum.map_join(cat.components, ", ", &to_string/1)
        "### #{cat.name}\n#{cat.description}\n\n**Components:** #{components}"
      end)

    {:ok, "## Component Categories\n\n#{result}"}
  end

  def call_tool("list_themes", _args) do
    themes = Theme.theme_options()

    result =
      Enum.map_join(themes, "\n", fn t ->
        "- **#{t.name}** (#{t.color_scheme})"
      end)

    {:ok, "## Available Themes\n\n#{result}"}
  end

  def call_tool("get_related", %{"name" => name}) do
    case ComponentSelector.get_related(String.to_atom(name)) do
      {:ok, result} ->
        related =
          Enum.map_join(result.related, "\n", fn r ->
            "- **#{r.name}**: #{r.description}"
          end)

        alternatives =
          Enum.map_join(result.alternatives, "\n", fn a ->
            "- **#{a.name}**: #{a.reason}"
          end)

        output = """
        ## Related Components

        #{if related != "", do: related, else: "None"}

        ## Alternatives

        #{if alternatives != "", do: alternatives, else: "None"}
        """

        {:ok, output}

      {:error, :not_found} ->
        {:error, "Component '#{name}' not found"}
    end
  rescue
    ArgumentError -> {:error, "Invalid component name"}
  end

  def call_tool("get_related", _), do: {:error, "Missing required parameter: name"}

  def call_tool(name, _args), do: {:error, "Unknown tool: #{name}"}

  # Private helpers

  defp format_schema(schema) do
    """
    ## #{schema["component"]}

    **Category:** #{schema["category"]}

    #{schema["description"]}

    ### When to Use
    #{format_list(schema["semantic"]["use_when"])}

    ### When NOT to Use
    #{format_list(schema["semantic"]["do_not_use_when"])}

    ### Variants
    #{format_inline_list(schema["variants"])}

    ### Sizes
    #{format_inline_list(schema["sizes"])}

    ### Accessibility
    - **Role:** #{schema["accessibility"]["role"] || "N/A"}
    - **Keyboard:** #{schema["accessibility"]["keyboard_interaction"] || "N/A"}
    - **ARIA:** #{format_inline_list(schema["accessibility"]["aria_attributes"])}

    ### Attributes
    #{format_attributes(schema["attributes"])}

    ### Slots
    #{format_slots(schema["slots"])}
    """
  end

  defp format_list(nil), do: "N/A"
  defp format_list([]), do: "N/A"
  defp format_list(items), do: Enum.map_join(items, "\n", &"- #{&1}")

  defp format_inline_list(nil), do: "N/A"
  defp format_inline_list([]), do: "N/A"
  defp format_inline_list(items), do: Enum.join(items, ", ")

  defp format_attributes(nil), do: "N/A"

  defp format_attributes(attrs) when is_map(attrs) do
    Enum.map_join(attrs, "\n", fn {name, info} ->
      type = info["type"] || "any"
      required = if info["required"], do: " (required)", else: ""
      default = if info["default"], do: " [default: #{info["default"]}]", else: ""
      "- **#{name}** `#{type}`#{required}#{default}"
    end)
  end

  defp format_slots(nil), do: "N/A"
  defp format_slots([]), do: "N/A"

  defp format_slots(slots) when is_list(slots) do
    Enum.map_join(slots, "\n", fn slot ->
      required = if slot["required"], do: " (required)", else: ""
      "- **#{slot["name"]}**#{required}: #{slot["doc"] || "No description"}"
    end)
  end

  defp format_slots(slots) when is_map(slots) do
    Enum.map_join(slots, "\n", fn {name, info} ->
      required = if info["required"], do: " (required)", else: ""
      "- **#{name}**#{required}: #{info["doc"] || "No description"}"
    end)
  end
end
