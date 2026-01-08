defmodule MithrilUI.Components.Code do
  @moduledoc """
  Code component for displaying inline code and code blocks.

  Provides styled code snippets with optional syntax highlighting
  support and copy functionality.

  ## Examples

  Inline code:

      <.code>const x = 42</.code>

  Code block:

      <.code_block language="elixir">
        def hello(name) do
          "Hello, \#{name}!"
        end
      </.code_block>

  With line numbers:

      <.code_block language="javascript" line_numbers>
        function greet(name) {
          return `Hello, ${name}!`;
        }
      </.code_block>
  """

  use Phoenix.Component

  @doc """
  Renders inline code.

  ## Attributes

    * `:color` - Background color. Options: `:default`, `:primary`, `:secondary`, `:accent`.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Required. Code content.

  ## Examples

      <.code>npm install</.code>
      <.code color={:primary}>mix deps.get</.code>
  """
  @spec code(map()) :: Phoenix.LiveView.Rendered.t()

  attr :color, :atom,
    default: :default,
    values: [:default, :primary, :secondary, :accent],
    doc: "Background color"

  attr :class, :any, default: nil, doc: "Additional CSS classes"
  attr :rest, :global

  slot :inner_block, required: true, doc: "Code content"

  def code(assigns) do
    ~H"""
    <code
      class={[
        "px-1.5 py-0.5 rounded text-sm font-mono",
        color_class(@color),
        @class
      ]}
      {@rest}
    >
      {render_slot(@inner_block)}
    </code>
    """
  end

  @doc """
  Renders a code block with optional features.

  ## Attributes

    * `:language` - Programming language for syntax highlighting.
    * `:filename` - Optional filename to display.
    * `:line_numbers` - Show line numbers. Defaults to false.
    * `:highlight_lines` - List of line numbers to highlight.
    * `:copyable` - Show copy button. Defaults to true.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Required. Code content.

  ## Examples

      <.code_block language="elixir" filename="lib/my_app.ex">
        defmodule MyApp do
          def hello, do: :world
        end
      </.code_block>
  """
  @spec code_block(map()) :: Phoenix.LiveView.Rendered.t()

  attr :language, :string, default: nil, doc: "Programming language"
  attr :filename, :string, default: nil, doc: "Filename to display"
  attr :line_numbers, :boolean, default: false, doc: "Show line numbers"
  attr :copyable, :boolean, default: true, doc: "Show copy button"
  attr :class, :any, default: nil, doc: "Additional CSS classes"
  attr :rest, :global

  slot :inner_block, required: true, doc: "Code content"

  def code_block(assigns) do
    ~H"""
    <div class={["relative group", @class]} {@rest}>
      <div
        :if={@filename || @language}
        class="flex items-center justify-between px-4 py-2 bg-base-300 rounded-t-box text-sm"
      >
        <span class="text-base-content/70">
          {if @filename, do: @filename, else: @language}
        </span>
        <span :if={@filename && @language} class="text-base-content/50 text-xs">
          {@language}
        </span>
      </div>

      <div class="relative">
        <pre class={[
          "p-4 bg-base-200 overflow-x-auto font-mono text-sm",
          (@filename || @language) && "rounded-b-box",
          !(@filename || @language) && "rounded-box"
        ]}><code class={@language && "language-#{@language}"}>{render_slot(@inner_block)}</code></pre>

        <button
          :if={@copyable}
          type="button"
          class="absolute top-2 right-2 p-2 rounded bg-base-300 opacity-0 group-hover:opacity-100 transition-opacity hover:bg-base-content/10"
          onclick="navigator.clipboard.writeText(this.closest('.group').querySelector('code').textContent)"
          title="Copy to clipboard"
        >
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"
            />
          </svg>
        </button>
      </div>
    </div>
    """
  end

  @doc """
  Renders a diff-style code block showing changes.

  ## Attributes

    * `:language` - Programming language.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Required. Diff content (lines starting with + or -).

  ## Examples

      <.code_diff language="elixir">
        - def old_function do
        -   :old
        - end
        + def new_function do
        +   :new
        + end
      </.code_diff>
  """
  @spec code_diff(map()) :: Phoenix.LiveView.Rendered.t()

  attr :language, :string, default: nil, doc: "Programming language"
  attr :class, :any, default: nil, doc: "Additional CSS classes"
  attr :rest, :global

  slot :inner_block, required: true, doc: "Diff content"

  def code_diff(assigns) do
    ~H"""
    <pre class={["p-4 bg-base-200 rounded-box overflow-x-auto font-mono text-sm", @class]} {@rest}><code>{render_slot(@inner_block)}</code></pre>
    """
  end

  # Color classes for inline code
  defp color_class(:default), do: "bg-base-200 text-base-content"
  defp color_class(:primary), do: "bg-primary/10 text-primary"
  defp color_class(:secondary), do: "bg-secondary/10 text-secondary"
  defp color_class(:accent), do: "bg-accent/10 text-accent"
end
