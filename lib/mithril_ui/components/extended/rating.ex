defmodule MithrilUI.Components.Rating do
  @moduledoc """
  Rating component for displaying and collecting star ratings.

  ## Examples

  Basic rating:

      <.rating name="product-rating" value={4} />

  Read-only rating:

      <.rating name="display-rating" value={4} readonly />

  Half-star rating:

      <.rating name="half-rating" value={3.5} half />

  ## DaisyUI Classes

  - `rating` - Base rating styling
  - `rating-{size}` - Size variants (xs, sm, md, lg, xl)
  - `rating-half` - Enable half-star ratings
  - `rating-hidden` - Hide the clearing option
  - `mask mask-star` - Star shape
  - `mask mask-star-2` - Alternative star shape
  - `mask mask-heart` - Heart shape
  """

  use Phoenix.Component

  @sizes ~w(xs sm md lg xl)
  @shapes ~w(star star-2 heart)

  @doc """
  Renders an interactive star rating input.

  ## Attributes

    * `:name` - Input name for form submission (required).
    * `:value` - Current rating value. Defaults to 0.
    * `:max` - Maximum rating value. Defaults to 5.
    * `:size` - Rating size: xs, sm, md, lg, xl.
    * `:shape` - Icon shape: star, star-2, heart. Defaults to "star".
    * `:color` - Background color class for active stars. Defaults to "bg-yellow-400".
    * `:readonly` - Disable user interaction. Defaults to false.
    * `:half` - Enable half-star ratings. Defaults to false.
    * `:clearable` - Allow clearing the rating. Defaults to true.
    * `:class` - Additional CSS classes.

  ## Examples

      <.rating name="rating-1" value={3} />

      <.rating name="rating-2" value={4} size="lg" color="bg-orange-400" />

      <.rating name="rating-3" value={2.5} half />
  """
  @spec rating(map()) :: Phoenix.LiveView.Rendered.t()

  attr :name, :string, required: true
  attr :value, :float, default: 0.0
  attr :max, :integer, default: 5
  attr :size, :string, default: nil, values: @sizes ++ [nil]
  attr :shape, :string, default: "star", values: @shapes
  attr :color, :string, default: "bg-yellow-400"
  attr :readonly, :boolean, default: false
  attr :half, :boolean, default: false
  attr :clearable, :boolean, default: true
  attr :class, :string, default: nil
  attr :rest, :global

  def rating(assigns) do
    ~H"""
    <div
      class={[
        "rating",
        @size && "rating-#{@size}",
        @half && "rating-half",
        @class
      ]}
      {@rest}
    >
      <%= if @clearable && !@readonly do %>
        <input
          type="radio"
          name={@name}
          class="rating-hidden"
          checked={@value == 0}
          value="0"
        />
      <% end %>
      <%= if @half do %>
        <%= for i <- 1..@max do %>
          <input
            type="radio"
            name={@name}
            class={["mask", "mask-#{@shape}", "mask-half-1", @color]}
            aria-label={"#{i - 0.5} stars"}
            checked={@value == i - 0.5}
            value={i - 0.5}
            disabled={@readonly}
          />
          <input
            type="radio"
            name={@name}
            class={["mask", "mask-#{@shape}", "mask-half-2", @color]}
            aria-label={"#{i} stars"}
            checked={@value == i}
            value={i}
            disabled={@readonly}
          />
        <% end %>
      <% else %>
        <%= for i <- 1..@max do %>
          <input
            type="radio"
            name={@name}
            class={["mask", "mask-#{@shape}", @color]}
            aria-label={"#{i} stars"}
            checked={@value == i}
            value={i}
            disabled={@readonly}
          />
        <% end %>
      <% end %>
    </div>
    """
  end

  @doc """
  Renders a read-only rating display using divs instead of inputs.

  ## Attributes

    * `:value` - Rating value to display (required).
    * `:max` - Maximum rating value. Defaults to 5.
    * `:size` - Rating size: xs, sm, md, lg, xl.
    * `:shape` - Icon shape: star, star-2, heart. Defaults to "star".
    * `:color` - Background color class for filled stars.
    * `:empty_color` - Background color class for empty stars.
    * `:class` - Additional CSS classes.

  ## Examples

      <.rating_display value={4.5} />

      <.rating_display value={3} color="bg-orange-400" empty_color="bg-gray-300" />
  """
  @spec rating_display(map()) :: Phoenix.LiveView.Rendered.t()

  attr :value, :float, required: true
  attr :max, :integer, default: 5
  attr :size, :string, default: nil, values: @sizes ++ [nil]
  attr :shape, :string, default: "star", values: @shapes
  attr :color, :string, default: "bg-yellow-400"
  attr :empty_color, :string, default: "bg-gray-300"
  attr :class, :string, default: nil
  attr :rest, :global

  def rating_display(assigns) do
    ~H"""
    <div
      class={[
        "rating",
        @size && "rating-#{@size}",
        @class
      ]}
      aria-label={"Rating: #{@value} out of #{@max}"}
      {@rest}
    >
      <%= for i <- 1..@max do %>
        <div
          class={[
            "mask",
            "mask-#{@shape}",
            if(i <= @value, do: @color, else: @empty_color)
          ]}
          aria-current={i <= round(@value) && "true"}
        />
      <% end %>
    </div>
    """
  end

  @doc """
  Renders a rating with adjacent text showing the numeric value.

  ## Attributes

    * `:value` - Rating value (required).
    * `:max` - Maximum rating value. Defaults to 5.
    * `:size` - Rating size.
    * `:show_max` - Show "X out of Y" format. Defaults to false.
    * `:class` - Additional CSS classes.

  ## Examples

      <.rating_with_text value={4.5} />

      <.rating_with_text value={4} show_max />
  """
  @spec rating_with_text(map()) :: Phoenix.LiveView.Rendered.t()

  attr :value, :float, required: true
  attr :max, :integer, default: 5
  attr :size, :string, default: nil, values: @sizes ++ [nil]
  attr :shape, :string, default: "star", values: @shapes
  attr :color, :string, default: "bg-yellow-400"
  attr :show_max, :boolean, default: false
  attr :class, :string, default: nil
  attr :rest, :global

  def rating_with_text(assigns) do
    ~H"""
    <div class={["flex items-center gap-2", @class]} {@rest}>
      <.rating_display value={@value} max={@max} size={@size} shape={@shape} color={@color} />
      <span class="text-sm font-medium">
        <%= if @show_max do %>
          {@value} out of {@max}
        <% else %>
          {@value}
        <% end %>
      </span>
    </div>
    """
  end

  @doc """
  Renders an advanced rating breakdown with progress bars.

  ## Attributes

    * `:ratings` - Map of star ratings to counts (required).
      Example: %{5 => 70, 4 => 20, 3 => 5, 2 => 3, 1 => 2}
    * `:total` - Total number of reviews. If nil, calculated from ratings.
    * `:class` - Additional CSS classes.

  ## Examples

      <.rating_breakdown ratings={%{5 => 70, 4 => 20, 3 => 5, 2 => 3, 1 => 2}} />
  """
  @spec rating_breakdown(map()) :: Phoenix.LiveView.Rendered.t()

  attr :ratings, :map, required: true
  attr :total, :integer, default: nil
  attr :class, :string, default: nil
  attr :rest, :global

  def rating_breakdown(assigns) do
    total = assigns.total || Enum.reduce(assigns.ratings, 0, fn {_k, v}, acc -> acc + v end)
    assigns = assign(assigns, :calculated_total, total)

    ~H"""
    <div class={["space-y-2", @class]} {@rest}>
      <%= for stars <- 5..1//-1 do %>
        <% count = Map.get(@ratings, stars, 0) %>
        <% percentage = if @calculated_total > 0, do: count / @calculated_total * 100, else: 0 %>
        <div class="flex items-center gap-2">
          <span class="text-sm font-medium w-8">{stars} star</span>
          <div class="flex-1 h-2 bg-base-300 rounded-full overflow-hidden">
            <div
              class="h-full bg-yellow-400 rounded-full transition-all"
              style={"width: #{percentage}%"}
            />
          </div>
          <span class="text-sm text-base-content/70 w-12 text-right">{count}</span>
        </div>
      <% end %>
    </div>
    """
  end
end
