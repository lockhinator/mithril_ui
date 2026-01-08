defmodule MithrilUI.Components.Clipboard do
  @moduledoc """
  Clipboard component for copy-to-clipboard functionality.

  Provides various patterns for copying text to the clipboard including
  input fields with copy buttons, icon-only copy buttons, and copy buttons
  with text labels.

  Requires JavaScript to handle the actual copy functionality.
  See the Flowbite clipboard documentation for JS implementation.
  """
  use Phoenix.Component

  @doc """
  Renders an input field with a copy button.

  ## Examples

      <.clipboard_input id="copy-input" value="npm install mithril_ui" />
      <.clipboard_input id="api-key" value={@api_key} label="API Key" readonly />
  """
  attr :id, :string, required: true
  attr :value, :string, required: true
  attr :label, :string, default: nil
  attr :readonly, :boolean, default: true
  attr :button_text, :string, default: "Copy"
  attr :success_text, :string, default: "Copied!"
  attr :class, :any, default: nil
  attr :rest, :global

  def clipboard_input(assigns) do
    ~H"""
    <div class={["relative", @class]} {@rest}>
      <label :if={@label} for={@id} class="label">
        <span class="label-text">{@label}</span>
      </label>
      <div class="join w-full">
        <input
          id={@id}
          type="text"
          value={@value}
          readonly={@readonly}
          class="input input-bordered join-item flex-1 bg-base-200"
        />
        <button
          type="button"
          class="btn btn-primary join-item"
          data-copy-to-clipboard-target={@id}
        >
          <span class="clipboard-default flex items-center gap-2">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M8 5H6a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2v-1M8 5a2 2 0 002 2h2a2 2 0 002-2M8 5a2 2 0 012-2h2a2 2 0 012 2m0 0h2a2 2 0 012 2v3m2 4H10m0 0l3-3m-3 3l3 3"
              />
            </svg>
            {@button_text}
          </span>
          <span class="clipboard-success hidden items-center gap-2">
            <svg class="w-4 h-4 text-success" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M5 13l4 4L19 7"
              />
            </svg>
            {@success_text}
          </span>
        </button>
      </div>
    </div>
    """
  end

  @doc """
  Renders a copy button with icon inside an input field.

  ## Examples

      <.clipboard_inline id="inline-copy" value="https://example.com/share/abc123" />
  """
  attr :id, :string, required: true
  attr :value, :string, required: true
  attr :label, :string, default: nil
  attr :readonly, :boolean, default: true
  attr :class, :any, default: nil
  attr :rest, :global

  def clipboard_inline(assigns) do
    ~H"""
    <div class={@class} {@rest}>
      <label :if={@label} for={@id} class="label">
        <span class="label-text">{@label}</span>
      </label>
      <div class="relative">
        <input
          id={@id}
          type="text"
          value={@value}
          readonly={@readonly}
          class="input input-bordered w-full pr-12 bg-base-200"
        />
        <button
          type="button"
          class="btn btn-ghost btn-sm absolute right-2 top-1/2 -translate-y-1/2"
          data-copy-to-clipboard-target={@id}
          data-tooltip-target={"tooltip-" <> @id}
        >
          <span class="clipboard-default">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M8 5H6a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2v-1M8 5a2 2 0 002 2h2a2 2 0 002-2M8 5a2 2 0 012-2h2a2 2 0 012 2m0 0h2a2 2 0 012 2v3m2 4H10m0 0l3-3m-3 3l3 3"
              />
            </svg>
          </span>
          <span class="clipboard-success hidden">
            <svg class="w-4 h-4 text-success" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M5 13l4 4L19 7"
              />
            </svg>
          </span>
        </button>
      </div>
      <div
        id={"tooltip-" <> @id}
        role="tooltip"
        class="tooltip tooltip-top hidden"
        data-tooltip
      >
        <span class="clipboard-default">Copy to clipboard</span>
        <span class="clipboard-success hidden">Copied!</span>
      </div>
    </div>
    """
  end

  @doc """
  Renders a standalone copy icon button.

  ## Examples

      <.clipboard_icon_button target_id="code-block" />
      <.clipboard_icon_button target_id="secret" tooltip />
  """
  attr :target_id, :string, required: true, doc: "ID of the element to copy from"
  attr :tooltip, :boolean, default: false
  attr :class, :any, default: nil
  attr :rest, :global

  def clipboard_icon_button(assigns) do
    ~H"""
    <button
      type="button"
      class={["btn btn-ghost btn-sm btn-square", @class]}
      data-copy-to-clipboard-target={@target_id}
      data-tooltip-target={@tooltip && "tooltip-btn-" <> @target_id}
      {@rest}
    >
      <span class="clipboard-default">
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M8 5H6a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2v-1M8 5a2 2 0 002 2h2a2 2 0 002-2M8 5a2 2 0 012-2h2a2 2 0 012 2m0 0h2a2 2 0 012 2v3m2 4H10m0 0l3-3m-3 3l3 3"
          />
        </svg>
      </span>
      <span class="clipboard-success hidden">
        <svg class="w-4 h-4 text-success" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
        </svg>
      </span>
    </button>
    <div
      :if={@tooltip}
      id={"tooltip-btn-" <> @target_id}
      role="tooltip"
      class="tooltip tooltip-top hidden"
      data-tooltip
    >
      <span class="clipboard-default">Copy to clipboard</span>
      <span class="clipboard-success hidden">Copied!</span>
    </div>
    """
  end

  @doc """
  Renders a code block with a copy button.

  ## Examples

      <.clipboard_code id="install-code" code="mix deps.get" />
      <.clipboard_code id="curl" code={@curl_command} language="bash" />
  """
  attr :id, :string, required: true
  attr :code, :string, required: true
  attr :language, :string, default: nil
  attr :class, :any, default: nil
  attr :rest, :global

  def clipboard_code(assigns) do
    ~H"""
    <div class={["relative group", @class]} {@rest}>
      <pre id={@id} class="mockup-code bg-neutral text-neutral-content overflow-x-auto"><code class={@language && "language-#{@language}"}>{@code}</code></pre>
      <button
        type="button"
        class="btn btn-ghost btn-sm absolute top-2 right-2 opacity-0 group-hover:opacity-100 transition-opacity"
        data-copy-to-clipboard-target={@id}
        data-copy-to-clipboard-content-type="textContent"
      >
        <span class="clipboard-default flex items-center gap-1">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M8 5H6a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2v-1M8 5a2 2 0 002 2h2a2 2 0 002-2M8 5a2 2 0 012-2h2a2 2 0 012 2m0 0h2a2 2 0 012 2v3m2 4H10m0 0l3-3m-3 3l3 3"
            />
          </svg>
          Copy
        </span>
        <span class="clipboard-success hidden items-center gap-1">
          <svg class="w-4 h-4 text-success" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
          </svg>
          Copied!
        </span>
      </button>
    </div>
    """
  end

  @doc """
  Renders an input group with prefix label and copy button.

  ## Examples

      <.clipboard_input_group id="url" prefix="https://" value="mithrilui.dev/share/123" />
  """
  attr :id, :string, required: true
  attr :value, :string, required: true
  attr :prefix, :string, required: true
  attr :readonly, :boolean, default: true
  attr :class, :any, default: nil
  attr :rest, :global

  def clipboard_input_group(assigns) do
    ~H"""
    <div class={["join", @class]} {@rest}>
      <span class="join-item flex items-center px-4 bg-base-200 border border-base-300 text-base-content/70">
        {@prefix}
      </span>
      <input
        id={@id}
        type="text"
        value={@value}
        readonly={@readonly}
        class="input input-bordered join-item flex-1"
      />
      <button type="button" class="btn btn-primary join-item" data-copy-to-clipboard-target={@id}>
        <span class="clipboard-default flex items-center gap-2">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M8 5H6a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2v-1M8 5a2 2 0 002 2h2a2 2 0 002-2M8 5a2 2 0 012-2h2a2 2 0 012 2m0 0h2a2 2 0 012 2v3m2 4H10m0 0l3-3m-3 3l3 3"
            />
          </svg>
          Copy
        </span>
        <span class="clipboard-success hidden items-center gap-2">
          <svg class="w-4 h-4 text-success" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
          </svg>
          Copied!
        </span>
      </button>
    </div>
    """
  end
end
