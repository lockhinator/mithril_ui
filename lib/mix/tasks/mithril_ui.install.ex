defmodule Mix.Tasks.MithrilUi.Install do
  @moduledoc """
  Installs Mithril UI into your Phoenix application.

      $ mix mithril_ui.install

  This task will:
  1. Create Mithril UI configuration file
  2. Update Tailwind config with DaisyUI plugin
  3. Add @source directive to app.css for class scanning
  4. Add JavaScript hooks to app.js
  5. Update root layout with theme attributes
  6. Print next steps

  ## Options

    * `--no-tailwind` - Skip Tailwind/DaisyUI configuration
    * `--no-js` - Skip JavaScript hook installation
    * `--no-config` - Skip config file generation
    * `--no-layout` - Skip root layout modification
    * `--dry-run` - Show what would be done without making changes

  ## Examples

      $ mix mithril_ui.install
      $ mix mithril_ui.install --no-js
      $ mix mithril_ui.install --dry-run
  """

  use Mix.Task

  @shortdoc "Installs Mithril UI into your Phoenix application"

  @impl true
  def run(args) do
    {opts, _, _} =
      OptionParser.parse(args,
        switches: [
          no_tailwind: :boolean,
          no_js: :boolean,
          no_config: :boolean,
          no_layout: :boolean,
          dry_run: :boolean
        ]
      )

    dry_run = opts[:dry_run] || false

    Mix.shell().info("""

    #{IO.ANSI.cyan()}┌─────────────────────────────────────────────────────────────┐
    │                    Mithril UI Installer                     │
    └─────────────────────────────────────────────────────────────┘#{IO.ANSI.reset()}
    """)

    if dry_run do
      Mix.shell().info(
        "#{IO.ANSI.yellow()}[DRY RUN] No files will be modified#{IO.ANSI.reset()}\n"
      )
    end

    results = []

    results =
      if opts[:no_config] do
        results ++ [{:skipped, "Config file", "skipped (--no-config)"}]
      else
        results ++ [install_config(dry_run)]
      end

    results =
      if opts[:no_tailwind] do
        results ++ [{:skipped, "Tailwind/DaisyUI", "skipped (--no-tailwind)"}]
      else
        results ++ install_tailwind(dry_run)
      end

    results =
      if opts[:no_js] do
        results ++ [{:skipped, "JavaScript hooks", "skipped (--no-js)"}]
      else
        results ++ [install_js_hooks(dry_run)]
      end

    results =
      if opts[:no_layout] do
        results ++ [{:skipped, "Root layout", "skipped (--no-layout)"}]
      else
        results ++ [update_root_layout(dry_run)]
      end

    print_results(results)
    print_next_steps()
  end

  defp install_config(dry_run) do
    config_path = "config/mithril_ui.exs"

    config_content = """
    import Config

    # =============================================================================
    # Mithril UI Configuration
    # =============================================================================
    #
    # This file contains all Mithril UI settings. Environment-specific overrides
    # can be added to dev.exs, prod.exs, etc.
    #
    # Example override in config/dev.exs:
    #
    #     config :mithril_ui,
    #       default_theme: "wireframe"  # Use wireframe theme in development
    #
    # =============================================================================

    config :mithril_ui,
      # -------------------------------------------------------------------------
      # Theme Selection
      # -------------------------------------------------------------------------

      # Default theme applied on page load
      default_theme: "light",

      # Theme used when user's system prefers dark mode
      dark_theme: "dark",

      # -------------------------------------------------------------------------
      # Built-in Themes
      # -------------------------------------------------------------------------
      # Which DaisyUI themes to include. Options:
      #   :all   - Include all 35 built-in themes
      #   :none  - Only use custom themes defined below
      #   [list] - Include specific themes, e.g. [:light, :dark, :corporate]

      builtin_themes: :all,

      # -------------------------------------------------------------------------
      # Custom Themes
      # -------------------------------------------------------------------------
      # Define your own themes here. Each theme needs:
      #   - name: unique identifier (used in data-theme attribute)
      #   - label: display name in theme picker
      #   - color_scheme: :light or :dark
      #   - colors: map of color definitions
      #
      # See documentation for full color options and examples.

      themes: []
    """

    if File.exists?(config_path) do
      {:exists, "Config file", config_path}
    else
      unless dry_run do
        File.write!(config_path, config_content)

        # Inject import into config.exs
        config_exs_path = "config/config.exs"

        if File.exists?(config_exs_path) do
          content = File.read!(config_exs_path)

          unless String.contains?(content, "mithril_ui.exs") do
            # Insert before the environment import line
            updated =
              String.replace(
                content,
                ~r/(import_config "\#{config_env\(\)}\.exs")/,
                ~s(import_config "mithril_ui.exs"\n\n\\1)
              )

            File.write!(config_exs_path, updated)
          end
        end
      end

      {:created, "Config file", config_path}
    end
  end

  defp install_tailwind(dry_run) do
    results = []

    # Update tailwind.config.js
    tailwind_config_path = "assets/tailwind.config.js"

    results =
      if File.exists?(tailwind_config_path) do
        content = File.read!(tailwind_config_path)

        if String.contains?(content, "daisyui") do
          results ++ [{:exists, "Tailwind config", "DaisyUI already configured"}]
        else
          unless dry_run do
            updated =
              content
              |> inject_daisyui_require()
              |> inject_daisyui_plugin()

            File.write!(tailwind_config_path, updated)
          end

          results ++ [{:updated, "Tailwind config", tailwind_config_path}]
        end
      else
        results ++ [{:missing, "Tailwind config", "assets/tailwind.config.js not found"}]
      end

    # Add @source directive to app.css
    app_css_path = "assets/css/app.css"

    results =
      if File.exists?(app_css_path) do
        content = File.read!(app_css_path)

        if String.contains?(content, "mithril_ui") do
          results ++ [{:exists, "CSS @source", "already configured"}]
        else
          unless dry_run do
            source_directive = """

            /* Mithril UI - Include component classes in Tailwind scan */
            @source "../../deps/mithril_ui/lib/**/*.ex";
            """

            # Insert after @import "tailwindcss" or at the beginning
            updated =
              if String.contains?(content, "@import") do
                String.replace(
                  content,
                  ~r/(@import\s+["'][^"']+["'];?\n)/,
                  "\\1#{source_directive}",
                  global: false
                )
              else
                source_directive <> "\n" <> content
              end

            File.write!(app_css_path, updated)
          end

          results ++ [{:updated, "CSS @source", app_css_path}]
        end
      else
        results ++ [{:missing, "CSS file", "assets/css/app.css not found"}]
      end

    results
  end

  defp inject_daisyui_require(content) do
    if String.contains?(content, "require(\"daisyui\")") do
      content
    else
      # Add require at the top of the file
      "const daisyui = require(\"daisyui\");\n" <> content
    end
  end

  defp inject_daisyui_plugin(content) do
    cond do
      String.contains?(content, "plugins:") and String.contains?(content, "daisyui") ->
        content

      String.contains?(content, "plugins: [") ->
        # Add daisyui to existing plugins array
        String.replace(content, "plugins: [", "plugins: [\n    daisyui,")

      String.contains?(content, "plugins:") ->
        # plugins exists but might be empty or different format
        String.replace(content, ~r/plugins:\s*\[\s*\]/, "plugins: [daisyui]")

      true ->
        # No plugins key found, add before closing brace of module.exports
        String.replace(
          content,
          ~r/(module\.exports\s*=\s*\{[^}]*)(}\s*;?\s*$)/s,
          "\\1  plugins: [daisyui],\n\\2"
        )
    end
  end

  defp install_js_hooks(dry_run) do
    app_js_path = "assets/js/app.js"

    hook_content = """

    // =============================================================================
    // Mithril UI Hooks
    // =============================================================================

    // Theme persistence hook - saves theme preference to localStorage
    const MithrilTheme = {
      mounted() {
        // Check for saved theme preference
        const savedTheme = localStorage.getItem("mithril-theme")
        if (savedTheme) {
          document.documentElement.setAttribute("data-theme", savedTheme)
        }

        // Listen for theme changes
        this.handleEvent("set-theme", ({theme}) => {
          document.documentElement.setAttribute("data-theme", theme)
          localStorage.setItem("mithril-theme", theme)
        })
      }
    }

    // Clipboard hook - copy text to clipboard
    const MithrilClipboard = {
      mounted() {
        this.el.addEventListener("click", () => {
          const targetId = this.el.dataset.copyToClipboardTarget
          const target = document.getElementById(targetId)
          if (target) {
            const text = target.value || target.textContent
            navigator.clipboard.writeText(text).then(() => {
              // Toggle success state
              const defaultEl = this.el.querySelector(".clipboard-default")
              const successEl = this.el.querySelector(".clipboard-success")
              if (defaultEl && successEl) {
                defaultEl.classList.add("hidden")
                successEl.classList.remove("hidden")
                successEl.classList.add("flex")
                setTimeout(() => {
                  defaultEl.classList.remove("hidden")
                  successEl.classList.add("hidden")
                  successEl.classList.remove("flex")
                }, 2000)
              }
            })
          }
        })
      }
    }

    // Export hooks for use in LiveSocket
    // Add to your LiveSocket: let liveSocket = new LiveSocket("/live", Socket, {hooks: Hooks})
    export const MithrilHooks = {
      MithrilTheme,
      MithrilClipboard
    }

    // If you're using the default Phoenix setup, merge with existing hooks:
    // const Hooks = { ...MithrilHooks, ...YourOtherHooks }
    """

    if File.exists?(app_js_path) do
      content = File.read!(app_js_path)

      if String.contains?(content, "MithrilTheme") do
        {:exists, "JavaScript hooks", "already installed"}
      else
        unless dry_run do
          File.write!(app_js_path, content <> hook_content)
        end

        {:updated, "JavaScript hooks", app_js_path}
      end
    else
      {:missing, "JavaScript file", "assets/js/app.js not found"}
    end
  end

  defp update_root_layout(dry_run) do
    root_path = find_root_layout()

    if root_path do
      content = File.read!(root_path)

      if String.contains?(content, "data-theme") do
        {:exists, "Root layout", "data-theme already present"}
      else
        unless dry_run do
          updated =
            String.replace(
              content,
              ~r/<html([^>]*)lang="en"([^>]*)>/,
              ~s(<html\\1lang="en"\\2 data-theme="light">)
            )

          File.write!(root_path, updated)
        end

        {:updated, "Root layout", root_path}
      end
    else
      {:missing, "Root layout", "Could not find root.html.heex"}
    end
  end

  defp find_root_layout do
    paths = [
      "lib/*/components/layouts/root.html.heex",
      "lib/*_web/components/layouts/root.html.heex",
      "lib/*_web/templates/layout/root.html.heex"
    ]

    Enum.find_value(paths, fn pattern ->
      case Path.wildcard(pattern) do
        [path | _] -> path
        [] -> nil
      end
    end)
  end

  defp print_results(results) do
    Mix.shell().info("#{IO.ANSI.cyan()}Installation Summary:#{IO.ANSI.reset()}\n")

    Enum.each(results, fn
      {:created, name, path} ->
        Mix.shell().info("  #{IO.ANSI.green()}✓#{IO.ANSI.reset()} #{name}: created #{path}")

      {:updated, name, path} ->
        Mix.shell().info("  #{IO.ANSI.green()}✓#{IO.ANSI.reset()} #{name}: updated #{path}")

      {:exists, name, detail} ->
        Mix.shell().info("  #{IO.ANSI.yellow()}○#{IO.ANSI.reset()} #{name}: #{detail}")

      {:skipped, name, reason} ->
        Mix.shell().info("  #{IO.ANSI.blue()}−#{IO.ANSI.reset()} #{name}: #{reason}")

      {:missing, name, detail} ->
        Mix.shell().info("  #{IO.ANSI.red()}✗#{IO.ANSI.reset()} #{name}: #{detail}")
    end)

    Mix.shell().info("")
  end

  defp print_next_steps do
    Mix.shell().info("""
    #{IO.ANSI.cyan()}Next Steps:#{IO.ANSI.reset()}

    1. #{IO.ANSI.yellow()}Install DaisyUI#{IO.ANSI.reset()} (if not already installed):

       cd assets && npm install -D daisyui

    2. #{IO.ANSI.yellow()}Import components#{IO.ANSI.reset()} in your module:

       defmodule MyAppWeb do
         defp html_helpers do
           quote do
             use MithrilUI.Components
             # ... other imports
           end
         end
       end

    3. #{IO.ANSI.yellow()}Add hooks to LiveSocket#{IO.ANSI.reset()} in assets/js/app.js:

       import { MithrilHooks } from "./app.js"

       let liveSocket = new LiveSocket("/live", Socket, {
         hooks: { ...MithrilHooks },
         // ... other options
       })

    4. #{IO.ANSI.yellow()}Start using components#{IO.ANSI.reset()}:

       <.button>Click me</.button>
       <.card>
         <:header>Title</:header>
         Content here
       </.card>

    #{IO.ANSI.cyan()}Documentation:#{IO.ANSI.reset()} https://hexdocs.pm/mithril_ui
    """)
  end
end
