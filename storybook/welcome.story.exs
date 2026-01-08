defmodule Storybook.Welcome do
  use PhoenixStorybook.Story, :page

  def doc, do: "Mithril UI - A Phoenix LiveView Component Library"

  def navigation do
    [
      {:welcome, "Welcome", {:fa, "home", :solid}},
      {:getting_started, "Getting Started", {:fa, "rocket", :solid}},
      {:patterns, "Patterns", {:fa, "code", :solid}},
      {:theming, "Theming", {:fa, "palette", :solid}}
    ]
  end

  def render(assigns = %{tab: :welcome}) do
    ~H"""
    <div class="psb-welcome-page">
      <h1>Mithril UI</h1>
      <p>
        A comprehensive Phoenix LiveView component library built with
        <strong>DaisyUI theming</strong> and <strong>Flowbite-inspired</strong> designs.
      </p>

      <h2>Features</h2>
      <ul>
        <li><strong>50+ Components</strong> - Actions, Forms, Feedback, Data Display, Navigation, Overlays, Typography, and more</li>
        <li><strong>DaisyUI Theming</strong> - 35 built-in themes with full custom theme support</li>
        <li><strong>LiveView Native</strong> - Built for Phoenix LiveView with HEEx templates and JS commands</li>
        <li><strong>Accessible</strong> - WAI-ARIA compliant with keyboard navigation support</li>
        <li><strong>AI-Ready</strong> - Component metadata and schemas for AI-assisted development</li>
      </ul>

      <h2>Component Categories</h2>

      <h3>Actions</h3>
      <p>button, button_group, dropdown</p>

      <h3>Forms</h3>
      <p>input, textarea, select, checkbox, radio, toggle, range, file_input</p>

      <h3>Feedback</h3>
      <p>alert, toast, modal, drawer, progress, spinner, skeleton</p>

      <h3>Data Display</h3>
      <p>card, table, avatar, badge, accordion, list_group, timeline</p>

      <h3>Navigation</h3>
      <p>navbar, sidebar, breadcrumb, tabs, pagination, bottom_navigation</p>

      <h3>Overlays</h3>
      <p>tooltip, popover</p>

      <h3>Typography</h3>
      <p>heading, text, link, blockquote, code, kbd</p>

      <h3>Extended</h3>
      <p>rating, stepper, indicator, chat_bubble, footer, banner, carousel, gallery</p>

      <h3>Utility</h3>
      <p>theme_switcher, clipboard, speed_dial</p>

      <p>
        Use the <strong>sidebar</strong> to explore all components with interactive examples.
      </p>
    </div>
    """
  end

  def render(assigns = %{tab: :getting_started}) do
    assigns = Map.put(assigns, :code_examples, getting_started_code())

    ~H"""
    <div class="psb-welcome-page">
      <h1>Getting Started</h1>

      <h2>1. Installation</h2>
      <p>Add to your <code class="inline">mix.exs</code>:</p>
      <pre><code><%= @code_examples.mix_deps %></code></pre>

      <p>Then run:</p>
      <pre><code><%= @code_examples.install_commands %></code></pre>

      <h2>2. Import Components</h2>
      <p>Add to your <code class="inline">my_app_web.ex</code>:</p>
      <pre><code><%= @code_examples.import_components %></code></pre>

      <h2>3. Use Components</h2>
      <pre><code><%= @code_examples.usage_example %></code></pre>

      <h2>Mix Tasks</h2>
      <ul>
        <li><code class="inline">mix mithril_ui.install</code> - Install and configure Mithril UI</li>
        <li><code class="inline">mix mithril_ui.gen.themes</code> - Generate CSS for custom themes</li>
      </ul>
    </div>
    """
  end

  def render(assigns = %{tab: :patterns}) do
    assigns = Map.put(assigns, :code_examples, patterns_code())

    ~H"""
    <div class="psb-welcome-page">
      <h1>Code Patterns</h1>

      <h2>Component Structure</h2>
      <p>All Mithril UI components follow consistent patterns:</p>
      <pre><code><%= @code_examples.component_structure %></code></pre>

      <h2>Variants Pattern</h2>
      <p>Components use DaisyUI semantic color variants:</p>
      <pre><code><%= @code_examples.variants %></code></pre>

      <h2>Sizes Pattern</h2>
      <pre><code><%= @code_examples.sizes %></code></pre>

      <h2>Slots Pattern</h2>
      <p>Complex components use named slots for structured content:</p>
      <pre><code><%= @code_examples.slots %></code></pre>

      <h2>LiveView.JS Integration</h2>
      <p>Components integrate with Phoenix.LiveView.JS for client-side interactions:</p>
      <pre><code><%= @code_examples.liveview_js %></code></pre>

      <h2>Global Attributes</h2>
      <p>All components accept global attributes via <code class="inline">:rest</code>:</p>
      <pre><code><%= @code_examples.global_attrs %></code></pre>
    </div>
    """
  end

  def render(assigns = %{tab: :theming}) do
    assigns = Map.put(assigns, :code_examples, theming_code())

    ~H"""
    <div class="psb-welcome-page">
      <h1>Theming</h1>

      <p>
        Mithril UI uses DaisyUI's theming system, giving you access to <strong>35 built-in themes</strong>
        plus the ability to create custom themes.
      </p>

      <h2>Built-in Themes</h2>
      <p>
        light, dark, cupcake, bumblebee, emerald, corporate, synthwave, retro, cyberpunk,
        valentine, halloween, garden, forest, aqua, lofi, pastel, fantasy, wireframe, black,
        luxury, dracula, autumn, business, acid, lemonade, night, coffee, winter, dim, nord, sunset
      </p>

      <h2>Configuration</h2>
      <p>Configure themes in <code class="inline">config/mithril_ui.exs</code>:</p>
      <pre><code><%= @code_examples.config %></code></pre>

      <h2>Applying Themes</h2>
      <p>Themes are applied via the <code class="inline">data-theme</code> attribute:</p>
      <pre><code><%= @code_examples.applying_themes %></code></pre>

      <h2>Theme Switcher Component</h2>
      <pre><code><%= @code_examples.theme_switcher %></code></pre>

      <h2>Custom Themes</h2>
      <p>Define custom themes in config:</p>
      <pre><code><%= @code_examples.custom_themes %></code></pre>

      <h2>Semantic Colors</h2>
      <p>DaisyUI uses semantic color names that adapt to each theme:</p>
      <ul>
        <li><strong>primary</strong> - Main brand color</li>
        <li><strong>secondary</strong> - Supporting brand color</li>
        <li><strong>accent</strong> - Highlight color</li>
        <li><strong>neutral</strong> - Neutral/gray tones</li>
        <li><strong>base-100/200/300</strong> - Background colors</li>
        <li><strong>info/success/warning/error</strong> - Semantic status colors</li>
      </ul>
    </div>
    """
  end

  # Code examples stored as plain strings to avoid HEEx parsing issues

  defp getting_started_code do
    %{
      mix_deps: """
      # mix.exs
      def deps do
        [{:mithril_ui, "~> 0.1.0"}]
      end
      """,
      install_commands: """
      mix deps.get
      mix mithril_ui.install
      """,
      import_components: """
      defmodule MyAppWeb do
        defp html_helpers do
          quote do
            use MithrilUI.Components
            # ... other imports
          end
        end
      end
      """,
      usage_example: """
      <.button variant="primary">Click me</.button>

      <.card>
        <:header>Card Title</:header>
        <:body>Content goes here</:body>
      </.card>

      <.modal id="my-modal">
        <:title>Confirm</:title>
        <p>Are you sure?</p>
      </.modal>
      """
    }
  end

  defp patterns_code do
    %{
      component_structure: """
      # Attributes with sensible defaults
      attr :variant, :string, default: "primary", values: ~w(primary secondary accent)
      attr :size, :string, default: "md", values: ~w(xs sm md lg)
      attr :class, :string, default: nil
      attr :rest, :global

      # Named slots for complex content
      slot :header
      slot :body, required: true
      slot :footer
      """,
      variants: """
      <.button variant="primary">Primary</.button>
      <.button variant="secondary">Secondary</.button>
      <.button variant="accent">Accent</.button>
      <.button variant="info">Info</.button>
      <.button variant="success">Success</.button>
      <.button variant="warning">Warning</.button>
      <.button variant="error">Error</.button>
      <.button variant="ghost">Ghost</.button>
      <.button variant="outline">Outline</.button>
      """,
      sizes: """
      <.button size="xs">Extra Small</.button>
      <.button size="sm">Small</.button>
      <.button size="md">Medium (default)</.button>
      <.button size="lg">Large</.button>
      """,
      slots: """
      <.card>
        <:header>Title</:header>
        <:body>Main content</:body>
        <:footer>
          <.button>Action</.button>
        </:footer>
      </.card>

      <.modal id="confirm">
        <:title>Confirm Action</:title>
        <:actions>
          <.button variant="ghost">Cancel</.button>
          <.button variant="primary">Confirm</.button>
        </:actions>
        Are you sure you want to proceed?
      </.modal>
      """,
      liveview_js: """
      # Modal show/hide
      <.button phx-click={show_modal("my-modal")}>Open</.button>

      # Toast notifications
      <.button phx-click={show_toast("success-toast")}>Show Toast</.button>

      # Drawer toggle
      <.button phx-click={toggle_drawer("side-panel")}>Toggle</.button>
      """,
      global_attrs: """
      <.button
        phx-click="save"
        phx-disable-with="Saving..."
        data-testid="save-btn"
        class="w-full"
      >
        Save Changes
      </.button>
      """
    }
  end

  defp theming_code do
    %{
      config: """
      config :mithril_ui,
        default_theme: "light",
        dark_theme: "dark",
        builtin_themes: :all  # or [:light, :dark, :corporate]
      """,
      applying_themes: """
      <!-- In your root.html.heex -->
      <html lang="en" data-theme="light">

      <!-- Or dynamically -->
      <html lang="en" data-theme={@current_theme}>
      """,
      theme_switcher: """
      <!-- Dropdown theme selector -->
      <.theme_switcher />

      <!-- Simple light/dark toggle -->
      <.theme_toggle />

      <!-- Theme preview grid -->
      <.theme_preview_selector themes={["light", "dark", "cupcake"]} />
      """,
      custom_themes: """
      config :mithril_ui,
        themes: [
          %{
            name: "corporate",
            color_scheme: :light,
            colors: %{
              primary: "#4F46E5",
              secondary: "#7C3AED",
              accent: "#F59E0B",
              neutral: "#374151",
              "base-100": "#FFFFFF"
            }
          }
        ]

      # Then generate CSS
      mix mithril_ui.gen.themes
      """
    }
  end
end
