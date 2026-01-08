defmodule MithrilUI.Components.Blockquote do
  @moduledoc """
  Blockquote component for quoted text and testimonials.

  Provides styled quotations with support for citations, avatars,
  and various visual styles.

  ## Examples

  Basic blockquote:

      <.blockquote>
        The only way to do great work is to love what you do.
      </.blockquote>

  With citation:

      <.blockquote cite="Steve Jobs">
        The only way to do great work is to love what you do.
      </.blockquote>

  Testimonial style:

      <.testimonial
        author="Jane Doe"
        title="CEO, Acme Corp"
        avatar="/images/jane.jpg"
      >
        This product changed our business completely.
      </.testimonial>
  """

  use Phoenix.Component

  @doc """
  Renders a styled blockquote.

  ## Attributes

    * `:variant` - Visual style. Options: `:default`, `:bordered`, `:solid`.
    * `:size` - Text size. Options: `:sm`, `:md`, `:lg`, `:xl`.
    * `:cite` - Citation/author name.
    * `:cite_url` - URL for citation source.
    * `:icon` - Show quotation icon. Defaults to false.
    * `:align` - Text alignment. Options: `:left`, `:center`, `:right`.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Required. Quote content.

  ## Examples

      <.blockquote>Simple quote</.blockquote>
      <.blockquote variant={:bordered} cite="Author Name">Bordered quote</.blockquote>
      <.blockquote variant={:solid} icon size={:lg}>Large quote with icon</.blockquote>
  """
  @spec blockquote(map()) :: Phoenix.LiveView.Rendered.t()

  attr :variant, :atom,
    default: :default,
    values: [:default, :bordered, :solid],
    doc: "Visual style"

  attr :size, :atom,
    default: :md,
    values: [:sm, :md, :lg, :xl],
    doc: "Text size"

  attr :cite, :string, default: nil, doc: "Citation/author name"
  attr :cite_url, :string, default: nil, doc: "URL for citation"
  attr :icon, :boolean, default: false, doc: "Show quotation icon"

  attr :align, :atom,
    default: :left,
    values: [:left, :center, :right],
    doc: "Text alignment"

  attr :class, :string, default: nil, doc: "Additional CSS classes"
  attr :rest, :global

  slot :inner_block, required: true, doc: "Quote content"

  def blockquote(assigns) do
    ~H"""
    <figure class={[@class]} {@rest}>
      <blockquote class={[
        variant_class(@variant),
        size_class(@size),
        align_class(@align),
        "italic"
      ]}>
        <svg
          :if={@icon}
          class="w-8 h-8 text-base-content/30 mb-4"
          fill="currentColor"
          viewBox="0 0 24 24"
        >
          <path d="M14.017 21v-7.391c0-5.704 3.731-9.57 8.983-10.609l.995 2.151c-2.432.917-3.995 3.638-3.995 5.849h4v10h-9.983zm-14.017 0v-7.391c0-5.704 3.748-9.57 9-10.609l.996 2.151c-2.433.917-3.996 3.638-3.996 5.849h3.983v10h-9.983z" />
        </svg>
        <p>
          {render_slot(@inner_block)}
        </p>
      </blockquote>
      <figcaption :if={@cite} class="mt-4">
        <cite class={["not-italic text-sm text-base-content/60", !@cite_url && "font-medium"]}>
          <%= if @cite_url do %>
            <a href={@cite_url} class="hover:underline">— {@cite}</a>
          <% else %>
            — {@cite}
          <% end %>
        </cite>
      </figcaption>
    </figure>
    """
  end

  @doc """
  Renders a testimonial-style blockquote with author info.

  ## Attributes

    * `:author` - Required. Author name.
    * `:title` - Author title/role.
    * `:avatar` - Avatar image URL.
    * `:rating` - Star rating (1-5).
    * `:class` - Additional CSS classes.

  ## Examples

      <.testimonial author="John Smith" title="Developer">
        Amazing library, saved us hours of work!
      </.testimonial>

      <.testimonial
        author="Jane Doe"
        title="CTO"
        avatar="/images/jane.jpg"
        rating={5}
      >
        Best component library I've used.
      </.testimonial>
  """
  @spec testimonial(map()) :: Phoenix.LiveView.Rendered.t()

  attr :author, :string, required: true, doc: "Author name"
  attr :title, :string, default: nil, doc: "Author title/role"
  attr :avatar, :string, default: nil, doc: "Avatar image URL"
  attr :rating, :integer, default: nil, values: [nil, 1, 2, 3, 4, 5], doc: "Star rating"
  attr :class, :string, default: nil, doc: "Additional CSS classes"
  attr :rest, :global

  slot :inner_block, required: true, doc: "Testimonial content"

  def testimonial(assigns) do
    ~H"""
    <figure class={["p-6 bg-base-200 rounded-box", @class]} {@rest}>
      <div :if={@rating} class="flex gap-1 mb-4">
        <%= for i <- 1..5 do %>
          <svg
            class={["w-5 h-5", i <= @rating && "text-warning", i > @rating && "text-base-300"]}
            fill="currentColor"
            viewBox="0 0 20 20"
          >
            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
          </svg>
        <% end %>
      </div>

      <blockquote class="text-lg italic font-medium text-base-content mb-4">
        <p>"{render_slot(@inner_block)}"</p>
      </blockquote>

      <figcaption class="flex items-center gap-3">
        <div :if={@avatar} class="avatar">
          <div class="w-10 h-10 rounded-full">
            <img src={@avatar} alt={@author} />
          </div>
        </div>
        <div :if={!@avatar} class="avatar placeholder">
          <div class="bg-neutral text-neutral-content rounded-full w-10 h-10">
            <span class="text-sm">{initials(@author)}</span>
          </div>
        </div>
        <div>
          <cite class="font-semibold not-italic text-base-content">{@author}</cite>
          <p :if={@title} class="text-sm text-base-content/60">{@title}</p>
        </div>
      </figcaption>
    </figure>
    """
  end

  # Get initials from name
  defp initials(name) do
    name
    |> String.split()
    |> Enum.take(2)
    |> Enum.map(&String.first/1)
    |> Enum.join()
    |> String.upcase()
  end

  # Variant classes
  defp variant_class(:default), do: nil
  defp variant_class(:bordered), do: "border-l-4 border-primary pl-4"
  defp variant_class(:solid), do: "p-4 bg-base-200 rounded-box"

  # Size classes
  defp size_class(:sm), do: "text-base"
  defp size_class(:md), do: "text-lg"
  defp size_class(:lg), do: "text-xl"
  defp size_class(:xl), do: "text-2xl"

  # Alignment classes
  defp align_class(:left), do: "text-left"
  defp align_class(:center), do: "text-center"
  defp align_class(:right), do: "text-right"
end
