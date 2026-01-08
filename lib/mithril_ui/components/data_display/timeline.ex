defmodule MithrilUI.Components.Timeline do
  @moduledoc """
  Timeline component for displaying chronological events or steps.

  ## Examples

  Basic timeline:

      <.timeline>
        <:item>First event</:item>
        <:item>Second event</:item>
        <:item>Third event</:item>
      </.timeline>

  With dates and status:

      <.timeline>
        <:item time="2024-01-01" status="done">Project started</:item>
        <:item time="2024-02-15" status="current">In development</:item>
        <:item time="2024-03-01" status="pending">Launch</:item>
      </.timeline>

  ## DaisyUI Classes

  - `timeline` - Base timeline styling
  - `timeline-vertical` - Vertical layout
  - `timeline-horizontal` - Horizontal layout
  - `timeline-snap-icon` - Snap icon to center
  """

  use Phoenix.Component

  @doc """
  Renders a timeline.

  ## Attributes

    * `:horizontal` - Horizontal layout. Defaults to false (vertical).
    * `:compact` - Compact spacing. Defaults to false.
    * `:snap_icon` - Snap icons to center. Defaults to true.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:item` - Timeline items.
      - `:time` - Timestamp or date text.
      - `:title` - Item title.
      - `:status` - Item status: done, current, pending.
      - `:icon` - Custom icon content.
      - `:position` - Content position: start, end (for horizontal). Defaults based on index.

  ## Examples

      <.timeline>
        <:item time="Jan 2024" title="Started" status="done">
          Project kickoff and planning phase.
        </:item>
        <:item time="Feb 2024" title="Development" status="current">
          Building core features.
        </:item>
      </.timeline>
  """
  @spec timeline(map()) :: Phoenix.LiveView.Rendered.t()

  attr :horizontal, :boolean, default: false
  attr :compact, :boolean, default: false
  attr :snap_icon, :boolean, default: true
  attr :class, :string, default: nil

  slot :item, required: true do
    attr :time, :string
    attr :title, :string
    attr :status, :string
    attr :position, :string
  end

  slot :icon

  def timeline(assigns) do
    items_with_index = Enum.with_index(assigns.item)
    assigns = assign(assigns, :items_with_index, items_with_index)

    ~H"""
    <ul class={timeline_classes(@horizontal, @compact, @snap_icon, @class)}>
      <li :for={{item, idx} <- @items_with_index}>
        <hr :if={idx > 0} class={status_line_class(Enum.at(@item, idx - 1)[:status])} />
        <div :if={item[:time]} class={time_class(item[:position], idx)}>
          <%= item[:time] %>
        </div>
        <div class="timeline-middle">
          <%= if item[:icon] do %>
            {render_slot(item[:icon])}
          <% else %>
            <.status_icon status={item[:status]} />
          <% end %>
        </div>
        <div class={content_class(item[:position], idx)}>
          <div :if={item[:title]} class="font-bold"><%= item[:title] %></div>
          {render_slot(item)}
        </div>
        <hr :if={idx < length(@item) - 1} class={status_line_class(item[:status])} />
      </li>
    </ul>
    """
  end

  defp status_icon(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 20 20"
      fill="currentColor"
      class={["h-5 w-5", status_icon_class(@status)]}
    >
      <path
        :if={@status == "done"}
        fill-rule="evenodd"
        d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z"
        clip-rule="evenodd"
      />
      <path
        :if={@status == "current"}
        fill-rule="evenodd"
        d="M10 18a8 8 0 100-16 8 8 0 000 16zm.75-13a.75.75 0 00-1.5 0v5c0 .414.336.75.75.75h4a.75.75 0 000-1.5h-3.25V5z"
        clip-rule="evenodd"
      />
      <path
        :if={@status != "done" && @status != "current"}
        fill-rule="evenodd"
        d="M10 18a8 8 0 100-16 8 8 0 000 16zm0-12a.75.75 0 01.75.75v4.5a.75.75 0 01-1.5 0v-4.5A.75.75 0 0110 6z"
        clip-rule="evenodd"
      />
    </svg>
    """
  end

  @doc """
  Renders a simple timeline from a list of events.

  ## Attributes

    * `:events` - List of event maps with :time, :title, :description, :status keys.

  ## Examples

      <.simple_timeline events={[
        %{time: "9:00 AM", title: "Meeting", status: "done"},
        %{time: "2:00 PM", title: "Review", status: "current"}
      ]} />
  """
  @spec simple_timeline(map()) :: Phoenix.LiveView.Rendered.t()

  attr :events, :list, required: true
  attr :horizontal, :boolean, default: false
  attr :class, :string, default: nil

  def simple_timeline(assigns) do
    ~H"""
    <ul class={timeline_classes(@horizontal, false, true, @class)}>
      <li :for={{event, idx} <- Enum.with_index(@events)}>
        <hr :if={idx > 0} class={status_line_class(Enum.at(@events, idx - 1)[:status])} />
        <div :if={event[:time]} class="timeline-start">
          <%= event[:time] %>
        </div>
        <div class="timeline-middle">
          <.status_icon status={event[:status]} />
        </div>
        <div class="timeline-end timeline-box">
          <div :if={event[:title]} class="font-bold"><%= event[:title] %></div>
          <div :if={event[:description]}><%= event[:description] %></div>
        </div>
        <hr :if={idx < length(@events) - 1} class={status_line_class(event[:status])} />
      </li>
    </ul>
    """
  end

  defp timeline_classes(horizontal, compact, snap_icon, extra_class) do
    [
      "timeline",
      horizontal && "timeline-horizontal",
      !horizontal && "timeline-vertical",
      compact && "timeline-compact",
      snap_icon && "timeline-snap-icon",
      extra_class
    ]
  end

  defp time_class(nil, idx), do: if(rem(idx, 2) == 0, do: "timeline-start", else: "timeline-end")
  defp time_class("start", _idx), do: "timeline-start"
  defp time_class("end", _idx), do: "timeline-end"

  defp content_class(nil, idx), do: if(rem(idx, 2) == 0, do: "timeline-end timeline-box", else: "timeline-start timeline-box")
  defp content_class("start", _idx), do: "timeline-start timeline-box"
  defp content_class("end", _idx), do: "timeline-end timeline-box"

  defp status_icon_class("done"), do: "text-success"
  defp status_icon_class("current"), do: "text-primary"
  defp status_icon_class(_), do: "text-base-content/50"

  defp status_line_class("done"), do: "bg-success"
  defp status_line_class(_), do: nil
end
