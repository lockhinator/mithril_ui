defmodule MithrilUI.Components.Skeleton do
  @moduledoc """
  Skeleton loading placeholder component for content that is loading.

  Skeletons provide a visual placeholder that mimics the shape of content
  while it's being loaded, improving perceived performance.

  ## Examples

  Basic skeleton:

      <.skeleton class="h-4 w-full" />

  Text skeleton:

      <.skeleton_text lines={3} />

  Card skeleton:

      <.skeleton_card />

  Avatar skeleton:

      <.skeleton_avatar size="lg" />

  ## DaisyUI Classes

  - `skeleton` - Base skeleton with animation
  """

  use Phoenix.Component

  @doc """
  Renders a basic skeleton placeholder.

  ## Attributes

    * `:class` - CSS classes to define shape and size (required for dimensions).
    * `:rounded` - Border radius style. Defaults to "md".

  ## Examples

      <.skeleton class="h-4 w-32" />

      <.skeleton class="h-32 w-full" rounded="lg" />

      <.skeleton class="h-12 w-12" rounded="full" />
  """
  @spec skeleton(map()) :: Phoenix.LiveView.Rendered.t()

  attr :class, :any, default: nil
  attr :rounded, :string, default: "md", values: ~w(none sm md lg full)

  def skeleton(assigns) do
    ~H"""
    <div class={skeleton_classes(@rounded, @class)} aria-hidden="true" />
    """
  end

  @doc """
  Renders skeleton lines mimicking text content.

  ## Attributes

    * `:lines` - Number of text lines. Defaults to 3.
    * `:class` - Additional CSS classes for the container.

  ## Examples

      <.skeleton_text />

      <.skeleton_text lines={5} />
  """
  @spec skeleton_text(map()) :: Phoenix.LiveView.Rendered.t()

  attr :lines, :integer, default: 3
  attr :class, :any, default: nil

  def skeleton_text(assigns) do
    ~H"""
    <div class={["space-y-2", @class]} aria-hidden="true">
      <div :for={i <- 1..@lines} class={text_line_classes(i, @lines)} />
    </div>
    """
  end

  @doc """
  Renders a skeleton placeholder for avatars.

  ## Attributes

    * `:size` - Avatar size: xs, sm, md, lg, xl. Defaults to "md".
    * `:shape` - Shape: circle, square. Defaults to "circle".
    * `:class` - Additional CSS classes.

  ## Examples

      <.skeleton_avatar />

      <.skeleton_avatar size="lg" shape="square" />
  """
  @spec skeleton_avatar(map()) :: Phoenix.LiveView.Rendered.t()

  attr :size, :string, default: "md", values: ~w(xs sm md lg xl)
  attr :shape, :string, default: "circle", values: ~w(circle square)
  attr :class, :any, default: nil

  def skeleton_avatar(assigns) do
    ~H"""
    <div
      class={avatar_classes(@size, @shape, @class)}
      aria-hidden="true"
    />
    """
  end

  @doc """
  Renders a skeleton card placeholder.

  ## Attributes

    * `:with_image` - Whether to include image placeholder. Defaults to true.
    * `:lines` - Number of text lines. Defaults to 3.
    * `:class` - Additional CSS classes.

  ## Examples

      <.skeleton_card />

      <.skeleton_card with_image={false} lines={2} />
  """
  @spec skeleton_card(map()) :: Phoenix.LiveView.Rendered.t()

  attr :with_image, :boolean, default: true
  attr :lines, :integer, default: 3
  attr :class, :any, default: nil

  def skeleton_card(assigns) do
    ~H"""
    <div class={["card bg-base-200 shadow", @class]} aria-hidden="true">
      <figure :if={@with_image} class="skeleton h-48 w-full rounded-t-box rounded-b-none" />
      <div class="card-body">
        <div class="skeleton h-6 w-3/4" />
        <div class="space-y-2 mt-2">
          <div :for={i <- 1..@lines} class={text_line_classes(i, @lines)} />
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Renders a skeleton table placeholder.

  ## Attributes

    * `:rows` - Number of table rows. Defaults to 5.
    * `:columns` - Number of columns. Defaults to 4.
    * `:class` - Additional CSS classes.

  ## Examples

      <.skeleton_table />

      <.skeleton_table rows={10} columns={3} />
  """
  @spec skeleton_table(map()) :: Phoenix.LiveView.Rendered.t()

  attr :rows, :integer, default: 5
  attr :columns, :integer, default: 4
  attr :class, :any, default: nil

  def skeleton_table(assigns) do
    ~H"""
    <div class={["overflow-x-auto", @class]} aria-hidden="true">
      <table class="table">
        <thead>
          <tr>
            <th :for={_ <- 1..@columns}>
              <div class="skeleton h-4 w-20" />
            </th>
          </tr>
        </thead>
        <tbody>
          <tr :for={_ <- 1..@rows}>
            <td :for={_ <- 1..@columns}>
              <div class="skeleton h-4 w-full" />
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    """
  end

  @doc """
  Renders a skeleton list placeholder.

  ## Attributes

    * `:items` - Number of list items. Defaults to 5.
    * `:with_avatar` - Include avatar placeholder. Defaults to false.
    * `:class` - Additional CSS classes.

  ## Examples

      <.skeleton_list />

      <.skeleton_list items={3} with_avatar />
  """
  @spec skeleton_list(map()) :: Phoenix.LiveView.Rendered.t()

  attr :items, :integer, default: 5
  attr :with_avatar, :boolean, default: false
  attr :class, :any, default: nil

  def skeleton_list(assigns) do
    ~H"""
    <ul class={["space-y-4", @class]} aria-hidden="true">
      <li :for={_ <- 1..@items} class="flex items-center gap-4">
        <div :if={@with_avatar} class="skeleton h-10 w-10 rounded-full shrink-0" />
        <div class="flex-1 space-y-2">
          <div class="skeleton h-4 w-3/4" />
          <div class="skeleton h-3 w-1/2" />
        </div>
      </li>
    </ul>
    """
  end

  defp skeleton_classes(rounded, extra_class) do
    [
      "skeleton",
      rounded_class(rounded),
      extra_class
    ]
  end

  defp rounded_class("none"), do: "rounded-none"
  defp rounded_class("sm"), do: "rounded-sm"
  defp rounded_class("md"), do: "rounded-md"
  defp rounded_class("lg"), do: "rounded-lg"
  defp rounded_class("full"), do: "rounded-full"

  defp text_line_classes(index, total) when index == total do
    "skeleton h-3 w-2/3"
  end

  defp text_line_classes(_index, _total) do
    "skeleton h-3 w-full"
  end

  defp avatar_classes(size, shape, extra_class) do
    [
      "skeleton shrink-0",
      avatar_size(size),
      shape == "circle" && "rounded-full",
      shape == "square" && "rounded-lg",
      extra_class
    ]
  end

  defp avatar_size("xs"), do: "h-6 w-6"
  defp avatar_size("sm"), do: "h-8 w-8"
  defp avatar_size("md"), do: "h-10 w-10"
  defp avatar_size("lg"), do: "h-12 w-12"
  defp avatar_size("xl"), do: "h-16 w-16"
end
