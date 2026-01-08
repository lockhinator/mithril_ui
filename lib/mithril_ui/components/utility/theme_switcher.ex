defmodule MithrilUI.Components.ThemeSwitcher do
  @moduledoc """
  Theme switcher component for DaisyUI theme selection.

  Provides dropdown and button-based theme switching using the `data-theme`
  attribute. Works with the theme-change JavaScript library for persistence.

  ## Available Themes

  DaisyUI provides 35+ built-in themes including:
  - Light/Dark: light, dark
  - Aesthetic: cupcake, bumblebee, emerald, synthwave, retro, cyberpunk, valentine, etc.
  - Specialized: corporate, business, luxury, dracula, nord, sunset, etc.
  """
  use Phoenix.Component

  @default_themes [
    "light",
    "dark",
    "cupcake",
    "bumblebee",
    "emerald",
    "corporate",
    "synthwave",
    "retro",
    "cyberpunk",
    "valentine",
    "halloween",
    "garden",
    "forest",
    "aqua",
    "lofi",
    "pastel",
    "fantasy",
    "wireframe",
    "black",
    "luxury",
    "dracula",
    "autumn",
    "business",
    "acid",
    "lemonade",
    "night",
    "coffee",
    "winter",
    "dim",
    "nord",
    "sunset"
  ]

  @doc """
  Renders a theme switcher dropdown.

  ## Examples

      <.theme_switcher />
      <.theme_switcher themes={["light", "dark", "cupcake"]} />
      <.theme_switcher label="Theme" />
  """
  attr :id, :string, default: "theme-switcher"
  attr :themes, :list, default: nil, doc: "List of theme names to show. Defaults to all DaisyUI themes."
  attr :label, :string, default: nil, doc: "Optional label text"
  attr :class, :string, default: nil
  attr :rest, :global

  def theme_switcher(assigns) do
    assigns = assign_new(assigns, :theme_list, fn -> assigns[:themes] || @default_themes end)

    ~H"""
    <div class={["dropdown dropdown-end", @class]} {@rest}>
      <div tabindex="0" role="button" class="btn btn-ghost gap-2">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          stroke-width="1.5"
          stroke="currentColor"
          class="w-5 h-5"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M4.098 19.902a3.75 3.75 0 005.304 0l6.401-6.402M6.75 21A3.75 3.75 0 013 17.25V4.125C3 3.504 3.504 3 4.125 3h5.25c.621 0 1.125.504 1.125 1.125v4.072M6.75 21a3.75 3.75 0 003.75-3.75V8.197M6.75 21h13.125c.621 0 1.125-.504 1.125-1.125v-5.25c0-.621-.504-1.125-1.125-1.125h-4.072M10.5 8.197l2.88-2.88c.438-.439 1.15-.439 1.59 0l3.712 3.713c.44.44.44 1.152 0 1.59l-2.879 2.88M6.75 17.25h.008v.008H6.75v-.008z"
          />
        </svg>
        <span :if={@label}>{@label}</span>
        <svg class="w-2 h-2 opacity-60" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
          <path stroke="currentColor" stroke-width="3" d="M6 9l6 6 6-6" />
        </svg>
      </div>
      <ul
        tabindex="0"
        class="dropdown-content menu bg-base-200 rounded-box z-50 w-52 p-2 shadow-2xl max-h-96 overflow-y-auto"
      >
        <li :for={theme <- @theme_list}>
          <button
            type="button"
            class="justify-start"
            data-set-theme={theme}
            data-act-class="ACTIVECLASS"
          >
            <span class="badge badge-sm badge-outline mr-2 capitalize font-normal gap-1">
              <span
                class="w-2 h-2 rounded-full"
                data-theme={theme}
                style="background-color: oklch(var(--p))"
              >
              </span>
              <span
                class="w-2 h-2 rounded-full"
                data-theme={theme}
                style="background-color: oklch(var(--s))"
              >
              </span>
              <span
                class="w-2 h-2 rounded-full"
                data-theme={theme}
                style="background-color: oklch(var(--a))"
              >
              </span>
            </span>
            {theme}
          </button>
        </li>
      </ul>
    </div>
    """
  end

  @doc """
  Renders a simple light/dark mode toggle button.

  ## Examples

      <.theme_toggle />
      <.theme_toggle light_theme="corporate" dark_theme="business" />
  """
  attr :id, :string, default: "theme-toggle"
  attr :light_theme, :string, default: "light", doc: "Theme name for light mode"
  attr :dark_theme, :string, default: "dark", doc: "Theme name for dark mode"
  attr :class, :string, default: nil
  attr :rest, :global

  def theme_toggle(assigns) do
    ~H"""
    <label class={["swap swap-rotate btn btn-ghost btn-circle", @class]} {@rest}>
      <input
        type="checkbox"
        class="theme-controller"
        value={@dark_theme}
        data-toggle-theme={@dark_theme <> "," <> @light_theme}
        data-act-class="ACTIVECLASS"
      />
      <svg
        class="swap-off h-6 w-6 fill-current"
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 24 24"
      >
        <path d="M5.64,17l-.71.71a1,1,0,0,0,0,1.41,1,1,0,0,0,1.41,0l.71-.71A1,1,0,0,0,5.64,17ZM5,12a1,1,0,0,0-1-1H3a1,1,0,0,0,0,2H4A1,1,0,0,0,5,12Zm7-7a1,1,0,0,0,1-1V3a1,1,0,0,0-2,0V4A1,1,0,0,0,12,5ZM5.64,7.05a1,1,0,0,0,.7.29,1,1,0,0,0,.71-.29,1,1,0,0,0,0-1.41l-.71-.71A1,1,0,0,0,4.93,6.34Zm12,.29a1,1,0,0,0,.7-.29l.71-.71a1,1,0,1,0-1.41-1.41L17,5.64a1,1,0,0,0,0,1.41A1,1,0,0,0,17.66,7.34ZM21,11H20a1,1,0,0,0,0,2h1a1,1,0,0,0,0-2Zm-9,8a1,1,0,0,0-1,1v1a1,1,0,0,0,2,0V20A1,1,0,0,0,12,19ZM18.36,17A1,1,0,0,0,17,18.36l.71.71a1,1,0,0,0,1.41,0,1,1,0,0,0,0-1.41ZM12,6.5A5.5,5.5,0,1,0,17.5,12,5.51,5.51,0,0,0,12,6.5Zm0,9A3.5,3.5,0,1,1,15.5,12,3.5,3.5,0,0,1,12,15.5Z" />
      </svg>
      <svg
        class="swap-on h-6 w-6 fill-current"
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 24 24"
      >
        <path d="M21.64,13a1,1,0,0,0-1.05-.14,8.05,8.05,0,0,1-3.37.73A8.15,8.15,0,0,1,9.08,5.49a8.59,8.59,0,0,1,.25-2A1,1,0,0,0,8,2.36,10.14,10.14,0,1,0,22,14.05,1,1,0,0,0,21.64,13Zm-9.5,6.69A8.14,8.14,0,0,1,7.08,5.22v.27A10.15,10.15,0,0,0,17.22,15.63a9.79,9.79,0,0,0,2.1-.22A8.11,8.11,0,0,1,12.14,19.73Z" />
      </svg>
    </label>
    """
  end

  @doc """
  Renders a theme selector with visual previews.

  ## Examples

      <.theme_preview_selector />
      <.theme_preview_selector themes={["light", "dark", "cupcake"]} columns={2} />
  """
  attr :id, :string, default: "theme-preview-selector"
  attr :themes, :list, default: nil
  attr :columns, :integer, default: 3
  attr :class, :string, default: nil
  attr :rest, :global

  def theme_preview_selector(assigns) do
    assigns = assign_new(assigns, :theme_list, fn -> assigns[:themes] || @default_themes end)

    ~H"""
    <div
      id={@id}
      class={[
        "grid gap-4",
        grid_cols_class(@columns),
        @class
      ]}
      {@rest}
    >
      <button
        :for={theme <- @theme_list}
        type="button"
        class="overflow-hidden rounded-lg border-2 border-base-content/10 hover:border-base-content/30 transition-colors cursor-pointer"
        data-set-theme={theme}
        data-act-class="!border-primary"
      >
        <div data-theme={theme} class="w-full bg-base-100 p-3">
          <div class="flex items-center justify-between mb-2">
            <span class="text-sm font-medium text-base-content capitalize">{theme}</span>
            <div class="flex gap-1">
              <span class="w-2 h-2 rounded-full" style="background-color: oklch(var(--p))"></span>
              <span class="w-2 h-2 rounded-full" style="background-color: oklch(var(--s))"></span>
              <span class="w-2 h-2 rounded-full" style="background-color: oklch(var(--a))"></span>
            </div>
          </div>
          <div class="flex gap-1">
            <div class="flex-1 h-6 rounded bg-primary"></div>
            <div class="flex-1 h-6 rounded bg-secondary"></div>
            <div class="flex-1 h-6 rounded bg-accent"></div>
            <div class="flex-1 h-6 rounded bg-neutral"></div>
          </div>
        </div>
      </button>
    </div>
    """
  end

  @doc """
  Renders an inline theme switcher as radio buttons.

  ## Examples

      <.theme_radio_group name="theme" themes={["light", "dark", "synthwave"]} />
  """
  attr :name, :string, required: true
  attr :themes, :list, default: nil
  attr :selected, :string, default: nil
  attr :class, :string, default: nil
  attr :rest, :global

  def theme_radio_group(assigns) do
    assigns = assign_new(assigns, :theme_list, fn -> assigns[:themes] || @default_themes end)

    ~H"""
    <div class={["flex flex-wrap gap-2", @class]} {@rest}>
      <label :for={theme <- @theme_list} class="cursor-pointer">
        <input
          type="radio"
          name={@name}
          value={theme}
          class="peer hidden"
          checked={@selected == theme}
          data-set-theme={theme}
          data-act-class="ACTIVECLASS"
        />
        <span class="badge badge-lg badge-outline peer-checked:badge-primary capitalize">
          {theme}
        </span>
      </label>
    </div>
    """
  end

  defp grid_cols_class(1), do: "grid-cols-1"
  defp grid_cols_class(2), do: "grid-cols-2"
  defp grid_cols_class(3), do: "grid-cols-3"
  defp grid_cols_class(4), do: "grid-cols-4"
  defp grid_cols_class(5), do: "grid-cols-5"
  defp grid_cols_class(6), do: "grid-cols-6"
  defp grid_cols_class(_), do: "grid-cols-3"
end
