defmodule MithrilUI.AI.ComponentSelector do
  @moduledoc """
  AI-friendly interface for component selection and documentation.

  This module provides structured data and functions for AI agents to:
  - List all available components
  - Get component metadata and schemas
  - Suggest appropriate components based on context
  - Generate usage examples

  ## Usage

  List all components:

      MithrilUI.AI.ComponentSelector.list_components()

  Get component schema:

      MithrilUI.AI.ComponentSelector.get_schema(:button)

  Suggest components for a use case:

      MithrilUI.AI.ComponentSelector.suggest_components("form submission")

  """

  alias MithrilUI.AI.ComponentRegistry

  @doc """
  Returns a list of all components with their metadata.

  ## Options

  - `:category` - Filter by category (e.g., `:forms`, `:feedback`)
  - `:format` - Output format (`:full`, `:summary`, `:names_only`)

  ## Examples

      iex> list_components()
      [%{name: :button, category: :actions, ...}, ...]

      iex> list_components(category: :forms)
      [%{name: :input, ...}, %{name: :select, ...}, ...]

      iex> list_components(format: :names_only)
      [:button, :input, :select, ...]
  """
  def list_components(opts \\ []) do
    components =
      case opts[:category] do
        nil -> ComponentRegistry.all_components()
        cat -> ComponentRegistry.by_category(cat)
      end

    case opts[:format] do
      :names_only ->
        Enum.map(components, & &1.name)

      :summary ->
        Enum.map(components, fn c ->
          %{
            name: c.name,
            category: c.category,
            description: c.description
          }
        end)

      _ ->
        components
    end
  end

  @doc """
  Returns the JSON schema for a component.

  The schema includes:
  - Component metadata (name, description, category)
  - Available props with types and defaults
  - Variants and sizes
  - Accessibility information
  - Usage guidance

  ## Examples

      iex> get_schema(:button)
      %{
        "$schema" => "https://mithrilui.dev/schemas/component/v1",
        "component" => "button",
        ...
      }
  """
  def get_schema(component_name) do
    case ComponentRegistry.get_component(component_name) do
      nil ->
        {:error, :not_found}

      component ->
        {:ok, build_schema(component)}
    end
  end

  @doc """
  Returns all component schemas as a map.

  Useful for generating documentation or exporting to JSON.
  """
  def all_schemas do
    ComponentRegistry.all_components()
    |> Enum.map(fn c -> {c.name, build_schema(c)} end)
    |> Map.new()
  end

  @doc """
  Suggests components based on a natural language description or context.

  Returns components sorted by relevance to the given context.

  ## Examples

      iex> suggest_components("submit form")
      [%{name: :button, relevance: :high, reason: "Button for form submission"}, ...]

      iex> suggest_components("display user list")
      [%{name: :table, ...}, %{name: :list_group, ...}]

      iex> suggest_components("loading indicator")
      [%{name: :spinner, ...}, %{name: :skeleton, ...}]
  """
  def suggest_components(context) when is_binary(context) do
    context_lower = String.downcase(context)
    keywords = extract_keywords(context_lower)

    ComponentRegistry.all_components()
    |> Enum.map(fn component ->
      score = calculate_relevance(component, context_lower, keywords)
      reason = generate_reason(component, keywords)
      %{name: component.name, relevance: score_to_relevance(score), reason: reason, score: score}
    end)
    |> Enum.filter(&(&1.score > 0))
    |> Enum.sort_by(& &1.score, :desc)
    |> Enum.take(5)
    |> Enum.map(&Map.delete(&1, :score))
  end

  @doc """
  Returns usage examples for a component.

  ## Examples

      iex> get_usage_examples(:button)
      [
        %{
          name: "Basic button",
          code: "<.button>Click me</.button>"
        },
        ...
      ]
  """
  def get_usage_examples(component_name) do
    case ComponentRegistry.get_component(component_name) do
      nil ->
        {:error, :not_found}

      component ->
        {:ok, generate_examples(component)}
    end
  end

  @doc """
  Returns all component categories with descriptions.
  """
  def list_categories do
    [
      %{
        name: :actions,
        description: "Interactive elements that trigger actions",
        components: ComponentRegistry.by_category(:actions) |> Enum.map(& &1.name)
      },
      %{
        name: :forms,
        description: "Form input elements for collecting user data",
        components: ComponentRegistry.by_category(:forms) |> Enum.map(& &1.name)
      },
      %{
        name: :feedback,
        description: "Elements for displaying feedback and status",
        components: ComponentRegistry.by_category(:feedback) |> Enum.map(& &1.name)
      },
      %{
        name: :data_display,
        description: "Elements for displaying data and content",
        components: ComponentRegistry.by_category(:data_display) |> Enum.map(& &1.name)
      },
      %{
        name: :navigation,
        description: "Navigation and wayfinding elements",
        components: ComponentRegistry.by_category(:navigation) |> Enum.map(& &1.name)
      },
      %{
        name: :overlays,
        description: "Overlay and popup elements",
        components: ComponentRegistry.by_category(:overlays) |> Enum.map(& &1.name)
      },
      %{
        name: :typography,
        description: "Text and typographic elements",
        components: ComponentRegistry.by_category(:typography) |> Enum.map(& &1.name)
      },
      %{
        name: :extended,
        description: "Extended components for specific use cases",
        components: ComponentRegistry.by_category(:extended) |> Enum.map(& &1.name)
      },
      %{
        name: :utility,
        description: "Utility components for enhanced functionality",
        components: ComponentRegistry.by_category(:utility) |> Enum.map(& &1.name)
      }
    ]
  end

  @doc """
  Returns related components for a given component.

  Useful for suggesting alternatives or complementary components.
  """
  def get_related(component_name) do
    case ComponentRegistry.get_component(component_name) do
      nil ->
        {:error, :not_found}

      component ->
        related =
          (component[:related] || [])
          |> Enum.map(fn name ->
            case ComponentRegistry.get_component(name) do
              nil -> nil
              c -> %{name: c.name, description: c.description}
            end
          end)
          |> Enum.reject(&is_nil/1)

        alternatives =
          (component[:alternatives] || %{})
          |> Enum.map(fn {name, reason} ->
            %{name: name, reason: reason}
          end)

        {:ok, %{related: related, alternatives: alternatives}}
    end
  end

  @doc """
  Exports all component metadata to JSON format.

  ## Options

  - `:pretty` - Format JSON with indentation (default: true)
  """
  def export_json(opts \\ []) do
    pretty = Keyword.get(opts, :pretty, true)

    data = %{
      "$schema" => "https://mithrilui.dev/schemas/library/v1",
      "version" => "1.0.0",
      "categories" => list_categories(),
      "components" => all_schemas()
    }

    if pretty do
      Jason.encode!(data, pretty: true)
    else
      Jason.encode!(data)
    end
  end

  # Private functions

  defp build_schema(component) do
    %{
      "$schema" => "https://mithrilui.dev/schemas/component/v1",
      "component" => to_string(component.name),
      "module" => inspect(component.module),
      "category" => to_string(component.category),
      "description" => component.description,
      "semantic" => %{
        "use_when" => component.use_when,
        "do_not_use_when" => component.do_not_use_when
      },
      "variants" => Map.get(component, :variants, []),
      "sizes" => Map.get(component, :sizes, []),
      "accessibility" => Map.get(component, :a11y, %{}),
      "related" => Map.get(component, :related, []) |> Enum.map(&to_string/1),
      "alternatives" =>
        Map.get(component, :alternatives, %{})
        |> Enum.map(fn {k, v} -> %{"component" => to_string(k), "reason" => v} end)
    }
  end

  defp extract_keywords(text) do
    # Common UI-related keywords for matching
    keyword_map = %{
      "form" => [:input, :select, :checkbox, :radio, :toggle, :textarea, :button, :file_input],
      "submit" => [:button],
      "input" => [:input, :textarea],
      "text" => [:input, :textarea, :text, :heading],
      "select" => [:select, :dropdown, :radio],
      "check" => [:checkbox, :toggle],
      "toggle" => [:toggle, :checkbox],
      "click" => [:button, :link],
      "action" => [:button, :dropdown, :speed_dial],
      "navigate" => [:link, :navbar, :sidebar, :breadcrumb, :tabs],
      "link" => [:link, :breadcrumb],
      "menu" => [:navbar, :sidebar, :dropdown, :bottom_navigation],
      "list" => [:list_group, :table, :timeline],
      "table" => [:table],
      "data" => [:table, :card, :list_group],
      "card" => [:card],
      "modal" => [:modal, :drawer],
      "dialog" => [:modal, :drawer],
      "popup" => [:modal, :popover, :tooltip],
      "alert" => [:alert, :toast, :banner],
      "notification" => [:toast, :alert, :badge, :indicator],
      "toast" => [:toast],
      "message" => [:alert, :toast, :chat_bubble],
      "loading" => [:spinner, :skeleton, :progress],
      "progress" => [:progress, :stepper],
      "spinner" => [:spinner],
      "error" => [:alert, :toast],
      "success" => [:alert, :toast],
      "warning" => [:alert, :banner],
      "user" => [:avatar, :card],
      "avatar" => [:avatar],
      "image" => [:avatar, :card, :gallery, :carousel],
      "gallery" => [:gallery, :carousel],
      "slide" => [:carousel],
      "tab" => [:tabs],
      "accordion" => [:accordion],
      "collapse" => [:accordion, :drawer],
      "expand" => [:accordion, :dropdown],
      "badge" => [:badge, :indicator],
      "status" => [:badge, :indicator, :progress],
      "step" => [:stepper, :progress],
      "wizard" => [:stepper],
      "chat" => [:chat_bubble],
      "comment" => [:chat_bubble, :card],
      "rating" => [:rating],
      "star" => [:rating],
      "copy" => [:clipboard],
      "clipboard" => [:clipboard],
      "theme" => [:theme_switcher],
      "dark" => [:theme_switcher],
      "light" => [:theme_switcher],
      "float" => [:speed_dial],
      "fab" => [:speed_dial],
      "tooltip" => [:tooltip],
      "hint" => [:tooltip],
      "hover" => [:tooltip, :popover],
      "breadcrumb" => [:breadcrumb],
      "path" => [:breadcrumb],
      "pagination" => [:pagination],
      "page" => [:pagination],
      "footer" => [:footer],
      "header" => [:navbar],
      "nav" => [:navbar, :sidebar, :bottom_navigation],
      "sidebar" => [:sidebar, :drawer],
      "drawer" => [:drawer],
      "code" => [:code, :clipboard],
      "keyboard" => [:kbd],
      "key" => [:kbd],
      "quote" => [:blockquote],
      "heading" => [:heading],
      "title" => [:heading],
      "paragraph" => [:text],
      "file" => [:file_input],
      "upload" => [:file_input],
      "range" => [:range],
      "slider" => [:range],
      "timeline" => [:timeline],
      "history" => [:timeline],
      "banner" => [:banner]
    }

    words = String.split(text, ~r/\W+/)

    Enum.flat_map(words, fn word ->
      Map.get(keyword_map, word, [])
    end)
    |> Enum.uniq()
  end

  defp calculate_relevance(component, context, keywords) do
    base_score = 0

    # Direct name match
    name_str = to_string(component.name)
    name_score = if String.contains?(context, name_str), do: 100, else: 0

    # Keyword match
    keyword_score =
      if component.name in keywords do
        50
      else
        0
      end

    # Description match
    desc_lower = String.downcase(component.description)

    desc_score =
      context
      |> String.split(~r/\W+/)
      |> Enum.count(&String.contains?(desc_lower, &1))
      |> Kernel.*(10)

    # use_when match
    use_when_score =
      component.use_when
      |> Enum.map(&String.downcase/1)
      |> Enum.count(&(String.contains?(&1, context) or String.contains?(context, &1)))
      |> Kernel.*(20)

    base_score + name_score + keyword_score + desc_score + use_when_score
  end

  defp score_to_relevance(score) do
    cond do
      score >= 100 -> :high
      score >= 50 -> :medium
      score > 0 -> :low
      true -> :none
    end
  end

  defp generate_reason(component, keywords) do
    cond do
      component.name in keywords ->
        "#{component.description}"

      true ->
        Enum.at(component.use_when, 0) || component.description
    end
  end

  defp generate_examples(component) do
    name = component.name

    base_examples = [
      %{
        name: "Basic #{name}",
        code: "<.#{name}>Content</.#{name}>",
        description: "Simple usage with default options"
      }
    ]

    variant_examples =
      case Map.get(component, :variants, []) do
        [] ->
          []

        variants ->
          variants
          |> Enum.take(3)
          |> Enum.map(fn variant ->
            %{
              name: "#{String.capitalize(to_string(variant))} variant",
              code: ~s(<.#{name} variant="#{variant}">Content</.#{name}>),
              description: "Using the #{variant} variant"
            }
          end)
      end

    size_examples =
      case Map.get(component, :sizes, []) do
        [] ->
          []

        sizes ->
          [
            %{
              name: "Size variants",
              code:
                sizes
                |> Enum.map(
                  &~s(<.#{name} size="#{&1}">#{String.upcase(to_string(&1))}</.#{name}>)
                )
                |> Enum.join("\n"),
              description: "Available size options"
            }
          ]
      end

    base_examples ++ variant_examples ++ size_examples
  end
end
