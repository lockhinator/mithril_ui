defmodule MithrilUI.Components.Card do
  @moduledoc """
  Card component for displaying content in a contained, styled box.

  Cards are versatile containers for grouping related content and actions.

  ## Examples

  Basic card:

      <.card>
        <:body>Card content here</:body>
      </.card>

  Card with all slots:

      <.card>
        <:figure>
          <img src="/image.jpg" alt="Cover" />
        </:figure>
        <:body>
          <:title>Card Title</:title>
          <p>Card description and content.</p>
          <:actions>
            <button class="btn btn-primary">Action</button>
          </:actions>
        </:body>
      </.card>

  ## DaisyUI Classes

  - `card` - Base card styling
  - `card-body` - Content padding
  - `card-title` - Title styling
  - `card-actions` - Action button container
  - `card-bordered` - Add border
  - `card-compact` - Reduced padding
  - `image-full` - Full-width image
  """

  use Phoenix.Component

  @doc """
  Renders a card container.

  ## Attributes

    * `:bordered` - Add border styling. Defaults to false.
    * `:compact` - Use compact padding. Defaults to false.
    * `:image_full` - Make image span full width with overlay. Defaults to false.
    * `:horizontal` - Horizontal card layout. Defaults to false.
    * `:glass` - Glass morphism effect. Defaults to false.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:figure` - Image or media content.
    * `:body` - Main card content (required).
    * `:title` - Card title (inside body).
    * `:actions` - Action buttons (inside body).

  ## Examples

      <.card bordered>
        <:body>
          <:title>My Card</:title>
          <p>Some content here.</p>
        </:body>
      </.card>
  """
  @spec card(map()) :: Phoenix.LiveView.Rendered.t()

  attr :bordered, :boolean, default: false
  attr :compact, :boolean, default: false
  attr :image_full, :boolean, default: false
  attr :horizontal, :boolean, default: false
  attr :glass, :boolean, default: false
  attr :class, :string, default: nil

  slot :figure
  slot :body, required: true
  slot :title
  slot :actions

  def card(assigns) do
    ~H"""
    <div class={card_classes(@bordered, @compact, @image_full, @horizontal, @glass, @class)}>
      <figure :if={@figure != []}>
        {render_slot(@figure)}
      </figure>
      <div class="card-body">
        <h2 :if={@title != []} class="card-title">
          {render_slot(@title)}
        </h2>
        {render_slot(@body)}
        <div :if={@actions != []} class="card-actions justify-end">
          {render_slot(@actions)}
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Renders a simple card without slots for quick usage.

  ## Attributes

    * `:title` - Card title text.
    * `:description` - Card description text.
    * `:image` - Image URL for figure.
    * `:image_alt` - Alt text for image.

  ## Examples

      <.simple_card
        title="Product Name"
        description="Product description here"
        image="/product.jpg"
      />
  """
  @spec simple_card(map()) :: Phoenix.LiveView.Rendered.t()

  attr :title, :string, default: nil
  attr :description, :string, default: nil
  attr :image, :string, default: nil
  attr :image_alt, :string, default: ""
  attr :bordered, :boolean, default: false
  attr :compact, :boolean, default: false
  attr :class, :string, default: nil

  slot :inner_block
  slot :actions

  def simple_card(assigns) do
    ~H"""
    <div class={card_classes(@bordered, @compact, false, false, false, @class)}>
      <figure :if={@image}>
        <img src={@image} alt={@image_alt} />
      </figure>
      <div class="card-body">
        <h2 :if={@title} class="card-title">{@title}</h2>
        <p :if={@description}>{@description}</p>
        {render_slot(@inner_block)}
        <div :if={@actions != []} class="card-actions justify-end">
          {render_slot(@actions)}
        </div>
      </div>
    </div>
    """
  end

  defp card_classes(bordered, compact, image_full, horizontal, glass, extra_class) do
    [
      "card bg-base-100 shadow-xl",
      bordered && "card-bordered",
      compact && "card-compact",
      image_full && "image-full",
      horizontal && "card-side",
      glass && "glass",
      extra_class
    ]
  end
end
