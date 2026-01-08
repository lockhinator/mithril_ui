defmodule MithrilUI.Components.Avatar do
  @moduledoc """
  Avatar component for displaying user profile images or placeholders.

  ## Examples

  Basic avatar:

      <.avatar src="/user.jpg" alt="John Doe" />

  With placeholder:

      <.avatar placeholder="JD" />

  Avatar group:

      <.avatar_group>
        <.avatar src="/user1.jpg" />
        <.avatar src="/user2.jpg" />
        <.avatar placeholder="+5" />
      </.avatar_group>

  ## DaisyUI Classes

  - `avatar` - Base avatar styling
  - `avatar-group` - Group multiple avatars
  - `placeholder` - Placeholder styling
  - `online` / `offline` - Status indicators
  """

  use Phoenix.Component

  @sizes ~w(xs sm md lg xl)

  @doc """
  Renders an avatar.

  ## Attributes

    * `:src` - Image source URL.
    * `:alt` - Alt text for image.
    * `:placeholder` - Text to show when no image (initials).
    * `:size` - Avatar size: xs, sm, md, lg, xl. Defaults to "md".
    * `:shape` - Shape: circle, square, rounded. Defaults to "circle".
    * `:status` - Online status: online, offline, nil. Defaults to nil.
    * `:ring` - Show ring around avatar. Defaults to false.
    * `:ring_color` - Ring color variant. Defaults to "primary".
    * `:class` - Additional CSS classes.

  ## Examples

      <.avatar src="/avatar.jpg" size="lg" status="online" />

      <.avatar placeholder="AB" size="sm" ring />
  """
  @spec avatar(map()) :: Phoenix.LiveView.Rendered.t()

  attr :src, :string, default: nil
  attr :alt, :string, default: ""
  attr :placeholder, :string, default: nil
  attr :size, :string, default: "md", values: @sizes
  attr :shape, :string, default: "circle", values: ~w(circle square rounded)
  attr :status, :string, default: nil, values: [nil, "online", "offline"]
  attr :ring, :boolean, default: false
  attr :ring_color, :string, default: "primary"
  attr :class, :string, default: nil

  def avatar(assigns) do
    ~H"""
    <div class={avatar_classes(@status, @class)}>
      <div class={inner_classes(@size, @shape, @ring, @ring_color, @placeholder)}>
        <img :if={@src} src={@src} alt={@alt} />
        <span :if={!@src && @placeholder}><%= @placeholder %></span>
      </div>
    </div>
    """
  end

  @doc """
  Renders a group of overlapping avatars.

  ## Attributes

    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Avatar components to group.

  ## Examples

      <.avatar_group>
        <.avatar src="/user1.jpg" />
        <.avatar src="/user2.jpg" />
        <.avatar src="/user3.jpg" />
        <.avatar placeholder="+99" />
      </.avatar_group>
  """
  @spec avatar_group(map()) :: Phoenix.LiveView.Rendered.t()

  attr :class, :string, default: nil

  slot :inner_block, required: true

  def avatar_group(assigns) do
    ~H"""
    <div class={["avatar-group -space-x-6 rtl:space-x-reverse", @class]}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  defp avatar_classes(status, extra_class) do
    [
      "avatar",
      status && status,
      !status && extra_class && "placeholder",
      extra_class
    ]
  end

  defp inner_classes(size, shape, ring, ring_color, placeholder) do
    [
      size_class(size),
      shape_class(shape),
      ring && "ring ring-#{ring_color} ring-offset-base-100 ring-offset-2",
      placeholder && !ring && "bg-neutral text-neutral-content"
    ]
  end

  defp size_class("xs"), do: "w-8"
  defp size_class("sm"), do: "w-12"
  defp size_class("md"), do: "w-16"
  defp size_class("lg"), do: "w-20"
  defp size_class("xl"), do: "w-24"

  defp shape_class("circle"), do: "rounded-full"
  defp shape_class("square"), do: "rounded-none"
  defp shape_class("rounded"), do: "rounded-xl"
end
