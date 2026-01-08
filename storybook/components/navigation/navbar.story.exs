defmodule Storybook.Components.Navigation.Navbar do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Navbar.navbar/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="w-full" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :basic,
        description: "Basic navbar layouts",
        variations: [
          %Variation{
            id: :simple,
            slots: [
              "<:start_section><a class=\"btn btn-ghost text-xl\">Brand</a></:start_section>"
            ]
          },
          %Variation{
            id: :with_links,
            slots: [
              "<:start_section><a class=\"btn btn-ghost text-xl\">Logo</a></:start_section>",
              "<:center_section><ul class=\"menu menu-horizontal px-1\"><li><a>Home</a></li><li><a>About</a></li><li><a>Contact</a></li></ul></:center_section>",
              "<:end_section><button class=\"btn btn-primary\">Login</button></:end_section>"
            ]
          }
        ]
      },
      %VariationGroup{
        id: :variants,
        description: "Navbar style variants",
        variations: [
          %Variation{
            id: :sticky,
            attributes: %{sticky: true},
            slots: [
              "<:start_section><a class=\"btn btn-ghost text-xl\">Sticky Nav</a></:start_section>"
            ]
          },
          %Variation{
            id: :bordered,
            attributes: %{bordered: true, shadow: false},
            slots: [
              "<:start_section><a class=\"btn btn-ghost text-xl\">Bordered</a></:start_section>"
            ]
          },
          %Variation{
            id: :transparent,
            attributes: %{transparent: true, shadow: false},
            slots: [
              "<:start_section><a class=\"btn btn-ghost text-xl\">Transparent</a></:start_section>"
            ]
          }
        ]
      }
    ]
  end
end
