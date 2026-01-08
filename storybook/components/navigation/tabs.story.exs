defmodule Storybook.Components.Navigation.Tabs do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Tabs.tabs/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="w-full max-w-2xl" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :variants,
        description: "Tab style variants",
        variations: [
          %Variation{
            id: :bordered,
            attributes: %{variant: "bordered"},
            slots: [
              "<:tab label=\"Tab 1\" active>Content for Tab 1</:tab>",
              "<:tab label=\"Tab 2\">Content for Tab 2</:tab>",
              "<:tab label=\"Tab 3\">Content for Tab 3</:tab>"
            ]
          },
          %Variation{
            id: :lifted,
            attributes: %{variant: "lifted"},
            slots: [
              "<:tab label=\"Tab 1\" active>Content for Tab 1</:tab>",
              "<:tab label=\"Tab 2\">Content for Tab 2</:tab>",
              "<:tab label=\"Tab 3\">Content for Tab 3</:tab>"
            ]
          },
          %Variation{
            id: :boxed,
            attributes: %{variant: "boxed"},
            slots: [
              "<:tab label=\"Tab 1\" active>Content for Tab 1</:tab>",
              "<:tab label=\"Tab 2\">Content for Tab 2</:tab>",
              "<:tab label=\"Tab 3\">Content for Tab 3</:tab>"
            ]
          }
        ]
      },
      %VariationGroup{
        id: :states,
        description: "Tab states",
        variations: [
          %Variation{
            id: :with_disabled,
            attributes: %{variant: "bordered"},
            slots: [
              "<:tab label=\"Active\" active>Active tab content</:tab>",
              "<:tab label=\"Normal\">Normal tab content</:tab>",
              "<:tab label=\"Disabled\" disabled>Disabled tab content</:tab>"
            ]
          }
        ]
      },
      %VariationGroup{
        id: :sizes,
        description: "Tab sizes",
        variations: [
          %Variation{
            id: :xs,
            attributes: %{variant: "bordered", size: "xs"},
            slots: [
              "<:tab label=\"XS Tab 1\" active>Content</:tab>",
              "<:tab label=\"XS Tab 2\">Content</:tab>"
            ]
          },
          %Variation{
            id: :lg,
            attributes: %{variant: "bordered", size: "lg"},
            slots: [
              "<:tab label=\"LG Tab 1\" active>Content</:tab>",
              "<:tab label=\"LG Tab 2\">Content</:tab>"
            ]
          }
        ]
      }
    ]
  end
end
