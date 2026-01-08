defmodule MithrilUI.Components.Pagination do
  @moduledoc """
  A pagination component for navigating through pages of content.

  Provides various styles of pagination controls including numbered pages,
  previous/next buttons, and showing results information.

  ## Examples

  Basic pagination:

      <.pagination
        current_page={@page}
        total_pages={10}
        on_page_change="page_changed"
      />

  With showing results:

      <.pagination
        current_page={@page}
        total_pages={@total_pages}
        total_entries={@total}
        page_size={20}
        on_page_change="page_changed"
        show_info
      />

  ## DaisyUI Classes

  The component uses the following DaisyUI classes:
  - `join` - Groups buttons together
  - `btn` - Button styling
  """

  use Phoenix.Component

  @sizes ~w(xs sm md lg)

  @doc """
  Renders a pagination control.

  ## Attributes

    * `:current_page` - The currently active page number (required).
    * `:total_pages` - Total number of pages (required).
    * `:on_page_change` - Event name to send when page changes.
    * `:page_param` - Parameter name for the page number. Defaults to "page".
    * `:size` - Button size: xs, sm, md, lg. Defaults to "sm".
    * `:show_info` - Whether to show "Showing X to Y of Z" text. Defaults to false.
    * `:total_entries` - Total number of entries (required if show_info is true).
    * `:page_size` - Number of entries per page (required if show_info is true).
    * `:sibling_count` - Number of pages to show on each side of current. Defaults to 1.
    * `:boundary_count` - Number of pages to show at start/end. Defaults to 1.
    * `:class` - Additional CSS classes.

  ## Examples

      <.pagination
        current_page={5}
        total_pages={20}
        on_page_change="go_to_page"
      />
  """
  @spec pagination(map()) :: Phoenix.LiveView.Rendered.t()

  attr :current_page, :integer, required: true
  attr :total_pages, :integer, required: true
  attr :on_page_change, :string, default: nil
  attr :page_param, :string, default: "page"
  attr :size, :string, default: "sm", values: @sizes
  attr :show_info, :boolean, default: false
  attr :total_entries, :integer, default: nil
  attr :page_size, :integer, default: nil
  attr :sibling_count, :integer, default: 1
  attr :boundary_count, :integer, default: 1
  attr :class, :string, default: nil

  attr :rest, :global

  def pagination(assigns) do
    assigns = assign(assigns, :pages, build_page_range(assigns))

    ~H"""
    <nav class={["flex items-center gap-4", @class]} aria-label="Pagination" {@rest}>
      <div :if={@show_info && @total_entries && @page_size} class="text-sm text-base-content/70">
        Showing {entry_start(@current_page, @page_size)} to {entry_end(
          @current_page,
          @page_size,
          @total_entries
        )} of {@total_entries} entries
      </div>
      <div class="join">
        <button
          type="button"
          class={["join-item btn btn-#{@size}", @current_page == 1 && "btn-disabled"]}
          disabled={@current_page == 1}
          phx-click={@on_page_change}
          phx-value-page={@current_page - 1}
          aria-label="Previous page"
        >
          «
        </button>

        <%= for page <- @pages do %>
          <%= if page == :ellipsis do %>
            <button type="button" class={"join-item btn btn-#{@size} btn-disabled"}>…</button>
          <% else %>
            <button
              type="button"
              class={["join-item btn btn-#{@size}", page == @current_page && "btn-active"]}
              phx-click={@on_page_change}
              phx-value-page={page}
              aria-current={page == @current_page && "page"}
            >
              {page}
            </button>
          <% end %>
        <% end %>

        <button
          type="button"
          class={["join-item btn btn-#{@size}", @current_page == @total_pages && "btn-disabled"]}
          disabled={@current_page == @total_pages}
          phx-click={@on_page_change}
          phx-value-page={@current_page + 1}
          aria-label="Next page"
        >
          »
        </button>
      </div>
    </nav>
    """
  end

  @doc """
  Renders a simple previous/next pagination without page numbers.

  ## Attributes

    * `:current_page` - The currently active page number (required).
    * `:total_pages` - Total number of pages (required).
    * `:on_page_change` - Event name to send when page changes.
    * `:size` - Button size: xs, sm, md, lg. Defaults to "sm".
    * `:show_current` - Whether to show "Page X of Y". Defaults to true.
    * `:class` - Additional CSS classes.

  ## Examples

      <.simple_pagination
        current_page={@page}
        total_pages={@total_pages}
        on_page_change="change_page"
      />
  """
  @spec simple_pagination(map()) :: Phoenix.LiveView.Rendered.t()

  attr :current_page, :integer, required: true
  attr :total_pages, :integer, required: true
  attr :on_page_change, :string, default: nil
  attr :size, :string, default: "sm", values: @sizes
  attr :show_current, :boolean, default: true
  attr :class, :string, default: nil

  attr :rest, :global

  def simple_pagination(assigns) do
    ~H"""
    <nav class={["flex items-center gap-2", @class]} aria-label="Pagination" {@rest}>
      <button
        type="button"
        class={["btn btn-#{@size}", @current_page == 1 && "btn-disabled"]}
        disabled={@current_page == 1}
        phx-click={@on_page_change}
        phx-value-page={@current_page - 1}
      >
        Previous
      </button>

      <span :if={@show_current} class="text-sm text-base-content/70">
        Page {@current_page} of {@total_pages}
      </span>

      <button
        type="button"
        class={["btn btn-#{@size}", @current_page == @total_pages && "btn-disabled"]}
        disabled={@current_page == @total_pages}
        phx-click={@on_page_change}
        phx-value-page={@current_page + 1}
      >
        Next
      </button>
    </nav>
    """
  end

  @doc """
  Renders pagination with icon arrows instead of text.

  ## Attributes

    * `:current_page` - The currently active page number (required).
    * `:total_pages` - Total number of pages (required).
    * `:on_page_change` - Event name to send when page changes.
    * `:size` - Button size: xs, sm, md, lg. Defaults to "sm".
    * `:class` - Additional CSS classes.

  ## Examples

      <.icon_pagination current_page={5} total_pages={10} on_page_change="page" />
  """
  @spec icon_pagination(map()) :: Phoenix.LiveView.Rendered.t()

  attr :current_page, :integer, required: true
  attr :total_pages, :integer, required: true
  attr :on_page_change, :string, default: nil
  attr :size, :string, default: "sm", values: @sizes
  attr :class, :string, default: nil
  attr :sibling_count, :integer, default: 1
  attr :boundary_count, :integer, default: 1

  attr :rest, :global

  def icon_pagination(assigns) do
    assigns = assign(assigns, :pages, build_page_range(assigns))

    ~H"""
    <nav class={["flex items-center", @class]} aria-label="Pagination" {@rest}>
      <div class="join">
        <button
          type="button"
          class={["join-item btn btn-#{@size}", @current_page == 1 && "btn-disabled"]}
          disabled={@current_page == 1}
          phx-click={@on_page_change}
          phx-value-page={@current_page - 1}
          aria-label="Previous page"
        >
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
          </svg>
        </button>

        <%= for page <- @pages do %>
          <%= if page == :ellipsis do %>
            <button type="button" class={"join-item btn btn-#{@size} btn-disabled"}>…</button>
          <% else %>
            <button
              type="button"
              class={["join-item btn btn-#{@size}", page == @current_page && "btn-active"]}
              phx-click={@on_page_change}
              phx-value-page={page}
              aria-current={page == @current_page && "page"}
            >
              {page}
            </button>
          <% end %>
        <% end %>

        <button
          type="button"
          class={["join-item btn btn-#{@size}", @current_page == @total_pages && "btn-disabled"]}
          disabled={@current_page == @total_pages}
          phx-click={@on_page_change}
          phx-value-page={@current_page + 1}
          aria-label="Next page"
        >
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
          </svg>
        </button>
      </div>
    </nav>
    """
  end

  defp build_page_range(%{
         total_pages: total,
         current_page: current,
         sibling_count: siblings,
         boundary_count: boundary
       }) do
    # Calculate ranges
    left_boundary = 1..min(boundary, total) |> Enum.to_list()
    right_boundary = max(total - boundary + 1, 1)..total |> Enum.to_list()

    # Calculate sibling range around current page
    sibling_start = max(current - siblings, boundary + 2)
    sibling_end = min(current + siblings, total - boundary - 1)

    sibling_range =
      if sibling_start <= sibling_end do
        sibling_start..sibling_end |> Enum.to_list()
      else
        []
      end

    # Build final list with ellipsis
    pages = left_boundary

    pages =
      if sibling_start > boundary + 2 do
        pages ++ [:ellipsis]
      else
        pages ++ Enum.to_list((boundary + 1)..(sibling_start - 1))
      end

    pages = pages ++ sibling_range

    pages =
      if sibling_end < total - boundary - 1 do
        pages ++ [:ellipsis]
      else
        pages ++ Enum.to_list((sibling_end + 1)..(total - boundary))
      end

    pages = pages ++ right_boundary

    pages
    |> Enum.uniq()
    |> Enum.filter(fn
      :ellipsis -> true
      page -> page >= 1 && page <= total
    end)
  end

  defp entry_start(page, page_size), do: (page - 1) * page_size + 1

  defp entry_end(page, page_size, total) do
    min(page * page_size, total)
  end
end
