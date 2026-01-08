// Sync Phoenix Storybook theme classes with DaisyUI's data-theme attribute
// This allows all DaisyUI themes to work with the storybook theme selector

(function() {
  const DAISYUI_THEMES = [
    'light', 'dark', 'cupcake', 'bumblebee', 'emerald', 'corporate',
    'synthwave', 'retro', 'cyberpunk', 'valentine', 'halloween', 'garden',
    'forest', 'aqua', 'lofi', 'pastel', 'fantasy', 'wireframe', 'black',
    'luxury', 'dracula', 'cmyk', 'autumn', 'business', 'acid', 'lemonade',
    'night', 'coffee', 'winter', 'dim', 'nord', 'sunset'
  ];

  const DARK_THEMES = ['dark', 'synthwave', 'halloween', 'forest', 'black',
    'luxury', 'dracula', 'night', 'coffee', 'dim', 'sunset', 'business'];

  function syncTheme() {
    // Find any sandbox element with mithril-ui class
    const sandboxes = document.querySelectorAll('.mithril-ui');

    sandboxes.forEach(sandbox => {
      // Check for theme-* class and extract theme name
      let foundTheme = null;
      for (const theme of DAISYUI_THEMES) {
        if (sandbox.classList.contains(`theme-${theme}`)) {
          foundTheme = theme;
          break;
        }
      }

      // Use found theme or default to light
      const theme = foundTheme || 'light';
      sandbox.setAttribute('data-theme', theme);

      // Set color scheme
      if (DARK_THEMES.includes(theme)) {
        sandbox.style.colorScheme = 'dark';
      } else {
        sandbox.style.colorScheme = 'light';
      }
    });
  }

  // Run immediately
  syncTheme();

  // Run on DOMContentLoaded
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', syncTheme);
  }

  // Watch for any DOM changes
  const observer = new MutationObserver(() => {
    syncTheme();
  });

  // Start observing
  if (document.body) {
    observer.observe(document.body, {
      childList: true,
      subtree: true,
      attributes: true,
      attributeFilter: ['class']
    });
  } else {
    document.addEventListener('DOMContentLoaded', () => {
      observer.observe(document.body, {
        childList: true,
        subtree: true,
        attributes: true,
        attributeFilter: ['class']
      });
    });
  }
})();

// If your components require any hooks or custom uploaders, or if your pages
// require connect parameters, uncomment the following lines and declare them as
// such:
//
// import * as Hooks from "./hooks";
// import * as Params from "./params";
// import * as Uploaders from "./uploaders";

// (function () {
//   window.storybook = { Hooks, Params, Uploaders };
// })();
