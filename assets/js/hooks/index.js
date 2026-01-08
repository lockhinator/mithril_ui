/**
 * Mithril UI LiveView Hooks
 *
 * Export all hooks for use in Phoenix LiveView applications.
 *
 * Usage in your app.js:
 *
 *   import { MithrilHooks } from "mithril_ui/hooks"
 *   // or
 *   import { MithrilThemeHook } from "mithril_ui/hooks/theme"
 *
 *   let liveSocket = new LiveSocket("/live", Socket, {
 *     hooks: { ...MithrilHooks }
 *   })
 */

export { MithrilThemeHook, MithrilTheme } from "./theme";

// Combined hooks object for easy spreading
export const MithrilHooks = {
  ...(() => {
    const { MithrilThemeHook } = require("./theme");
    return MithrilThemeHook;
  })(),
};

export default MithrilHooks;
