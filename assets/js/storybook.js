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

// MithrilUI Carousel Navigation
// Handles prev/next button clicks for carousel components
document.addEventListener("carousel:next", (e) => {
  const carousel = e.target;
  const total = e.detail.total;
  const current = parseInt(carousel.dataset.carouselActive || "0");
  const next = (current + 1) % total;
  window.carouselGoTo(carousel, next, total);
});

document.addEventListener("carousel:prev", (e) => {
  const carousel = e.target;
  const total = e.detail.total;
  const current = parseInt(carousel.dataset.carouselActive || "0");
  const prev = (current - 1 + total) % total;
  window.carouselGoTo(carousel, prev, total);
});

window.carouselGoTo = function(carousel, targetIndex, total) {
  const carouselId = carousel.id;

  // Hide all slides
  for (let i = 0; i < total; i++) {
    const slide = document.getElementById(`${carouselId}-slide-${i}`);
    const indicator = carousel.querySelector(`[data-carousel-indicator="${i}"]`);

    if (slide) {
      slide.classList.remove("opacity-100");
      slide.classList.add("opacity-0", "pointer-events-none");
    }
    if (indicator) {
      indicator.classList.remove("bg-white");
      indicator.classList.add("bg-white/50");
      indicator.setAttribute("aria-current", "false");
    }
  }

  // Show target slide
  const targetSlide = document.getElementById(`${carouselId}-slide-${targetIndex}`);
  const targetIndicator = carousel.querySelector(`[data-carousel-indicator="${targetIndex}"]`);

  if (targetSlide) {
    targetSlide.classList.remove("opacity-0", "pointer-events-none");
    targetSlide.classList.add("opacity-100");
  }
  if (targetIndicator) {
    targetIndicator.classList.remove("bg-white/50");
    targetIndicator.classList.add("bg-white");
    targetIndicator.setAttribute("aria-current", "true");
  }

  carousel.dataset.carouselActive = targetIndex.toString();
};

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
