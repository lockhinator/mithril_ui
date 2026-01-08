defmodule Storybook.Components.Navigation.Sidebar do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Sidebar.sidebar/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="max-w-xs" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :basic,
        description: "Basic sidebar",
        variations: [
          %Variation{
            id: :simple,
            slots: [
              "<:item href=\"/\">Dashboard</:item>",
              "<:item href=\"/users\">Users</:item>",
              "<:item href=\"/settings\">Settings</:item>"
            ]
          },
          %Variation{
            id: :with_title,
            slots: [
              "<:title>Main Menu</:title>",
              "<:item href=\"/\" active>Dashboard</:item>",
              "<:item href=\"/analytics\">Analytics</:item>",
              "<:divider />",
              "<:title>Account</:title>",
              "<:item href=\"/profile\">Profile</:item>",
              "<:item href=\"/logout\">Logout</:item>"
            ]
          }
        ]
      },
      %VariationGroup{
        id: :features,
        description: "Sidebar features",
        variations: [
          %Variation{
            id: :with_badges,
            slots: [
              "<:item href=\"/inbox\" badge=\"5\" badge_variant=\"primary\">Inbox</:item>",
              "<:item href=\"/starred\" badge=\"New\" badge_variant=\"secondary\">Starred</:item>",
              "<:item href=\"/archive\">Archive</:item>"
            ]
          },
          %Variation{
            id: :with_submenu,
            slots: [
              "<:item href=\"/\">Home</:item>",
              "<:submenu label=\"Settings\" open><li><a href=\"/settings/profile\">Profile</a></li><li><a href=\"/settings/account\">Account</a></li><li><a href=\"/settings/security\">Security</a></li></:submenu>",
              "<:item href=\"/help\">Help</:item>"
            ]
          }
        ]
      },
      %VariationGroup{
        id: :sizes,
        description: "Sidebar sizes",
        variations: [
          %Variation{
            id: :small,
            attributes: %{size: "sm"},
            slots: [
              "<:item href=\"/\">Small Menu</:item>",
              "<:item href=\"/page\">Item</:item>"
            ]
          },
          %Variation{
            id: :large,
            attributes: %{size: "lg"},
            slots: [
              "<:item href=\"/\">Large Menu</:item>",
              "<:item href=\"/page\">Item</:item>"
            ]
          }
        ]
      }
    ]
  end
end
