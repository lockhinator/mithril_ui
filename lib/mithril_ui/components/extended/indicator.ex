defmodule MithrilUI.Components.Indicator do
  @moduledoc """
  Indicator component for displaying status dots, badges, and notifications.

  ## Examples

  Basic indicator:

      <.indicator>
        <:badge class="badge badge-primary">New</:badge>
        <button class="btn">Messages</button>
      </.indicator>

  Status dot:

      <.indicator>
        <:badge class="badge badge-xs badge-success" />
        <.avatar src="/avatar.jpg" />
      </.indicator>

  ## DaisyUI Classes

  - `indicator` - Container class
  - `indicator-item` - The positioned badge/dot
  - `indicator-start` - Align to start (left)
  - `indicator-center` - Center alignment
  - `indicator-end` - Align to end (right) [default]
  - `indicator-top` - Position at top [default]
  - `indicator-middle` - Center vertically
  - `indicator-bottom` - Position at bottom
  """

  use Phoenix.Component

  @horizontal_positions ~w(start center end)
  @vertical_positions ~w(top middle bottom)
  @colors ~w(primary secondary accent neutral info success warning error)

  @doc """
  Renders an indicator container with positioned badge.

  ## Attributes

    * `:horizontal` - Horizontal position: start, center, end. Defaults to "end".
    * `:vertical` - Vertical position: top, middle, bottom. Defaults to "top".
    * `:class` - Additional CSS classes.

  ## Slots

    * `:badge` - The indicator badge content.
    * `:inner_block` - The main content (required).

  ## Examples

      <.indicator>
        <:badge class="badge badge-secondary">99+</:badge>
        <button class="btn">Inbox</button>
      </.indicator>

      <.indicator horizontal="start" vertical="bottom">
        <:badge class="badge badge-xs badge-success" />
        <div class="bg-base-300 p-4">Content</div>
      </.indicator>
  """
  @spec indicator(map()) :: Phoenix.LiveView.Rendered.t()

  attr :horizontal, :string, default: "end", values: @horizontal_positions
  attr :vertical, :string, default: "top", values: @vertical_positions
  attr :class, :any, default: nil
  attr :rest, :global

  slot :badge
  slot :inner_block, required: true

  def indicator(assigns) do
    ~H"""
    <div class={["indicator", @class]} {@rest}>
      <span
        :for={badge <- @badge}
        class={[
          "indicator-item",
          @horizontal != "end" && "indicator-#{@horizontal}",
          @vertical != "top" && "indicator-#{@vertical}",
          badge[:class]
        ]}
      >
        {render_slot(badge)}
      </span>
      {render_slot(@inner_block)}
    </div>
    """
  end

  @doc """
  Renders a simple status indicator dot.

  ## Attributes

    * `:color` - Dot color.
    * `:size` - Dot size: xs, sm, md. Defaults to "sm".
    * `:pulse` - Add pulse animation. Defaults to false.
    * `:class` - Additional CSS classes.

  ## Examples

      <.status_dot color="success" />

      <.status_dot color="error" pulse />
  """
  @spec status_dot(map()) :: Phoenix.LiveView.Rendered.t()

  attr :color, :string, default: "primary", values: @colors
  attr :size, :string, default: "sm", values: ~w(xs sm md)
  attr :pulse, :boolean, default: false
  attr :class, :any, default: nil
  attr :rest, :global

  def status_dot(assigns) do
    size_class =
      case assigns.size do
        "xs" -> "w-2 h-2"
        "sm" -> "w-2.5 h-2.5"
        "md" -> "w-3 h-3"
      end

    assigns = assign(assigns, :size_class, size_class)

    ~H"""
    <span
      class={[
        "inline-flex rounded-full",
        "bg-#{@color}",
        @size_class,
        @pulse && "animate-pulse",
        @class
      ]}
      {@rest}
    />
    """
  end

  @doc """
  Renders a legend indicator with text label.

  ## Attributes

    * `:color` - Indicator color.
    * `:label` - Text label (required).
    * `:class` - Additional CSS classes.

  ## Examples

      <.legend_indicator color="success" label="Online" />

      <.legend_indicator color="warning" label="Away" />
  """
  @spec legend_indicator(map()) :: Phoenix.LiveView.Rendered.t()

  attr :color, :string, default: "primary", values: @colors
  attr :label, :string, required: true
  attr :class, :any, default: nil
  attr :rest, :global

  def legend_indicator(assigns) do
    ~H"""
    <span class={["flex items-center text-sm", @class]} {@rest}>
      <span class={["flex w-2.5 h-2.5 rounded-full mr-1.5 shrink-0", "bg-#{@color}"]} />
      {@label}
    </span>
    """
  end

  @doc """
  Renders a count badge indicator, typically for notifications.

  ## Attributes

    * `:count` - Number to display (required).
    * `:max` - Maximum before showing "max+". Defaults to 99.
    * `:color` - Badge color. Defaults to "primary".
    * `:show_zero` - Show when count is 0. Defaults to false.
    * `:horizontal` - Horizontal position.
    * `:vertical` - Vertical position.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - The main content (required).

  ## Examples

      <.count_indicator count={5}>
        <button class="btn">Messages</button>
      </.count_indicator>

      <.count_indicator count={150} max={99}>
        <button class="btn">Notifications</button>
      </.count_indicator>
  """
  @spec count_indicator(map()) :: Phoenix.LiveView.Rendered.t()

  attr :count, :integer, required: true
  attr :max, :integer, default: 99
  attr :color, :string, default: "primary", values: @colors
  attr :show_zero, :boolean, default: false
  attr :horizontal, :string, default: "end", values: @horizontal_positions
  attr :vertical, :string, default: "top", values: @vertical_positions
  attr :class, :any, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def count_indicator(assigns) do
    display = if assigns.count > assigns.max, do: "#{assigns.max}+", else: "#{assigns.count}"
    assigns = assign(assigns, :display, display)

    ~H"""
    <div class={["indicator", @class]} {@rest}>
      <span
        :if={@count > 0 || @show_zero}
        class={[
          "indicator-item badge badge-sm",
          "badge-#{@color}",
          @horizontal != "end" && "indicator-#{@horizontal}",
          @vertical != "top" && "indicator-#{@vertical}"
        ]}
      >
        {@display}
      </span>
      {render_slot(@inner_block)}
    </div>
    """
  end

  @doc """
  Renders a status indicator on an avatar.

  ## Attributes

    * `:status` - Status type: online, offline, away, busy. Defaults to "online".
    * `:position` - Position: top-right, bottom-right, bottom-left. Defaults to "bottom-right".
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Avatar content (required).

  ## Examples

      <.avatar_status status="online">
        <div class="avatar">
          <div class="w-12 rounded-full">
            <img src="/avatar.jpg" />
          </div>
        </div>
      </.avatar_status>
  """
  @spec avatar_status(map()) :: Phoenix.LiveView.Rendered.t()

  attr :status, :string, default: "online", values: ~w(online offline away busy)
  attr :position, :string, default: "bottom-right", values: ~w(top-right bottom-right bottom-left)
  attr :class, :any, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def avatar_status(assigns) do
    {horizontal, vertical} = position_to_classes(assigns.position)
    color = status_to_color(assigns.status)
    assigns = assign(assigns, horizontal: horizontal, vertical: vertical, color: color)

    ~H"""
    <div class={["indicator", @class]} {@rest}>
      <span class={[
        "indicator-item badge badge-xs",
        "badge-#{@color}",
        @horizontal != "end" && "indicator-#{@horizontal}",
        @vertical != "top" && "indicator-#{@vertical}"
      ]} />
      {render_slot(@inner_block)}
    </div>
    """
  end

  defp position_to_classes("top-right"), do: {"end", "top"}
  defp position_to_classes("bottom-right"), do: {"end", "bottom"}
  defp position_to_classes("bottom-left"), do: {"start", "bottom"}

  defp status_to_color("online"), do: "success"
  defp status_to_color("offline"), do: "neutral"
  defp status_to_color("away"), do: "warning"
  defp status_to_color("busy"), do: "error"
end
