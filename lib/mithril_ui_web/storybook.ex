defmodule MithrilUiWeb.Storybook do
  @moduledoc """
  Phoenix Storybook configuration for Mithril UI component library.

  Provides interactive documentation and visual testing for all components
  with support for all DaisyUI themes.
  """

  use PhoenixStorybook,
    otp_app: :mithril_ui,
    content_path: Path.expand("../../storybook", __DIR__),
    # assets path are remote path, not local file-system paths
    css_path: "/assets/storybook.css",
    js_path: "/assets/storybook.js",
    sandbox_class: "mithril-ui",
    # Theme selector in header - all DaisyUI themes
    themes: [
      light: [name: "Light"],
      dark: [name: "Dark"],
      cupcake: [name: "Cupcake"],
      bumblebee: [name: "Bumblebee"],
      emerald: [name: "Emerald"],
      corporate: [name: "Corporate"],
      synthwave: [name: "Synthwave"],
      retro: [name: "Retro"],
      cyberpunk: [name: "Cyberpunk"],
      valentine: [name: "Valentine"],
      halloween: [name: "Halloween"],
      garden: [name: "Garden"],
      forest: [name: "Forest"],
      aqua: [name: "Aqua"],
      lofi: [name: "Lo-Fi"],
      pastel: [name: "Pastel"],
      fantasy: [name: "Fantasy"],
      wireframe: [name: "Wireframe"],
      black: [name: "Black"],
      luxury: [name: "Luxury"],
      dracula: [name: "Dracula"],
      cmyk: [name: "CMYK"],
      autumn: [name: "Autumn"],
      business: [name: "Business"],
      acid: [name: "Acid"],
      lemonade: [name: "Lemonade"],
      night: [name: "Night"],
      coffee: [name: "Coffee"],
      winter: [name: "Winter"],
      dim: [name: "Dim"],
      nord: [name: "Nord"],
      sunset: [name: "Sunset"]
    ],
    themes_strategies: [
      sandbox_class: "theme"
    ]
end
