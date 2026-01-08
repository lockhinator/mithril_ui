defmodule MithrilUI.Components.Tabs do
  @moduledoc """
  A tabbed interface component for organizing content into sections.

  Supports multiple visual styles including bordered, lifted, and boxed variants,
  as well as various sizes and positioning options.

  ## Examples

  Basic tabs:

      <.tabs>
        <:tab label="Tab 1" active>Content for tab 1</:tab>
        <:tab label="Tab 2">Content for tab 2</:tab>
        <:tab label="Tab 3">Content for tab 3</:tab>
      </.tabs>

  Boxed tabs:

      <.tabs variant="boxed">
        <:tab label="Overview" active>Overview content</:tab>
        <:tab label="Details">Details content</:tab>
      </.tabs>

  ## DaisyUI Classes

  The component uses the following DaisyUI classes:
  - `tabs` - Base container
  - `tab` - Individual tab item
  - `tab-active` - Active tab state
  - `tabs-bordered` - Bordered variant
  - `tabs-lifted` - Lifted variant
  - `tabs-boxed` - Boxed variant
  - `tab-content` - Tab content container
  """

  use Phoenix.Component

  @variants ~w(default bordered lifted boxed)
  @sizes ~w(xs sm md lg xl)

  @doc """
  Renders a tabbed interface.

  ## Attributes

    * `:variant` - Visual style: default, bordered, lifted, boxed. Defaults to "bordered".
    * `:size` - Tab size: xs, sm, md, lg, xl. Defaults to nil (default size).
    * `:class` - Additional CSS classes for the tabs container.

  ## Slots

    * `:tab` - Tab items with content.
      - `:label` - Tab button label (required).
      - `:active` - Whether this tab is currently active.
      - `:disabled` - Whether this tab is disabled.
      - `:icon` - Optional icon content.

  ## Examples

      <.tabs variant="lifted" size="lg">
        <:tab label="Home" active icon={home_icon()}>Home content</:tab>
        <:tab label="Profile">Profile content</:tab>
        <:tab label="Settings" disabled>Settings content</:tab>
      </.tabs>
  """
  @spec tabs(map()) :: Phoenix.LiveView.Rendered.t()

  attr :variant, :string, default: "bordered", values: @variants
  attr :size, :string, default: nil, values: @sizes ++ [nil]
  attr :class, :any, default: nil

  attr :rest, :global

  slot :tab, required: true do
    attr :label, :string, required: true
    attr :active, :boolean
    attr :disabled, :boolean
    attr :icon, :any
  end

  def tabs(assigns) do
    ~H"""
    <div {@rest}>
      <div role="tablist" class={tabs_classes(@variant, @size, @class)}>
        <%= for tab <- @tab do %>
          <button
            type="button"
            role="tab"
            class={tab_classes(@variant, tab[:active], tab[:disabled])}
            disabled={tab[:disabled]}
            aria-selected={tab[:active]}
          >
            <span :if={tab[:icon]} class="mr-2">{tab[:icon]}</span>
            {tab[:label]}
          </button>
          <div
            :if={tab[:active]}
            role="tabpanel"
            class={tab_content_classes(@variant)}
          >
            {render_slot(tab)}
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  @doc """
  Renders tabs controlled by LiveView events.

  Each tab click triggers a phx-click event instead of showing inline content.

  ## Attributes

    * `:tabs` - List of tab definitions as maps with :id, :label, and optional :disabled keys (required).
    * `:active_tab` - ID of the currently active tab (required).
    * `:on_change` - Event name to trigger when tab is clicked.
    * `:variant` - Visual style: default, bordered, lifted, boxed. Defaults to "bordered".
    * `:size` - Tab size: xs, sm, md, lg, xl.
    * `:class` - Additional CSS classes.

  ## Examples

      <.controlled_tabs
        tabs={[
          %{id: "overview", label: "Overview"},
          %{id: "details", label: "Details"},
          %{id: "settings", label: "Settings", disabled: true}
        ]}
        active_tab={@current_tab}
        on_change="change_tab"
      />
  """
  @spec controlled_tabs(map()) :: Phoenix.LiveView.Rendered.t()

  attr :tabs, :list, required: true
  attr :active_tab, :any, required: true
  attr :on_change, :string, default: nil
  attr :variant, :string, default: "bordered", values: @variants
  attr :size, :string, default: nil, values: @sizes ++ [nil]
  attr :class, :any, default: nil

  attr :rest, :global

  def controlled_tabs(assigns) do
    ~H"""
    <div role="tablist" class={tabs_classes(@variant, @size, @class)} {@rest}>
      <button
        :for={tab <- @tabs}
        type="button"
        role="tab"
        class={tab_classes(@variant, to_string(tab.id) == to_string(@active_tab), tab[:disabled])}
        disabled={tab[:disabled]}
        aria-selected={to_string(tab.id) == to_string(@active_tab)}
        phx-click={@on_change}
        phx-value-tab={tab.id}
      >
        <span :if={tab[:icon]} class="mr-2">{tab[:icon]}</span>
        {tab.label}
      </button>
    </div>
    """
  end

  @doc """
  Renders radio-based tabs that work without JavaScript.

  Uses HTML radio inputs for tab switching, useful for static content.

  ## Attributes

    * `:name` - Radio group name (required).
    * `:variant` - Visual style: default, bordered, lifted, boxed. Defaults to "lifted".
    * `:size` - Tab size: xs, sm, md, lg, xl.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:tab` - Tab items with content.
      - `:label` - Tab label (required).
      - `:checked` - Whether this tab is initially checked.

  ## Examples

      <.radio_tabs name="my-tabs">
        <:tab label="Tab 1" checked>Content 1</:tab>
        <:tab label="Tab 2">Content 2</:tab>
        <:tab label="Tab 3">Content 3</:tab>
      </.radio_tabs>
  """
  @spec radio_tabs(map()) :: Phoenix.LiveView.Rendered.t()

  attr :name, :string, required: true
  attr :variant, :string, default: "lifted", values: @variants
  attr :size, :string, default: nil, values: @sizes ++ [nil]
  attr :class, :any, default: nil

  attr :rest, :global

  slot :tab, required: true do
    attr :label, :string, required: true
    attr :checked, :boolean
  end

  def radio_tabs(assigns) do
    ~H"""
    <div role="tablist" class={tabs_classes(@variant, @size, @class)} {@rest}>
      <%= for {tab, index} <- Enum.with_index(@tab) do %>
        <input
          type="radio"
          name={@name}
          role="tab"
          class={tab_classes(@variant, false, false)}
          aria-label={tab[:label]}
          checked={tab[:checked]}
          id={"#{@name}-#{index}"}
        />
        <div role="tabpanel" class={tab_content_classes(@variant)}>
          {render_slot(tab)}
        </div>
      <% end %>
    </div>
    """
  end

  defp tabs_classes(variant, size, extra_class) do
    [
      "tabs",
      variant_class(variant),
      size && "tabs-#{size}",
      extra_class
    ]
  end

  defp variant_class("default"), do: nil
  defp variant_class("bordered"), do: "tabs-bordered"
  defp variant_class("lifted"), do: "tabs-lifted"
  defp variant_class("boxed"), do: "tabs-boxed"

  defp tab_classes(variant, active, disabled) do
    [
      "tab",
      active && "tab-active",
      disabled && "tab-disabled",
      variant == "lifted" && active && "[--tab-bg:var(--fallback-b1,oklch(var(--b1)))]"
    ]
  end

  defp tab_content_classes("lifted") do
    "tab-content bg-base-100 border-base-300 rounded-box p-6"
  end

  defp tab_content_classes(_variant) do
    "tab-content p-4"
  end
end
