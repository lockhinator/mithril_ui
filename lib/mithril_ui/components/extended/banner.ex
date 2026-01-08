defmodule MithrilUI.Components.Banner do
  @moduledoc """
  Banner component for announcements, promotions, and notifications.

  ## Examples

  Basic banner:

      <.banner>
        Important announcement here!
      </.banner>

  Dismissible banner:

      <.banner id="promo-banner" dismissible>
        Special offer: 20% off today!
      </.banner>

  CTA banner:

      <.banner_cta href="/signup">
        <:title>Join our newsletter</:title>
        <:description>Get weekly updates and exclusive content.</:description>
        <:button>Subscribe</:button>
      </.banner_cta>
  """

  use Phoenix.Component
  alias Phoenix.LiveView.JS

  @positions ~w(top bottom)
  @variants ~w(default info success warning error)

  @doc """
  Renders a simple announcement banner.

  ## Attributes

    * `:id` - Banner ID (required for dismissible banners).
    * `:position` - Position: top, bottom. Defaults to "top".
    * `:variant` - Style variant: default, info, success, warning, error.
    * `:fixed` - Fix to viewport. Defaults to false.
    * `:dismissible` - Show close button. Defaults to false.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:icon` - Optional leading icon.
    * `:inner_block` - Banner content (required).

  ## Examples

      <.banner>New feature available!</.banner>

      <.banner id="notice" variant="info" dismissible>
        <:icon><svg>...</svg></:icon>
        Check out our updated documentation.
      </.banner>
  """
  @spec banner(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :string, default: nil
  attr :position, :string, default: "top", values: @positions
  attr :variant, :string, default: "default", values: @variants
  attr :fixed, :boolean, default: false
  attr :dismissible, :boolean, default: false
  attr :class, :string, default: nil
  attr :rest, :global

  slot :icon
  slot :inner_block, required: true

  def banner(assigns) do
    ~H"""
    <div
      id={@id}
      class={[
        "flex items-center justify-between gap-4 px-4 py-3",
        variant_classes(@variant),
        @fixed && position_classes(@position),
        @fixed && "z-50 w-full",
        !@fixed && "rounded-lg",
        @class
      ]}
      {@rest}
    >
      <div class="flex items-center gap-3">
        <span :if={@icon != []} class="shrink-0">
          {render_slot(@icon)}
        </span>
        <div class="text-sm font-medium">
          {render_slot(@inner_block)}
        </div>
      </div>
      <button
        :if={@dismissible && @id}
        type="button"
        class="btn btn-ghost btn-sm btn-circle"
        aria-label="Close"
        phx-click={JS.hide(to: "##{@id}")}
      >
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
        </svg>
      </button>
    </div>
    """
  end

  defp variant_classes("default"), do: "bg-base-200 text-base-content"
  defp variant_classes("info"), do: "bg-info text-info-content"
  defp variant_classes("success"), do: "bg-success text-success-content"
  defp variant_classes("warning"), do: "bg-warning text-warning-content"
  defp variant_classes("error"), do: "bg-error text-error-content"

  defp position_classes("top"), do: "fixed top-0 left-0 right-0"
  defp position_classes("bottom"), do: "fixed bottom-0 left-0 right-0"

  @doc """
  Renders a CTA (call-to-action) banner with title, description, and button.

  ## Attributes

    * `:id` - Banner ID.
    * `:href` - Link URL for the CTA button.
    * `:position` - Position when fixed: top, bottom.
    * `:fixed` - Fix to viewport. Defaults to false.
    * `:dismissible` - Show close button. Defaults to false.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:title` - Banner title.
    * `:description` - Banner description.
    * `:button` - CTA button text.

  ## Examples

      <.banner_cta href="/signup">
        <:title>Free trial available</:title>
        <:description>Try all features for 14 days.</:description>
        <:button>Start free trial</:button>
      </.banner_cta>
  """
  @spec banner_cta(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :string, default: nil
  attr :href, :string, default: nil
  attr :position, :string, default: "top", values: @positions
  attr :fixed, :boolean, default: false
  attr :dismissible, :boolean, default: false
  attr :class, :string, default: nil
  attr :rest, :global

  slot :title
  slot :description
  slot :button

  def banner_cta(assigns) do
    ~H"""
    <div
      id={@id}
      class={[
        "px-4 py-4 bg-base-200",
        @fixed && position_classes(@position),
        @fixed && "z-50 w-full",
        !@fixed && "rounded-lg",
        @class
      ]}
      {@rest}
    >
      <div class="flex flex-col md:flex-row items-center justify-between gap-4">
        <div class="text-center md:text-left">
          <p :if={@title != []} class="font-semibold text-base-content">
            {render_slot(@title)}
          </p>
          <p :if={@description != []} class="text-sm text-base-content/70">
            {render_slot(@description)}
          </p>
        </div>
        <div class="flex items-center gap-3 shrink-0">
          <a :if={@button != [] && @href} href={@href} class="btn btn-primary btn-sm">
            {render_slot(@button)}
          </a>
          <button
            :if={@dismissible && @id}
            type="button"
            class="btn btn-ghost btn-sm btn-circle"
            aria-label="Close"
            phx-click={JS.hide(to: "##{@id}")}
          >
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Renders a newsletter signup banner.

  ## Attributes

    * `:id` - Banner ID.
    * `:action` - Form action URL.
    * `:position` - Position when fixed.
    * `:fixed` - Fix to viewport. Defaults to false.
    * `:dismissible` - Show close button. Defaults to false.
    * `:placeholder` - Input placeholder text.
    * `:button_text` - Submit button text.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:title` - Banner title.

  ## Examples

      <.banner_newsletter action="/subscribe">
        <:title>Subscribe to our newsletter</:title>
      </.banner_newsletter>
  """
  @spec banner_newsletter(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :string, default: nil
  attr :action, :string, default: nil
  attr :position, :string, default: "top", values: @positions
  attr :fixed, :boolean, default: false
  attr :dismissible, :boolean, default: false
  attr :placeholder, :string, default: "Enter your email"
  attr :button_text, :string, default: "Subscribe"
  attr :class, :string, default: nil
  attr :rest, :global

  slot :title

  def banner_newsletter(assigns) do
    ~H"""
    <div
      id={@id}
      class={[
        "px-4 py-4 bg-base-200",
        @fixed && position_classes(@position),
        @fixed && "z-50 w-full",
        !@fixed && "rounded-lg",
        @class
      ]}
      {@rest}
    >
      <div class="flex flex-col md:flex-row items-center justify-between gap-4">
        <p :if={@title != []} class="font-semibold text-base-content">
          {render_slot(@title)}
        </p>
        <div class="flex items-center gap-3">
          <form action={@action} method="post" class="flex">
            <div class="join">
              <input
                type="email"
                name="email"
                placeholder={@placeholder}
                class="input input-bordered input-sm join-item w-48"
                required
              />
              <button type="submit" class="btn btn-primary btn-sm join-item">
                <%= @button_text %>
              </button>
            </div>
          </form>
          <button
            :if={@dismissible && @id}
            type="button"
            class="btn btn-ghost btn-sm btn-circle"
            aria-label="Close"
            phx-click={JS.hide(to: "##{@id}")}
          >
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Renders an informational banner with icon, heading, and actions.

  ## Attributes

    * `:id` - Banner ID.
    * `:variant` - Style variant.
    * `:position` - Position when fixed.
    * `:fixed` - Fix to viewport. Defaults to false.
    * `:dismissible` - Show close button. Defaults to false.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:icon` - Leading icon.
    * `:title` - Banner heading.
    * `:description` - Banner text.
    * `:actions` - Action buttons.

  ## Examples

      <.banner_info id="update-notice" variant="info" dismissible>
        <:icon><svg>...</svg></:icon>
        <:title>System Update</:title>
        <:description>Scheduled maintenance on Sunday.</:description>
        <:actions>
          <a href="#" class="btn btn-sm">Learn more</a>
        </:actions>
      </.banner_info>
  """
  @spec banner_info(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :string, default: nil
  attr :variant, :string, default: "info", values: @variants
  attr :position, :string, default: "top", values: @positions
  attr :fixed, :boolean, default: false
  attr :dismissible, :boolean, default: false
  attr :class, :string, default: nil
  attr :rest, :global

  slot :icon
  slot :title
  slot :description
  slot :actions

  def banner_info(assigns) do
    ~H"""
    <div
      id={@id}
      class={[
        "px-4 py-4",
        variant_classes(@variant),
        @fixed && position_classes(@position),
        @fixed && "z-50 w-full",
        !@fixed && "rounded-lg",
        @class
      ]}
      {@rest}
    >
      <div class="flex items-start gap-4">
        <span :if={@icon != []} class="shrink-0 mt-0.5">
          {render_slot(@icon)}
        </span>
        <div class="flex-1">
          <p :if={@title != []} class="font-semibold">
            {render_slot(@title)}
          </p>
          <p :if={@description != []} class="text-sm opacity-90">
            {render_slot(@description)}
          </p>
          <div :if={@actions != []} class="mt-3 flex gap-2">
            {render_slot(@actions)}
          </div>
        </div>
        <button
          :if={@dismissible && @id}
          type="button"
          class="btn btn-ghost btn-sm btn-circle shrink-0"
          aria-label="Close"
          phx-click={JS.hide(to: "##{@id}")}
        >
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
      </div>
    </div>
    """
  end
end
