defmodule MithrilUI.Components.Accordion do
  @moduledoc """
  Accordion component for collapsible content sections.

  ## Examples

  Basic accordion:

      <.accordion>
        <:item title="Section 1">Content for section 1</:item>
        <:item title="Section 2">Content for section 2</:item>
      </.accordion>

  With icons:

      <.accordion icon="arrow">
        <:item title="FAQ 1">Answer 1</:item>
        <:item title="FAQ 2">Answer 2</:item>
      </.accordion>

  ## DaisyUI Classes

  - `collapse` - Base collapse styling
  - `collapse-arrow` - Arrow icon indicator
  - `collapse-plus` - Plus/minus icon indicator
  - `collapse-open` - Force open state
  - `collapse-close` - Force closed state
  """

  use Phoenix.Component

  @doc """
  Renders an accordion with multiple collapsible sections.

  ## Attributes

    * `:name` - Radio group name for single-open behavior. Auto-generated if not provided.
    * `:icon` - Icon style: arrow, plus, none. Defaults to "arrow".
    * `:join` - Join items together visually. Defaults to true.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:item` - Accordion items with `:title` attribute.
      - `:title` - Section header text (required).
      - `:open` - Whether section is initially open.
      - `:class` - Additional classes for the item.

  ## Examples

      <.accordion icon="plus">
        <:item title="What is this?">
          This is an accordion component.
        </:item>
        <:item title="How does it work?" open>
          Click the header to expand or collapse.
        </:item>
      </.accordion>
  """
  @spec accordion(map()) :: Phoenix.LiveView.Rendered.t()

  attr :name, :string, default: nil
  attr :icon, :string, default: "arrow", values: ~w(arrow plus none)
  attr :join, :boolean, default: true
  attr :class, :string, default: nil

  slot :item, required: true do
    attr :title, :string, required: true
    attr :open, :boolean
    attr :class, :string
  end

  def accordion(assigns) do
    name = assigns.name || "accordion-#{System.unique_integer([:positive])}"
    assigns = assign(assigns, :group_name, name)

    ~H"""
    <div class={[@join && "join join-vertical w-full", @class]}>
      <div
        :for={item <- @item}
        class={collapse_classes(@icon, @join, item[:class])}
      >
        <input type="radio" name={@group_name} checked={item[:open]} />
        <div class="collapse-title text-lg font-medium">
          <%= item.title %>
        </div>
        <div class="collapse-content">
          {render_slot(item)}
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Renders a single collapsible section (standalone collapse).

  ## Attributes

    * `:title` - Section title (required).
    * `:open` - Whether initially open. Defaults to false.
    * `:icon` - Icon style: arrow, plus, none. Defaults to "arrow".
    * `:class` - Additional CSS classes.

  ## Examples

      <.collapse title="Click to expand">
        Hidden content revealed on click.
      </.collapse>
  """
  @spec collapse(map()) :: Phoenix.LiveView.Rendered.t()

  attr :title, :string, required: true
  attr :open, :boolean, default: false
  attr :icon, :string, default: "arrow", values: ~w(arrow plus none)
  attr :class, :string, default: nil

  slot :inner_block, required: true

  def collapse(assigns) do
    ~H"""
    <div class={collapse_classes(@icon, false, @class)}>
      <input type="checkbox" checked={@open} />
      <div class="collapse-title text-lg font-medium">
        <%= @title %>
      </div>
      <div class="collapse-content">
        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end

  defp collapse_classes(icon, join, extra_class) do
    [
      "collapse bg-base-200",
      icon == "arrow" && "collapse-arrow",
      icon == "plus" && "collapse-plus",
      join && "join-item border-base-300 border",
      extra_class
    ]
  end
end
