defmodule MithrilUI.Components.Carousel do
  @moduledoc """
  Carousel component for image sliders and content carousels.

  ## Examples

  Basic carousel:

      <.carousel>
        <.carousel_item id="slide1" src="/image1.jpg" />
        <.carousel_item id="slide2" src="/image2.jpg" />
        <.carousel_item id="slide3" src="/image3.jpg" />
      </.carousel>

  With navigation:

      <.carousel navigation>
        <.carousel_item id="s1" src="/a.jpg" prev="s3" next="s2" />
        <.carousel_item id="s2" src="/b.jpg" prev="s1" next="s3" />
        <.carousel_item id="s3" src="/c.jpg" prev="s2" next="s1" />
      </.carousel>

  ## DaisyUI Classes

  - `carousel` - Container class
  - `carousel-item` - Individual slide
  - `carousel-start` - Snap to start [default]
  - `carousel-center` - Snap to center
  - `carousel-end` - Snap to end
  - `carousel-vertical` - Vertical scrolling
  """

  use Phoenix.Component

  @snap_positions ~w(start center end)

  @doc """
  Renders a carousel container.

  ## Attributes

    * `:snap` - Snap position: start, center, end. Defaults to "start".
    * `:vertical` - Enable vertical scrolling. Defaults to false.
    * `:full_width` - Make items full width. Defaults to false.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Carousel items (required).

  ## Examples

      <.carousel>
        <.carousel_item id="item1" src="/img1.jpg" />
        <.carousel_item id="item2" src="/img2.jpg" />
      </.carousel>

      <.carousel snap="center" full_width>
        <.carousel_item id="s1" src="/hero.jpg" />
      </.carousel>
  """
  @spec carousel(map()) :: Phoenix.LiveView.Rendered.t()

  attr :snap, :string, default: "start", values: @snap_positions
  attr :vertical, :boolean, default: false
  attr :full_width, :boolean, default: false
  attr :class, :string, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def carousel(assigns) do
    ~H"""
    <div
      class={[
        "carousel",
        "carousel-#{@snap}",
        @vertical && "carousel-vertical",
        @full_width && "w-full",
        @class
      ]}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  @doc """
  Renders a carousel item with an image.

  ## Attributes

    * `:id` - Item ID for navigation.
    * `:src` - Image source URL (required).
    * `:alt` - Image alt text.
    * `:prev` - ID of previous item (for navigation buttons).
    * `:next` - ID of next item (for navigation buttons).
    * `:full_width` - Make item full width. Defaults to false.
    * `:class` - Additional CSS classes.

  ## Examples

      <.carousel_item id="slide1" src="/image.jpg" />

      <.carousel_item id="s1" src="/img.jpg" prev="s3" next="s2" />
  """
  @spec carousel_item(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :string, required: true
  attr :src, :string, required: true
  attr :alt, :string, default: ""
  attr :prev, :string, default: nil
  attr :next, :string, default: nil
  attr :full_width, :boolean, default: false
  attr :class, :string, default: nil
  attr :rest, :global

  def carousel_item(assigns) do
    ~H"""
    <div
      id={@id}
      class={[
        "carousel-item relative",
        @full_width && "w-full",
        @class
      ]}
      {@rest}
    >
      <img src={@src} alt={@alt} class="w-full" />
      <div :if={@prev || @next} class="absolute flex justify-between transform -translate-y-1/2 left-5 right-5 top-1/2">
        <a :if={@prev} href={"##{@prev}"} class="btn btn-circle">
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
          </svg>
        </a>
        <a :if={@next} href={"##{@next}"} class="btn btn-circle">
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
          </svg>
        </a>
      </div>
    </div>
    """
  end

  @doc """
  Renders a carousel item with custom content.

  ## Attributes

    * `:id` - Item ID for navigation.
    * `:prev` - ID of previous item.
    * `:next` - ID of next item.
    * `:full_width` - Make item full width. Defaults to false.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Custom content (required).

  ## Examples

      <.carousel_content id="card1">
        <div class="card">...</div>
      </.carousel_content>
  """
  @spec carousel_content(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :string, required: true
  attr :prev, :string, default: nil
  attr :next, :string, default: nil
  attr :full_width, :boolean, default: false
  attr :class, :string, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def carousel_content(assigns) do
    ~H"""
    <div
      id={@id}
      class={[
        "carousel-item relative",
        @full_width && "w-full",
        @class
      ]}
      {@rest}
    >
      {render_slot(@inner_block)}
      <div :if={@prev || @next} class="absolute flex justify-between transform -translate-y-1/2 left-5 right-5 top-1/2">
        <a :if={@prev} href={"##{@prev}"} class="btn btn-circle">
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
          </svg>
        </a>
        <a :if={@next} href={"##{@next}"} class="btn btn-circle">
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
          </svg>
        </a>
      </div>
    </div>
    """
  end

  @doc """
  Renders carousel indicator dots for navigation.

  ## Attributes

    * `:count` - Number of slides (required).
    * `:prefix` - ID prefix for slides. Defaults to "slide".
    * `:active` - Currently active slide index (0-based). Defaults to 0.
    * `:class` - Additional CSS classes.

  ## Examples

      <.carousel_indicators count={5} prefix="item" />

      <.carousel_indicators count={3} active={1} />
  """
  @spec carousel_indicators(map()) :: Phoenix.LiveView.Rendered.t()

  attr :count, :integer, required: true
  attr :prefix, :string, default: "slide"
  attr :active, :integer, default: 0
  attr :class, :string, default: nil
  attr :rest, :global

  def carousel_indicators(assigns) do
    ~H"""
    <div class={["flex justify-center w-full py-2 gap-2", @class]} {@rest}>
      <%= for i <- 0..(@count - 1) do %>
        <a
          href={"##{@prefix}#{i}"}
          class={[
            "btn btn-xs",
            if(i == @active, do: "btn-primary", else: "btn-ghost")
          ]}
        >
          <%= i + 1 %>
        </a>
      <% end %>
    </div>
    """
  end

  @doc """
  Renders a full carousel with indicators.

  ## Attributes

    * `:items` - List of image URLs (required).
    * `:id_prefix` - Prefix for item IDs. Defaults to "carousel".
    * `:snap` - Snap position.
    * `:show_indicators` - Show indicator dots. Defaults to true.
    * `:show_navigation` - Show prev/next buttons. Defaults to true.
    * `:class` - Additional CSS classes.

  ## Examples

      <.carousel_full items={["/img1.jpg", "/img2.jpg", "/img3.jpg"]} />
  """
  @spec carousel_full(map()) :: Phoenix.LiveView.Rendered.t()

  attr :items, :list, required: true
  attr :id_prefix, :string, default: "carousel"
  attr :snap, :string, default: "start", values: @snap_positions
  attr :show_indicators, :boolean, default: true
  attr :show_navigation, :boolean, default: true
  attr :class, :string, default: nil
  attr :rest, :global

  def carousel_full(assigns) do
    item_count = length(assigns.items)
    assigns = assign(assigns, :item_count, item_count)

    ~H"""
    <div class={@class} {@rest}>
      <div class={["carousel w-full", "carousel-#{@snap}"]}>
        <%= for {src, index} <- Enum.with_index(@items) do %>
          <% id = "#{@id_prefix}#{index}" %>
          <% prev_index = rem(index - 1 + @item_count, @item_count) %>
          <% next_index = rem(index + 1, @item_count) %>
          <div id={id} class="carousel-item relative w-full">
            <img src={src} class="w-full" alt={"Slide #{index + 1}"} />
            <div :if={@show_navigation} class="absolute flex justify-between transform -translate-y-1/2 left-5 right-5 top-1/2">
              <a href={"##{@id_prefix}#{prev_index}"} class="btn btn-circle">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
                </svg>
              </a>
              <a href={"##{@id_prefix}#{next_index}"} class="btn btn-circle">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                </svg>
              </a>
            </div>
          </div>
        <% end %>
      </div>
      <.carousel_indicators :if={@show_indicators} count={@item_count} prefix={@id_prefix} />
    </div>
    """
  end

  @doc """
  Renders a thumbnail carousel with preview images.

  ## Attributes

    * `:items` - List of image URLs (required).
    * `:id_prefix` - Prefix for item IDs. Defaults to "thumb".
    * `:class` - Additional CSS classes.

  ## Examples

      <.carousel_thumbnails items={["/a.jpg", "/b.jpg", "/c.jpg"]} />
  """
  @spec carousel_thumbnails(map()) :: Phoenix.LiveView.Rendered.t()

  attr :items, :list, required: true
  attr :id_prefix, :string, default: "thumb"
  attr :class, :string, default: nil
  attr :rest, :global

  def carousel_thumbnails(assigns) do
    item_count = length(assigns.items)
    assigns = assign(assigns, :item_count, item_count)

    ~H"""
    <div class={@class} {@rest}>
      <div class="carousel w-full">
        <%= for {src, index} <- Enum.with_index(@items) do %>
          <% id = "#{@id_prefix}#{index}" %>
          <% prev_index = rem(index - 1 + @item_count, @item_count) %>
          <% next_index = rem(index + 1, @item_count) %>
          <div id={id} class="carousel-item relative w-full">
            <img src={src} class="w-full" alt={"Slide #{index + 1}"} />
            <div class="absolute flex justify-between transform -translate-y-1/2 left-5 right-5 top-1/2">
              <a href={"##{@id_prefix}#{prev_index}"} class="btn btn-circle btn-sm opacity-70">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
                </svg>
              </a>
              <a href={"##{@id_prefix}#{next_index}"} class="btn btn-circle btn-sm opacity-70">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                </svg>
              </a>
            </div>
          </div>
        <% end %>
      </div>
      <div class="flex justify-center w-full py-2 gap-2 overflow-x-auto">
        <%= for {src, index} <- Enum.with_index(@items) do %>
          <a href={"##{@id_prefix}#{index}"} class="flex-shrink-0">
            <img src={src} class="w-16 h-12 object-cover rounded cursor-pointer hover:opacity-80" alt={"Thumbnail #{index + 1}"} />
          </a>
        <% end %>
      </div>
    </div>
    """
  end
end
