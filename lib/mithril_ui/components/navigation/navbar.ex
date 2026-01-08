defmodule MithrilUI.Components.Navbar do
  @moduledoc """
  A responsive navigation bar component with flexible sections.

  The navbar provides a top navigation area with three sections: start (left),
  center, and end (right). Each section fills available space and can contain
  any content including buttons, menus, dropdowns, and search inputs.

  ## Examples

  Basic navbar with brand and links:

      <.navbar>
        <:start_section>
          <a class="btn btn-ghost text-xl">Brand</a>
        </:start_section>
        <:center_section>
          <ul class="menu menu-horizontal px-1">
            <li><a>Home</a></li>
            <li><a>About</a></li>
          </ul>
        </:center_section>
        <:end_section>
          <button class="btn btn-primary">Login</button>
        </:end_section>
      </.navbar>

  With dropdown menu:

      <.navbar>
        <:start_section>
          <.navbar_dropdown>
            <:trigger>
              <button class="btn btn-ghost lg:hidden">Menu</button>
            </:trigger>
            <:content>
              <li><a>Home</a></li>
              <li><a>About</a></li>
            </:content>
          </.navbar_dropdown>
          <a class="btn btn-ghost text-xl">Brand</a>
        </:start_section>
      </.navbar>

  ## DaisyUI Classes

  The component uses the following DaisyUI classes:
  - `navbar` - Base container
  - `navbar-start` - Left section (50% width)
  - `navbar-center` - Center section
  - `navbar-end` - Right section (50% width)
  """

  use Phoenix.Component

  @doc """
  Renders a responsive navigation bar.

  ## Attributes

    * `:class` - Additional CSS classes for the navbar container.
    * `:sticky` - Whether navbar is sticky/fixed at top. Defaults to false.
    * `:shadow` - Whether to show shadow. Defaults to true.
    * `:bordered` - Whether to show bottom border. Defaults to false.
    * `:transparent` - Whether background is transparent. Defaults to false.

  ## Slots

    * `:start_section` - Left section content.
    * `:center_section` - Center section content.
    * `:end_section` - Right section content.

  ## Examples

      <.navbar sticky>
        <:start_section>
          <a class="btn btn-ghost text-xl">Logo</a>
        </:start_section>
        <:end_section>
          <button class="btn">Action</button>
        </:end_section>
      </.navbar>
  """
  @spec navbar(map()) :: Phoenix.LiveView.Rendered.t()

  attr :class, :any, default: nil
  attr :sticky, :boolean, default: false
  attr :shadow, :boolean, default: true
  attr :bordered, :boolean, default: false
  attr :transparent, :boolean, default: false

  attr :rest, :global

  slot :start_section
  slot :center_section
  slot :end_section

  def navbar(assigns) do
    ~H"""
    <div
      class={navbar_classes(@sticky, @shadow, @bordered, @transparent, @class)}
      {@rest}
    >
      <div :if={@start_section != []} class="navbar-start">
        {render_slot(@start_section)}
      </div>
      <div :if={@center_section != []} class="navbar-center">
        {render_slot(@center_section)}
      </div>
      <div :if={@end_section != []} class="navbar-end">
        {render_slot(@end_section)}
      </div>
    </div>
    """
  end

  @doc """
  Renders a dropdown menu typically used in navbar for mobile navigation.

  ## Attributes

    * `:class` - Additional CSS classes for the dropdown container.

  ## Slots

    * `:trigger` - The element that triggers the dropdown (required).
    * `:content` - Menu items to show in dropdown (required).

  ## Examples

      <.navbar_dropdown>
        <:trigger>
          <button class="btn btn-ghost btn-circle">
            <svg>...</svg>
          </button>
        </:trigger>
        <:content>
          <li><a>Home</a></li>
          <li><a>About</a></li>
          <li><a>Contact</a></li>
        </:content>
      </.navbar_dropdown>
  """
  @spec navbar_dropdown(map()) :: Phoenix.LiveView.Rendered.t()

  attr :class, :any, default: nil

  slot :trigger, required: true
  slot :content, required: true

  def navbar_dropdown(assigns) do
    ~H"""
    <div class={["dropdown", @class]}>
      <div tabindex="0" role="button">
        {render_slot(@trigger)}
      </div>
      <ul
        tabindex="0"
        class="menu menu-sm dropdown-content bg-base-100 rounded-box z-10 mt-3 w-52 p-2 shadow"
      >
        {render_slot(@content)}
      </ul>
    </div>
    """
  end

  @doc """
  Renders a simple navbar with just a title/brand.

  ## Attributes

    * `:title` - The brand/title text to display (required).
    * `:href` - Link destination for the title. Defaults to "/".
    * `:class` - Additional CSS classes.

  ## Examples

      <.simple_navbar title="My App" />
      <.simple_navbar title="Brand" href="/home" />
  """
  @spec simple_navbar(map()) :: Phoenix.LiveView.Rendered.t()

  attr :title, :string, required: true
  attr :href, :string, default: "/"
  attr :class, :any, default: nil

  attr :rest, :global

  def simple_navbar(assigns) do
    ~H"""
    <div class={["navbar bg-base-100 shadow-sm", @class]} {@rest}>
      <div class="flex-1">
        <a href={@href} class="btn btn-ghost text-xl">{@title}</a>
      </div>
    </div>
    """
  end

  defp navbar_classes(sticky, shadow, bordered, transparent, extra_class) do
    [
      "navbar",
      !transparent && "bg-base-100",
      sticky && "sticky top-0 z-50",
      shadow && "shadow-sm",
      bordered && "border-b border-base-200",
      extra_class
    ]
  end
end
