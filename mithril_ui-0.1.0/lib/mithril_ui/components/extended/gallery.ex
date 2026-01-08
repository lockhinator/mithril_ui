defmodule MithrilUI.Components.Gallery do
  @moduledoc """
  Gallery component for displaying collections of images in various layouts.

  ## Examples

  Basic gallery:

      <.gallery items={["/img1.jpg", "/img2.jpg", "/img3.jpg"]} />

  Masonry layout:

      <.gallery_masonry items={images} columns={4} />

  Featured image gallery:

      <.gallery_featured
        featured="/hero.jpg"
        items={["/a.jpg", "/b.jpg", "/c.jpg", "/d.jpg"]}
      />
  """

  use Phoenix.Component

  @columns ~w(2 3 4 5)

  @doc """
  Renders a basic grid gallery.

  ## Attributes

    * `:items` - List of image URLs (required).
    * `:columns` - Number of columns: 2, 3, 4, 5. Defaults to "3".
    * `:gap` - Gap size: 2, 4, 6. Defaults to "4".
    * `:rounded` - Enable rounded corners. Defaults to true.
    * `:class` - Additional CSS classes.

  ## Examples

      <.gallery items={["/a.jpg", "/b.jpg", "/c.jpg"]} />

      <.gallery items={images} columns="4" gap="2" />
  """
  @spec gallery(map()) :: Phoenix.LiveView.Rendered.t()

  attr :items, :list, required: true
  attr :columns, :string, default: "3", values: @columns
  attr :gap, :string, default: "4", values: ~w(2 4 6)
  attr :rounded, :boolean, default: true
  attr :class, :string, default: nil
  attr :rest, :global

  def gallery(assigns) do
    ~H"""
    <div
      class={[
        "grid",
        grid_cols_class(@columns),
        "gap-#{@gap}",
        @class
      ]}
      {@rest}
    >
      <%= for {src, index} <- Enum.with_index(@items) do %>
        <div>
          <img
            src={src}
            alt={"Gallery image #{index + 1}"}
            class={[
              "h-auto max-w-full",
              @rounded && "rounded-lg"
            ]}
          />
        </div>
      <% end %>
    </div>
    """
  end

  defp grid_cols_class("2"), do: "grid-cols-2"
  defp grid_cols_class("3"), do: "grid-cols-2 md:grid-cols-3"
  defp grid_cols_class("4"), do: "grid-cols-2 md:grid-cols-4"
  defp grid_cols_class("5"), do: "grid-cols-2 md:grid-cols-5"

  @doc """
  Renders a masonry-style gallery with stacked columns.

  ## Attributes

    * `:items` - List of image URLs (required).
    * `:columns` - Number of columns: 2, 3, 4. Defaults to "4".
    * `:gap` - Gap size. Defaults to "4".
    * `:rounded` - Enable rounded corners. Defaults to true.
    * `:class` - Additional CSS classes.

  ## Examples

      <.gallery_masonry items={images} columns="3" />
  """
  @spec gallery_masonry(map()) :: Phoenix.LiveView.Rendered.t()

  attr :items, :list, required: true
  attr :columns, :string, default: "4", values: ~w(2 3 4)
  attr :gap, :string, default: "4", values: ~w(2 4 6)
  attr :rounded, :boolean, default: true
  attr :class, :string, default: nil
  attr :rest, :global

  def gallery_masonry(assigns) do
    cols = String.to_integer(assigns.columns)
    distributed = distribute_items(assigns.items, cols)
    assigns = assign(assigns, :distributed, distributed)

    ~H"""
    <div
      class={[
        "grid",
        grid_cols_class(@columns),
        "gap-#{@gap}",
        @class
      ]}
      {@rest}
    >
      <%= for {column_items, col_index} <- Enum.with_index(@distributed) do %>
        <div class={"grid gap-#{@gap}"}>
          <%= for {src, index} <- Enum.with_index(column_items) do %>
            <div>
              <img
                src={src}
                alt={"Gallery image #{col_index}-#{index}"}
                class={[
                  "h-auto max-w-full",
                  @rounded && "rounded-lg"
                ]}
              />
            </div>
          <% end %>
        </div>
      <% end %>
    </div>
    """
  end

  defp distribute_items(items, columns) do
    items
    |> Enum.with_index()
    |> Enum.group_by(fn {_item, index} -> rem(index, columns) end, fn {item, _index} -> item end)
    |> Enum.sort_by(fn {col, _} -> col end)
    |> Enum.map(fn {_, items} -> items end)
  end

  @doc """
  Renders a gallery with a featured/hero image.

  ## Attributes

    * `:featured` - Featured image URL (required).
    * `:items` - List of thumbnail image URLs (required).
    * `:gap` - Gap size. Defaults to "4".
    * `:rounded` - Enable rounded corners. Defaults to true.
    * `:class` - Additional CSS classes.

  ## Examples

      <.gallery_featured
        featured="/hero.jpg"
        items={["/a.jpg", "/b.jpg", "/c.jpg", "/d.jpg", "/e.jpg"]}
      />
  """
  @spec gallery_featured(map()) :: Phoenix.LiveView.Rendered.t()

  attr :featured, :string, required: true
  attr :items, :list, required: true
  attr :gap, :string, default: "4", values: ~w(2 4 6)
  attr :rounded, :boolean, default: true
  attr :class, :string, default: nil
  attr :rest, :global

  def gallery_featured(assigns) do
    ~H"""
    <div class={["space-y-#{@gap}", @class]} {@rest}>
      <div>
        <img
          src={@featured}
          alt="Featured image"
          class={[
            "h-auto max-w-full w-full",
            @rounded && "rounded-lg"
          ]}
        />
      </div>
      <div class={["grid grid-cols-5", "gap-#{@gap}"]}>
        <%= for {src, index} <- Enum.with_index(@items) do %>
          <div>
            <img
              src={src}
              alt={"Thumbnail #{index + 1}"}
              class={[
                "h-auto max-w-full",
                @rounded && "rounded-lg"
              ]}
            />
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  @doc """
  Renders a quad (2x2) gallery.

  ## Attributes

    * `:items` - List of exactly 4 image URLs (required).
    * `:gap` - Gap size. Defaults to "2".
    * `:rounded` - Enable rounded corners. Defaults to true.
    * `:class` - Additional CSS classes.

  ## Examples

      <.gallery_quad items={["/a.jpg", "/b.jpg", "/c.jpg", "/d.jpg"]} />
  """
  @spec gallery_quad(map()) :: Phoenix.LiveView.Rendered.t()

  attr :items, :list, required: true
  attr :gap, :string, default: "2", values: ~w(2 4 6)
  attr :rounded, :boolean, default: true
  attr :class, :string, default: nil
  attr :rest, :global

  def gallery_quad(assigns) do
    ~H"""
    <div class={["grid grid-cols-2", "gap-#{@gap}", @class]} {@rest}>
      <%= for {src, index} <- Enum.with_index(Enum.take(@items, 4)) do %>
        <div>
          <img
            src={src}
            alt={"Gallery image #{index + 1}"}
            class={[
              "h-auto max-w-full",
              @rounded && "rounded-lg"
            ]}
          />
        </div>
      <% end %>
    </div>
    """
  end

  @doc """
  Renders a gallery item with hover overlay.

  ## Attributes

    * `:src` - Image URL (required).
    * `:alt` - Alt text.
    * `:rounded` - Enable rounded corners. Defaults to true.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:overlay` - Hover overlay content.

  ## Examples

      <.gallery_item src="/photo.jpg">
        <:overlay>
          <button class="btn btn-sm">View</button>
        </:overlay>
      </.gallery_item>
  """
  @spec gallery_item(map()) :: Phoenix.LiveView.Rendered.t()

  attr :src, :string, required: true
  attr :alt, :string, default: ""
  attr :rounded, :boolean, default: true
  attr :class, :string, default: nil
  attr :rest, :global

  slot :overlay

  def gallery_item(assigns) do
    ~H"""
    <div class={["relative group", @class]} {@rest}>
      <img
        src={@src}
        alt={@alt}
        class={[
          "h-auto max-w-full",
          @rounded && "rounded-lg"
        ]}
      />
      <div
        :if={@overlay != []}
        class={[
          "absolute inset-0 flex items-center justify-center",
          "bg-black/50 opacity-0 group-hover:opacity-100 transition-opacity",
          @rounded && "rounded-lg"
        ]}
      >
        {render_slot(@overlay)}
      </div>
    </div>
    """
  end

  @doc """
  Renders a gallery with filter tabs.

  ## Attributes

    * `:items` - List of maps with :src and :category keys (required).
    * `:categories` - List of category names (required).
    * `:columns` - Number of columns.
    * `:gap` - Gap size.
    * `:rounded` - Enable rounded corners.
    * `:class` - Additional CSS classes.

  ## Examples

      <.gallery_filtered
        items={[
          %{src: "/a.jpg", category: "nature"},
          %{src: "/b.jpg", category: "city"},
          %{src: "/c.jpg", category: "nature"}
        ]}
        categories={["all", "nature", "city"]}
      />
  """
  @spec gallery_filtered(map()) :: Phoenix.LiveView.Rendered.t()

  attr :items, :list, required: true
  attr :categories, :list, required: true
  attr :columns, :string, default: "3", values: @columns
  attr :gap, :string, default: "4", values: ~w(2 4 6)
  attr :rounded, :boolean, default: true
  attr :active_category, :string, default: "all"
  attr :class, :string, default: nil
  attr :rest, :global

  def gallery_filtered(assigns) do
    ~H"""
    <div class={@class} {@rest}>
      <div class="flex flex-wrap gap-2 mb-4">
        <%= for category <- @categories do %>
          <button
            type="button"
            class={[
              "btn btn-sm",
              if(category == @active_category, do: "btn-primary", else: "btn-ghost")
            ]}
            phx-click="filter_gallery"
            phx-value-category={category}
          >
            {String.capitalize(category)}
          </button>
        <% end %>
      </div>
      <div class={["grid", grid_cols_class(@columns), "gap-#{@gap}"]}>
        <%= for {item, index} <- Enum.with_index(@items) do %>
          <div
            :if={@active_category == "all" || item.category == @active_category}
            class="transition-all"
          >
            <img
              src={item.src}
              alt={Map.get(item, :alt, "Gallery image #{index + 1}")}
              class={[
                "h-auto max-w-full",
                @rounded && "rounded-lg"
              ]}
            />
          </div>
        <% end %>
      </div>
    </div>
    """
  end
end
