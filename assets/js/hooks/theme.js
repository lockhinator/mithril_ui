/**
 * Mithril UI Theme Hook
 *
 * Phoenix LiveView hook for managing theme switching with localStorage persistence.
 * Works with DaisyUI's data-theme attribute system.
 *
 * Usage in your root layout:
 *
 *   <html
 *     data-theme={MithrilUI.Theme.default_theme()}
 *     data-default-theme={MithrilUI.Theme.default_theme()}
 *     data-dark-theme={MithrilUI.Theme.dark_theme()}
 *     phx-hook="MithrilTheme"
 *     id="app-root"
 *   >
 *
 * In your app.js:
 *
 *   import { MithrilThemeHook } from "./hooks/theme"
 *   let liveSocket = new LiveSocket("/live", Socket, {
 *     hooks: { ...MithrilThemeHook }
 *   })
 */

const STORAGE_KEY = "mithril_ui_theme";

export const MithrilThemeHook = {
  MithrilTheme: {
    mounted() {
      this.defaultTheme = this.el.dataset.defaultTheme || "light";
      this.darkTheme = this.el.dataset.darkTheme || "dark";

      // Load saved theme or detect from system preference
      const savedTheme = localStorage.getItem(STORAGE_KEY);
      let theme = savedTheme;

      if (!theme) {
        // Check system preference
        const prefersDark = window.matchMedia(
          "(prefers-color-scheme: dark)"
        ).matches;
        theme = prefersDark ? this.darkTheme : this.defaultTheme;
      }

      this.setTheme(theme, false);

      // Listen for system preference changes
      this.mediaQuery = window.matchMedia("(prefers-color-scheme: dark)");
      this.handleMediaChange = (e) => {
        // Only auto-switch if user hasn't manually selected a theme
        if (!localStorage.getItem(STORAGE_KEY)) {
          this.setTheme(e.matches ? this.darkTheme : this.defaultTheme, false);
        }
      };
      this.mediaQuery.addEventListener("change", this.handleMediaChange);

      // Listen for theme changes from LiveView
      this.handleEvent("mithril_set_theme", ({ theme }) => {
        this.setTheme(theme, true);
      });

      // Listen for theme reset
      this.handleEvent("mithril_reset_theme", () => {
        localStorage.removeItem(STORAGE_KEY);
        const prefersDark = window.matchMedia(
          "(prefers-color-scheme: dark)"
        ).matches;
        this.setTheme(
          prefersDark ? this.darkTheme : this.defaultTheme,
          false
        );
      });
    },

    destroyed() {
      if (this.mediaQuery && this.handleMediaChange) {
        this.mediaQuery.removeEventListener("change", this.handleMediaChange);
      }
    },

    /**
     * Sets the current theme
     * @param {string} theme - Theme name
     * @param {boolean} persist - Whether to save to localStorage
     */
    setTheme(theme, persist = true) {
      document.documentElement.setAttribute("data-theme", theme);

      if (persist) {
        localStorage.setItem(STORAGE_KEY, theme);
      }

      // Notify LiveView of the theme change
      this.pushEvent("mithril_theme_changed", { theme });
    },

    /**
     * Gets the current theme
     * @returns {string} Current theme name
     */
    getTheme() {
      return document.documentElement.getAttribute("data-theme");
    },

    /**
     * Toggles between light and dark theme
     */
    toggleTheme() {
      const current = this.getTheme();
      const colorScheme = document.documentElement.style.colorScheme;
      const isDark = colorScheme === "dark" || current === this.darkTheme;
      this.setTheme(isDark ? this.defaultTheme : this.darkTheme);
    },
  },
};

/**
 * Standalone theme utilities for use outside LiveView hooks
 */
export const MithrilTheme = {
  /**
   * Gets the current theme
   * @returns {string} Current theme name
   */
  get() {
    return document.documentElement.getAttribute("data-theme");
  },

  /**
   * Sets the current theme
   * @param {string} theme - Theme name
   * @param {boolean} persist - Whether to save to localStorage (default: true)
   */
  set(theme, persist = true) {
    document.documentElement.setAttribute("data-theme", theme);
    if (persist) {
      localStorage.setItem(STORAGE_KEY, theme);
    }
  },

  /**
   * Resets theme to system preference
   */
  reset() {
    localStorage.removeItem(STORAGE_KEY);
    const prefersDark = window.matchMedia(
      "(prefers-color-scheme: dark)"
    ).matches;
    const defaultTheme =
      document.documentElement.dataset.defaultTheme || "light";
    const darkTheme = document.documentElement.dataset.darkTheme || "dark";
    this.set(prefersDark ? darkTheme : defaultTheme, false);
  },

  /**
   * Toggles between default light and dark themes
   */
  toggle() {
    const current = this.get();
    const defaultTheme =
      document.documentElement.dataset.defaultTheme || "light";
    const darkTheme = document.documentElement.dataset.darkTheme || "dark";
    const isDark = current === darkTheme;
    this.set(isDark ? defaultTheme : darkTheme);
  },

  /**
   * Checks if dark mode is currently active
   * @returns {boolean}
   */
  isDark() {
    const current = this.get();
    const darkTheme = document.documentElement.dataset.darkTheme || "dark";
    return current === darkTheme;
  },
};

export default MithrilThemeHook;
