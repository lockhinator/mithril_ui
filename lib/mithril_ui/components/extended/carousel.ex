defmodule MithrilUI.Components.Carousel do
  @moduledoc """
  Carousel component for image sliders and content carousels.

  Uses Phoenix.LiveView.JS for client-side slide transitions without requiring
  server roundtrips. Supports navigation buttons, indicator dots, and various
  transition styles.

  ## Examples

  Basic carousel with navigation:

      <.carousel id="my-carousel" items={@images} />

  With indicators and custom styling:

      <.carousel
        id="hero-carousel"
        items={@slides}
        show_indicators
        show_controls
        class="rounded-xl overflow-hidden"
      />

  Manual carousel with slots:

      <.carousel_container id="custom-carousel">
        <.carousel_slide index={0} total={3}>
          <img src="/image1.jpg" class="w-full" />
        </.carousel_slide>
        <.carousel_slide index={1} total={3}>
          <img src="/image2.jpg" class="w-full" />
        </.carousel_slide>
        <.carousel_slide index={2} total={3}>
          <img src="/image3.jpg" class="w-full" />
        </.carousel_slide>
        <.carousel_controls id="custom-carousel" total={3} />
        <.carousel_indicators id="custom-carousel" total={3} />
      </.carousel_container>
  """

  use Phoenix.Component
  alias Phoenix.LiveView.JS

  @doc """
  Renders a complete carousel with images.

  This is the easiest way to create a carousel - just pass a list of image URLs.

  ## Attributes

    * `:id` - Unique ID for the carousel (required).
    * `:items` - List of image URLs (required).
    * `:show_controls` - Show prev/next buttons. Defaults to true.
    * `:show_indicators` - Show indicator dots. Defaults to true.
    * `:class` - Additional CSS classes.

  ## Examples

      <.carousel id="gallery" items={["/img1.jpg", "/img2.jpg", "/img3.jpg"]} />

      <.carousel id="hero" items={@images} show_indicators={false} />
  """
  attr :id, :string, required: true
  attr :items, :list, required: true
  attr :show_controls, :boolean, default: true
  attr :show_indicators, :boolean, default: true
  attr :class, :any, default: nil
  attr :rest, :global

  def carousel(assigns) do
    assigns = assign(assigns, :total, length(assigns.items))

    ~H"""
    <div id={@id} class={["relative w-full", @class]} data-carousel-active="0" {@rest}>
      <!-- Carousel wrapper -->
      <div class="relative h-56 overflow-hidden rounded-lg md:h-96">
        <%= for {src, index} <- Enum.with_index(@items) do %>
          <div
            id={"#{@id}-slide-#{index}"}
            class={[
              "absolute inset-0 transition-opacity duration-700 ease-in-out",
              if(index == 0, do: "opacity-100", else: "opacity-0 pointer-events-none")
            ]}
            data-carousel-item={index}
          >
            <img
              src={src}
              class="absolute block w-full h-full object-cover -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2"
              alt={"Slide #{index + 1}"}
            />
          </div>
        <% end %>
      </div>
      
    <!-- Indicators -->
      <div
        :if={@show_indicators && @total > 1}
        class="absolute z-30 flex -translate-x-1/2 bottom-5 left-1/2 space-x-3"
      >
        <%= for index <- 0..(@total - 1) do %>
          <button
            type="button"
            class={[
              "w-3 h-3 rounded-full transition-colors",
              if(index == 0, do: "bg-white", else: "bg-white/50 hover:bg-white/80")
            ]}
            aria-current={if(index == 0, do: "true", else: "false")}
            aria-label={"Slide #{index + 1}"}
            phx-click={go_to_slide(@id, index, @total)}
            data-carousel-indicator={index}
          />
        <% end %>
      </div>
      
    <!-- Controls -->
      <%= if @show_controls && @total > 1 do %>
        <button
          type="button"
          class="absolute top-0 start-0 z-30 flex items-center justify-center h-full px-4 cursor-pointer group focus:outline-none"
          phx-click={prev_slide(@id, @total)}
        >
          <span class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-white/30 group-hover:bg-white/50 group-focus:ring-4 group-focus:ring-white group-focus:outline-none">
            <svg
              class="w-4 h-4 text-white rtl:rotate-180"
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 6 10"
            >
              <path
                stroke="currentColor"
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M5 1 1 5l4 4"
              />
            </svg>
            <span class="sr-only">Previous</span>
          </span>
        </button>
        <button
          type="button"
          class="absolute top-0 end-0 z-30 flex items-center justify-center h-full px-4 cursor-pointer group focus:outline-none"
          phx-click={next_slide(@id, @total)}
        >
          <span class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-white/30 group-hover:bg-white/50 group-focus:ring-4 group-focus:ring-white group-focus:outline-none">
            <svg
              class="w-4 h-4 text-white rtl:rotate-180"
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 6 10"
            >
              <path
                stroke="currentColor"
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="m1 9 4-4-4-4"
              />
            </svg>
            <span class="sr-only">Next</span>
          </span>
        </button>
      <% end %>
    </div>
    """
  end

  @doc """
  Renders a carousel container for custom content.

  Use this with `carousel_slide`, `carousel_controls`, and `carousel_indicators`
  for full control over carousel content.

  ## Attributes

    * `:id` - Unique ID for the carousel (required).
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Carousel content (slides, controls, indicators).
  """
  attr :id, :string, required: true
  attr :class, :any, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def carousel_container(assigns) do
    ~H"""
    <div id={@id} class={["relative w-full", @class]} data-carousel-active="0" {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  @doc """
  Renders an individual carousel slide.

  ## Attributes

    * `:index` - Slide index (0-based, required).
    * `:total` - Total number of slides (required for JS transitions).
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Slide content.
  """
  attr :index, :integer, required: true
  attr :total, :integer, required: true
  attr :class, :any, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def carousel_slide(assigns) do
    ~H"""
    <div
      class={[
        "absolute inset-0 transition-opacity duration-700 ease-in-out",
        if(@index == 0, do: "opacity-100", else: "opacity-0 pointer-events-none"),
        @class
      ]}
      data-carousel-item={@index}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  @doc """
  Renders carousel navigation controls (prev/next buttons).

  ## Attributes

    * `:id` - Carousel container ID (required).
    * `:total` - Total number of slides (required).
    * `:class` - Additional CSS classes.
  """
  attr :id, :string, required: true
  attr :total, :integer, required: true
  attr :class, :any, default: nil

  def carousel_controls(assigns) do
    ~H"""
    <button
      type="button"
      class={[
        "absolute top-0 start-0 z-30 flex items-center justify-center h-full px-4 cursor-pointer group focus:outline-none",
        @class
      ]}
      phx-click={prev_slide(@id, @total)}
    >
      <span class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-white/30 group-hover:bg-white/50 group-focus:ring-4 group-focus:ring-white group-focus:outline-none">
        <svg
          class="w-4 h-4 text-white rtl:rotate-180"
          aria-hidden="true"
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 6 10"
        >
          <path
            stroke="currentColor"
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M5 1 1 5l4 4"
          />
        </svg>
        <span class="sr-only">Previous</span>
      </span>
    </button>
    <button
      type="button"
      class={[
        "absolute top-0 end-0 z-30 flex items-center justify-center h-full px-4 cursor-pointer group focus:outline-none",
        @class
      ]}
      phx-click={next_slide(@id, @total)}
    >
      <span class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-white/30 group-hover:bg-white/50 group-focus:ring-4 group-focus:ring-white group-focus:outline-none">
        <svg
          class="w-4 h-4 text-white rtl:rotate-180"
          aria-hidden="true"
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 6 10"
        >
          <path
            stroke="currentColor"
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="m1 9 4-4-4-4"
          />
        </svg>
        <span class="sr-only">Next</span>
      </span>
    </button>
    """
  end

  @doc """
  Renders carousel indicator dots.

  ## Attributes

    * `:id` - Carousel container ID (required).
    * `:total` - Total number of slides (required).
    * `:class` - Additional CSS classes.
  """
  attr :id, :string, required: true
  attr :total, :integer, required: true
  attr :class, :any, default: nil

  def carousel_indicators(assigns) do
    ~H"""
    <div class={["absolute z-30 flex -translate-x-1/2 bottom-5 left-1/2 space-x-3", @class]}>
      <%= for index <- 0..(@total - 1) do %>
        <button
          type="button"
          class={[
            "w-3 h-3 rounded-full transition-colors",
            if(index == 0, do: "bg-white", else: "bg-white/50 hover:bg-white/80")
          ]}
          aria-current={if(index == 0, do: "true", else: "false")}
          aria-label={"Slide #{index + 1}"}
          phx-click={go_to_slide(@id, index, @total)}
          data-carousel-indicator={index}
        />
      <% end %>
    </div>
    """
  end

  # JS Commands for carousel navigation

  defp go_to_slide(carousel_id, target_index, total) do
    # Hide all slides and update indicators
    js =
      Enum.reduce(0..(total - 1), %JS{}, fn index, acc ->
        slide_id = "#{carousel_id}-slide-#{index}"

        acc
        |> JS.remove_class("opacity-100",
          to: "##{slide_id}"
        )
        |> JS.add_class("opacity-0 pointer-events-none",
          to: "##{slide_id}"
        )
        |> JS.remove_class("bg-white",
          to: "##{carousel_id} [data-carousel-indicator='#{index}']"
        )
        |> JS.add_class("bg-white/50",
          to: "##{carousel_id} [data-carousel-indicator='#{index}']"
        )
        |> JS.set_attribute({"aria-current", "false"},
          to: "##{carousel_id} [data-carousel-indicator='#{index}']"
        )
      end)

    # Show target slide and update its indicator
    target_slide_id = "#{carousel_id}-slide-#{target_index}"

    js
    |> JS.remove_class("opacity-0 pointer-events-none",
      to: "##{target_slide_id}"
    )
    |> JS.add_class("opacity-100",
      to: "##{target_slide_id}"
    )
    |> JS.remove_class("bg-white/50",
      to: "##{carousel_id} [data-carousel-indicator='#{target_index}']"
    )
    |> JS.add_class("bg-white",
      to: "##{carousel_id} [data-carousel-indicator='#{target_index}']"
    )
    |> JS.set_attribute({"aria-current", "true"},
      to: "##{carousel_id} [data-carousel-indicator='#{target_index}']"
    )
    |> JS.set_attribute({"data-carousel-active", to_string(target_index)},
      to: "##{carousel_id}"
    )
  end

  defp next_slide(carousel_id, total) do
    # We use JS.dispatch to trigger a custom event that reads current state
    # and calculates next slide. This is handled by a small inline script.
    %JS{}
    |> JS.dispatch("carousel:next", to: "##{carousel_id}", detail: %{total: total})
  end

  defp prev_slide(carousel_id, total) do
    %JS{}
    |> JS.dispatch("carousel:prev", to: "##{carousel_id}", detail: %{total: total})
  end

  @doc """
  Returns the JavaScript code needed for carousel navigation.

  Add this to your app.js or include it in a script tag:

      <script>{MithrilUI.Components.Carousel.carousel_js()}</script>

  Or in app.js:

      // Carousel navigation
      document.addEventListener("carousel:next", (e) => { ... })
  """
  def carousel_js do
    """
    // MithrilUI Carousel Navigation
    document.addEventListener("carousel:next", (e) => {
      const carousel = e.target;
      const total = e.detail.total;
      const current = parseInt(carousel.dataset.carouselActive || "0");
      const next = (current + 1) % total;
      window.carouselGoTo(carousel, next, total);
    });

    document.addEventListener("carousel:prev", (e) => {
      const carousel = e.target;
      const total = e.detail.total;
      const current = parseInt(carousel.dataset.carouselActive || "0");
      const prev = (current - 1 + total) % total;
      window.carouselGoTo(carousel, prev, total);
    });

    window.carouselGoTo = function(carousel, targetIndex, total) {
      const carouselId = carousel.id;

      // Hide all slides
      for (let i = 0; i < total; i++) {
        const slide = document.getElementById(`${carouselId}-slide-${i}`);
        const indicator = carousel.querySelector(`[data-carousel-indicator="${i}"]`);

        if (slide) {
          slide.classList.remove("opacity-100");
          slide.classList.add("opacity-0", "pointer-events-none");
        }
        if (indicator) {
          indicator.classList.remove("bg-white");
          indicator.classList.add("bg-white/50");
          indicator.setAttribute("aria-current", "false");
        }
      }

      // Show target slide
      const targetSlide = document.getElementById(`${carouselId}-slide-${targetIndex}`);
      const targetIndicator = carousel.querySelector(`[data-carousel-indicator="${targetIndex}"]`);

      if (targetSlide) {
        targetSlide.classList.remove("opacity-0", "pointer-events-none");
        targetSlide.classList.add("opacity-100");
      }
      if (targetIndicator) {
        targetIndicator.classList.remove("bg-white/50");
        targetIndicator.classList.add("bg-white");
        targetIndicator.setAttribute("aria-current", "true");
      }

      carousel.dataset.carouselActive = targetIndex.toString();
    };
    """
  end
end
