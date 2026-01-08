defmodule MithrilUI.Components.ChatBubble do
  @moduledoc """
  Chat bubble component for displaying conversation messages.

  ## Examples

  Basic chat:

      <.chat position="start">
        <:bubble>Hello!</:bubble>
      </.chat>

  With avatar and metadata:

      <.chat position="end">
        <:avatar src="/avatar.jpg" />
        <:header>John Doe <time>12:45</time></:header>
        <:bubble color="primary">Hi there!</:bubble>
        <:footer>Delivered</:footer>
      </.chat>

  ## DaisyUI Classes

  - `chat` - Container class
  - `chat-start` - Align to left (incoming message)
  - `chat-end` - Align to right (outgoing message)
  - `chat-bubble` - Message bubble styling
  - `chat-bubble-{color}` - Bubble color variants
  - `chat-image` - Avatar wrapper
  - `chat-header` - Text above bubble
  - `chat-footer` - Text below bubble
  """

  use Phoenix.Component

  @colors ~w(primary secondary accent neutral info success warning error)
  @positions ~w(start end)

  @doc """
  Renders a chat message container.

  ## Attributes

    * `:position` - Message alignment: start, end (required).
    * `:class` - Additional CSS classes.

  ## Slots

    * `:avatar` - Avatar image with optional src attribute.
    * `:header` - Header content (name, timestamp).
    * `:bubble` - Message bubble content with optional color attribute.
    * `:footer` - Footer content (status, read receipt).

  ## Examples

      <.chat position="start">
        <:bubble>Hello, how are you?</:bubble>
      </.chat>

      <.chat position="end">
        <:avatar src="/me.jpg" />
        <:header>Me <time class="text-xs opacity-50">12:46</time></:header>
        <:bubble color="primary">I'm doing great, thanks!</:bubble>
        <:footer class="opacity-50">Seen</:footer>
      </.chat>
  """
  @spec chat(map()) :: Phoenix.LiveView.Rendered.t()

  attr :position, :string, required: true, values: @positions
  attr :class, :any, default: nil
  attr :rest, :global

  slot :avatar do
    attr :src, :string
    attr :alt, :string
    attr :class, :any
  end

  slot :header do
    attr :class, :any
  end

  slot :bubble do
    attr :color, :string
    attr :class, :any
  end

  slot :footer do
    attr :class, :any
  end

  def chat(assigns) do
    ~H"""
    <div class={["chat", "chat-#{@position}", @class]} {@rest}>
      <div :for={avatar <- @avatar} class={["chat-image avatar", avatar[:class]]}>
        <div class="w-10 rounded-full">
          <img :if={avatar[:src]} src={avatar[:src]} alt={avatar[:alt] || "Avatar"} />
          {render_slot(avatar)}
        </div>
      </div>
      <div :for={header <- @header} class={["chat-header", header[:class]]}>
        {render_slot(header)}
      </div>
      <div
        :for={bubble <- @bubble}
        class={[
          "chat-bubble",
          bubble[:color] && "chat-bubble-#{bubble[:color]}",
          bubble[:class]
        ]}
      >
        {render_slot(bubble)}
      </div>
      <div :for={footer <- @footer} class={["chat-footer", footer[:class]]}>
        {render_slot(footer)}
      </div>
    </div>
    """
  end

  @doc """
  Renders a simple chat message with minimal configuration.

  ## Attributes

    * `:position` - Message alignment: start, end. Defaults to "start".
    * `:color` - Bubble color.
    * `:avatar_src` - Avatar image URL.
    * `:sender` - Sender name.
    * `:time` - Message timestamp.
    * `:status` - Delivery status text.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Message content (required).

  ## Examples

      <.chat_message position="start" sender="Alice" time="12:45">
        Hello!
      </.chat_message>

      <.chat_message
        position="end"
        color="primary"
        sender="Me"
        time="12:46"
        status="Delivered"
      >
        Hi there!
      </.chat_message>
  """
  @spec chat_message(map()) :: Phoenix.LiveView.Rendered.t()

  attr :position, :string, default: "start", values: @positions
  attr :color, :string, default: nil, values: @colors ++ [nil]
  attr :avatar_src, :string, default: nil
  attr :sender, :string, default: nil
  attr :time, :string, default: nil
  attr :status, :string, default: nil
  attr :class, :any, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def chat_message(assigns) do
    ~H"""
    <div class={["chat", "chat-#{@position}", @class]} {@rest}>
      <div :if={@avatar_src} class="chat-image avatar">
        <div class="w-10 rounded-full">
          <img src={@avatar_src} alt={@sender || "Avatar"} />
        </div>
      </div>
      <div :if={@sender || @time} class="chat-header">
        <span :if={@sender}>{@sender}</span>
        <time :if={@time} class="text-xs opacity-50">{@time}</time>
      </div>
      <div class={["chat-bubble", @color && "chat-bubble-#{@color}"]}>
        {render_slot(@inner_block)}
      </div>
      <div :if={@status} class="chat-footer opacity-50">
        {@status}
      </div>
    </div>
    """
  end

  @doc """
  Renders a chat bubble with an image attachment.

  ## Attributes

    * `:position` - Message alignment.
    * `:image_src` - Image URL (required).
    * `:image_alt` - Image alt text.
    * `:caption` - Optional caption text.
    * `:avatar_src` - Avatar image URL.
    * `:sender` - Sender name.
    * `:time` - Message timestamp.
    * `:class` - Additional CSS classes.

  ## Examples

      <.chat_image
        position="start"
        image_src="/photo.jpg"
        sender="Alice"
        time="12:50"
        caption="Check this out!"
      />
  """
  @spec chat_image(map()) :: Phoenix.LiveView.Rendered.t()

  attr :position, :string, default: "start", values: @positions
  attr :image_src, :string, required: true
  attr :image_alt, :string, default: "Shared image"
  attr :caption, :string, default: nil
  attr :avatar_src, :string, default: nil
  attr :sender, :string, default: nil
  attr :time, :string, default: nil
  attr :class, :any, default: nil
  attr :rest, :global

  def chat_image(assigns) do
    ~H"""
    <div class={["chat", "chat-#{@position}", @class]} {@rest}>
      <div :if={@avatar_src} class="chat-image avatar">
        <div class="w-10 rounded-full">
          <img src={@avatar_src} alt={@sender || "Avatar"} />
        </div>
      </div>
      <div :if={@sender || @time} class="chat-header">
        <span :if={@sender}>{@sender}</span>
        <time :if={@time} class="text-xs opacity-50">{@time}</time>
      </div>
      <div class="chat-bubble p-1">
        <img src={@image_src} alt={@image_alt} class="rounded-lg max-w-xs" />
        <p :if={@caption} class="text-sm mt-1 px-2">{@caption}</p>
      </div>
    </div>
    """
  end

  @doc """
  Renders a chat bubble with a file attachment.

  ## Attributes

    * `:position` - Message alignment.
    * `:file_name` - File name to display (required).
    * `:file_size` - File size text.
    * `:file_type` - File type/format text.
    * `:download_url` - Download link URL.
    * `:avatar_src` - Avatar image URL.
    * `:sender` - Sender name.
    * `:time` - Message timestamp.
    * `:class` - Additional CSS classes.

  ## Examples

      <.chat_file
        position="start"
        file_name="document.pdf"
        file_size="2.4 MB"
        file_type="PDF"
        download_url="/files/document.pdf"
        sender="Alice"
      />
  """
  @spec chat_file(map()) :: Phoenix.LiveView.Rendered.t()

  attr :position, :string, default: "start", values: @positions
  attr :file_name, :string, required: true
  attr :file_size, :string, default: nil
  attr :file_type, :string, default: nil
  attr :download_url, :string, default: nil
  attr :avatar_src, :string, default: nil
  attr :sender, :string, default: nil
  attr :time, :string, default: nil
  attr :class, :any, default: nil
  attr :rest, :global

  def chat_file(assigns) do
    ~H"""
    <div class={["chat", "chat-#{@position}", @class]} {@rest}>
      <div :if={@avatar_src} class="chat-image avatar">
        <div class="w-10 rounded-full">
          <img src={@avatar_src} alt={@sender || "Avatar"} />
        </div>
      </div>
      <div :if={@sender || @time} class="chat-header">
        <span :if={@sender}>{@sender}</span>
        <time :if={@time} class="text-xs opacity-50">{@time}</time>
      </div>
      <div class="chat-bubble">
        <div class="flex items-center gap-3 p-2 bg-base-100/20 rounded-lg">
          <svg class="w-8 h-8 text-current" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
            />
          </svg>
          <div class="flex-1 min-w-0">
            <p class="text-sm font-medium truncate">{@file_name}</p>
            <p :if={@file_size || @file_type} class="text-xs opacity-70">
              {[@file_type, @file_size] |> Enum.filter(& &1) |> Enum.join(" • ")}
            </p>
          </div>
          <a :if={@download_url} href={@download_url} class="btn btn-ghost btn-sm btn-circle" download>
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"
              />
            </svg>
          </a>
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Renders a conversation container for grouping chat messages.

  ## Attributes

    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Chat messages (required).

  ## Examples

      <.chat_conversation>
        <.chat_message position="start" sender="Alice">Hello!</.chat_message>
        <.chat_message position="end" sender="Bob">Hi!</.chat_message>
      </.chat_conversation>
  """
  @spec chat_conversation(map()) :: Phoenix.LiveView.Rendered.t()

  attr :class, :any, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def chat_conversation(assigns) do
    ~H"""
    <div class={["space-y-4", @class]} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end
end
