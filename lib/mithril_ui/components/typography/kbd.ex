defmodule MithrilUI.Components.Kbd do
  @moduledoc """
  Keyboard component for displaying keyboard keys and shortcuts.

  Used in documentation and help content to show keyboard shortcuts
  and key combinations.

  ## Examples

  Single key:

      <.kbd>Esc</.kbd>

  Key combination:

      <.kbd_combo keys={["Ctrl", "S"]} />

  With description:

      <.kbd_shortcut keys={["Cmd", "K"]} description="Open command palette" />
  """

  use Phoenix.Component

  @doc """
  Renders a single keyboard key.

  ## Attributes

    * `:size` - Key size. Options: `:xs`, `:sm`, `:md`, `:lg`.
    * `:variant` - Visual style. Options: `:default`, `:outline`.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Required. Key text.

  ## Examples

      <.kbd>Enter</.kbd>
      <.kbd size={:lg}>Spacebar</.kbd>
      <.kbd variant={:outline}>Tab</.kbd>
  """
  @spec kbd(map()) :: Phoenix.LiveView.Rendered.t()

  attr :size, :atom,
    default: :md,
    values: [:xs, :sm, :md, :lg],
    doc: "Key size"

  attr :variant, :atom,
    default: :default,
    values: [:default, :outline],
    doc: "Visual style"

  attr :class, :any, default: nil, doc: "Additional CSS classes"
  attr :rest, :global

  slot :inner_block, required: true, doc: "Key text"

  def kbd(assigns) do
    ~H"""
    <kbd
      class={[
        "kbd",
        size_class(@size),
        variant_class(@variant),
        @class
      ]}
      {@rest}
    >
      {render_slot(@inner_block)}
    </kbd>
    """
  end

  @doc """
  Renders a keyboard shortcut combination.

  ## Attributes

    * `:keys` - Required. List of keys in the combination.
    * `:separator` - Separator between keys. Defaults to "+".
    * `:size` - Key size. Options: `:xs`, `:sm`, `:md`, `:lg`.
    * `:class` - Additional CSS classes.

  ## Examples

      <.kbd_combo keys={["Ctrl", "C"]} />
      <.kbd_combo keys={["Cmd", "Shift", "P"]} />
      <.kbd_combo keys={["Alt", "Tab"]} separator=" + " />
  """
  @spec kbd_combo(map()) :: Phoenix.LiveView.Rendered.t()

  attr :keys, :list, required: true, doc: "List of keys"
  attr :separator, :string, default: "+", doc: "Separator between keys"

  attr :size, :atom,
    default: :md,
    values: [:xs, :sm, :md, :lg],
    doc: "Key size"

  attr :class, :any, default: nil, doc: "Additional CSS classes"
  attr :rest, :global

  def kbd_combo(assigns) do
    ~H"""
    <span class={["inline-flex items-center gap-1", @class]} {@rest}>
      <%= for {key, index} <- Enum.with_index(@keys) do %>
        <kbd class={["kbd", size_class(@size)]}>{key}</kbd>
        <span :if={index < length(@keys) - 1} class="text-base-content/50 text-sm">
          {@separator}
        </span>
      <% end %>
    </span>
    """
  end

  @doc """
  Renders a keyboard shortcut with description.

  ## Attributes

    * `:keys` - Required. List of keys in the combination.
    * `:description` - Required. Description of what the shortcut does.
    * `:size` - Key size.
    * `:class` - Additional CSS classes.

  ## Examples

      <.kbd_shortcut keys={["Ctrl", "S"]} description="Save file" />
      <.kbd_shortcut keys={["Cmd", "Z"]} description="Undo" />
  """
  @spec kbd_shortcut(map()) :: Phoenix.LiveView.Rendered.t()

  attr :keys, :list, required: true, doc: "List of keys"
  attr :description, :string, required: true, doc: "Shortcut description"

  attr :size, :atom,
    default: :sm,
    values: [:xs, :sm, :md, :lg],
    doc: "Key size"

  attr :class, :any, default: nil, doc: "Additional CSS classes"
  attr :rest, :global

  def kbd_shortcut(assigns) do
    ~H"""
    <div class={["flex items-center justify-between gap-4", @class]} {@rest}>
      <span class="text-base-content/70">{@description}</span>
      <.kbd_combo keys={@keys} size={@size} />
    </div>
    """
  end

  @doc """
  Renders a table of keyboard shortcuts.

  ## Attributes

    * `:shortcuts` - Required. List of maps with `:keys` and `:description`.
    * `:title` - Optional title for the shortcuts table.
    * `:class` - Additional CSS classes.

  ## Examples

      <.kbd_table
        title="Editor Shortcuts"
        shortcuts={[
          %{keys: ["Ctrl", "S"], description: "Save"},
          %{keys: ["Ctrl", "Z"], description: "Undo"},
          %{keys: ["Ctrl", "Y"], description: "Redo"}
        ]}
      />
  """
  @spec kbd_table(map()) :: Phoenix.LiveView.Rendered.t()

  attr :shortcuts, :list, required: true, doc: "List of shortcut maps"
  attr :title, :string, default: nil, doc: "Table title"
  attr :class, :any, default: nil, doc: "Additional CSS classes"
  attr :rest, :global

  def kbd_table(assigns) do
    ~H"""
    <div class={["bg-base-200 rounded-box p-4", @class]} {@rest}>
      <h4 :if={@title} class="font-semibold text-base-content mb-4">{@title}</h4>
      <div class="space-y-3">
        <%= for shortcut <- @shortcuts do %>
          <.kbd_shortcut keys={shortcut.keys} description={shortcut.description} />
        <% end %>
      </div>
    </div>
    """
  end

  @doc """
  Renders a special arrow key.

  ## Attributes

    * `:direction` - Arrow direction. Options: `:up`, `:down`, `:left`, `:right`.
    * `:size` - Key size.
    * `:class` - Additional CSS classes.

  ## Examples

      <.kbd_arrow direction={:up} />
      <.kbd_arrow direction={:right} size={:lg} />
  """
  @spec kbd_arrow(map()) :: Phoenix.LiveView.Rendered.t()

  attr :direction, :atom,
    required: true,
    values: [:up, :down, :left, :right],
    doc: "Arrow direction"

  attr :size, :atom,
    default: :md,
    values: [:xs, :sm, :md, :lg],
    doc: "Key size"

  attr :class, :any, default: nil, doc: "Additional CSS classes"
  attr :rest, :global

  def kbd_arrow(assigns) do
    ~H"""
    <kbd class={["kbd", size_class(@size), @class]} {@rest}>
      <span class="sr-only">{@direction} arrow</span>
      <svg class={arrow_icon_size(@size)} fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path
          stroke-linecap="round"
          stroke-linejoin="round"
          stroke-width="2"
          d={arrow_path(@direction)}
        />
      </svg>
    </kbd>
    """
  end

  # Size classes
  defp size_class(:xs), do: "kbd-xs"
  defp size_class(:sm), do: "kbd-sm"
  defp size_class(:md), do: nil
  defp size_class(:lg), do: "kbd-lg"

  # Variant classes
  defp variant_class(:default), do: nil
  defp variant_class(:outline), do: "bg-transparent"

  # Arrow icon sizes
  defp arrow_icon_size(:xs), do: "w-3 h-3"
  defp arrow_icon_size(:sm), do: "w-3 h-3"
  defp arrow_icon_size(:md), do: "w-4 h-4"
  defp arrow_icon_size(:lg), do: "w-5 h-5"

  # Arrow SVG paths
  defp arrow_path(:up), do: "M5 15l7-7 7 7"
  defp arrow_path(:down), do: "M19 9l-7 7-7-7"
  defp arrow_path(:left), do: "M15 19l-7-7 7-7"
  defp arrow_path(:right), do: "M9 5l7 7-7 7"
end
