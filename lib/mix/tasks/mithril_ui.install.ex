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

    cond do
      File.exists?(config_path) ->
        {:exists, "Config file", config_path}

      dry_run ->
        {:created, "Config file", config_path}

      true ->
        File.write!(config_path, config_content)
        inject_config_import()
        {:created, "Config file", config_path}
    end
  end

  defp inject_config_import do
    config_exs_path = "config/config.exs"

    with true <- File.exists?(config_exs_path),
         content <- File.read!(config_exs_path),
         false <- String.contains?(content, "mithril_ui.exs") do
      updated =
        String.replace(
          content,
          ~r/(import_config "\#{config_env\(\)}\.exs")/,
          ~s(import_config "mithril_ui.exs"\n\n\\1)
        )

      File.write!(config_exs_path, updated)
    end
  end

  defp install_tailwind(dry_run) do
    tailwind_result = update_tailwind_config(dry_run)
    css_result = update_app_css(dry_run)
    [tailwind_result, css_result]
  end

  defp update_tailwind_config(dry_run) do
    tailwind_config_path = "assets/tailwind.config.js"

    cond do
      not File.exists?(tailwind_config_path) ->
        {:missing, "Tailwind config", "assets/tailwind.config.js not found"}

      tailwind_has_daisyui?(tailwind_config_path) ->
        {:exists, "Tailwind config", "DaisyUI already configured"}

      dry_run ->
        {:updated, "Tailwind config", tailwind_config_path}

      true ->
        content = File.read!(tailwind_config_path)

        updated =
          content
          |> inject_daisyui_require()
          |> inject_daisyui_plugin()

        File.write!(tailwind_config_path, updated)
        {:updated, "Tailwind config", tailwind_config_path}
    end
  end

  defp tailwind_has_daisyui?(path) do
    path |> File.read!() |> String.contains?("daisyui")
  end

  defp update_app_css(dry_run) do
    app_css_path = "assets/css/app.css"

    cond do
      not File.exists?(app_css_path) ->
        {:missing, "CSS file", "assets/css/app.css not found"}

      app_css_has_mithril?(app_css_path) ->
        {:exists, "CSS @source", "already configured"}

      dry_run ->
        {:updated, "CSS @source", app_css_path}

      true ->
        inject_mithril_source_directive(app_css_path)
        {:updated, "CSS @source", app_css_path}
    end
  end

  defp app_css_has_mithril?(path) do
    path |> File.read!() |> String.contains?("mithril_ui")
  end

  defp inject_mithril_source_directive(path) do
    content = File.read!(path)

    source_directive = """

    /* Mithril UI - Include component classes in Tailwind scan */
    @source "../../deps/mithril_ui/lib/**/*.ex";
    """

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

    File.write!(path, updated)
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

    cond do
      not File.exists?(app_js_path) ->
        {:missing, "JavaScript file", "assets/js/app.js not found"}

      app_js_has_mithril_hooks?(app_js_path) ->
        {:exists, "JavaScript hooks", "already installed"}

      dry_run ->
        {:updated, "JavaScript hooks", app_js_path}

      true ->
        content = File.read!(app_js_path)
        File.write!(app_js_path, content <> hook_content)
        {:updated, "JavaScript hooks", app_js_path}
    end
  end

  defp app_js_has_mithril_hooks?(path) do
    path |> File.read!() |> String.contains?("MithrilTheme")
  end

  defp update_root_layout(dry_run) do
    root_path = find_root_layout()

    cond do
      is_nil(root_path) ->
        {:missing, "Root layout", "Could not find root.html.heex"}

      layout_has_theme?(root_path) ->
        {:exists, "Root layout", "data-theme already present"}

      dry_run ->
        {:updated, "Root layout", root_path}

      true ->
        inject_theme_attribute(root_path)
        {:updated, "Root layout", root_path}
    end
  end

  defp layout_has_theme?(path) do
    path |> File.read!() |> String.contains?("data-theme")
  end

  defp inject_theme_attribute(path) do
    content = File.read!(path)

    updated =
      String.replace(
        content,
        ~r/<html([^>]*)lang="en"([^>]*)>/,
        ~s(<html\\1lang="en"\\2 data-theme="light">)
      )

    File.write!(path, updated)
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
