defmodule Storybook.Components.Navigation.Breadcrumb do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Breadcrumb.breadcrumb/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="w-full max-w-lg" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :basic,
        description: "Basic breadcrumbs",
        variations: [
          %Variation{
            id: :simple,
            slots: [
              "<:item href=\"/\">Home</:item>",
              "<:item href=\"/products\">Products</:item>",
              "<:item>Current Page</:item>"
            ]
          },
          %Variation{
            id: :long_path,
            slots: [
              "<:item href=\"/\">Home</:item>",
              "<:item href=\"/docs\">Documentation</:item>",
              "<:item href=\"/docs/components\">Components</:item>",
              "<:item href=\"/docs/components/navigation\">Navigation</:item>",
              "<:item>Breadcrumb</:item>"
            ]
          }
        ]
      },
      %VariationGroup{
        id: :sizes,
        description: "Breadcrumb sizes",
        variations: [
          %Variation{
            id: :extra_small,
            attributes: %{size: "xs"},
            slots: [
              "<:item href=\"/\">Home</:item>",
              "<:item href=\"/page\">Page</:item>",
              "<:item>Current</:item>"
            ]
          },
          %Variation{
            id: :large,
            attributes: %{size: "lg"},
            slots: [
              "<:item href=\"/\">Home</:item>",
              "<:item href=\"/page\">Page</:item>",
              "<:item>Current</:item>"
            ]
          }
        ]
      },
      %VariationGroup{
        id: :overflow,
        description: "Breadcrumb with overflow",
        variations: [
          %Variation{
            id: :max_width,
            attributes: %{max_width: "xs"},
            slots: [
              "<:item href=\"/\">Home</:item>",
              "<:item href=\"/very-long-category-name\">Very Long Category Name</:item>",
              "<:item href=\"/subcategory\">Subcategory</:item>",
              "<:item>Current Item</:item>"
            ]
          }
        ]
      }
    ]
  end
end
