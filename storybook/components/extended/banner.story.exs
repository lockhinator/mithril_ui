defmodule Storybook.Components.Extended.Banner do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Banner.banner/1

  def description do
    """
    Banner component for announcements, promotions, and notifications.
    Supports dismissible banners, CTAs, newsletter signups, and
    various visual variants.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default banner",
        slots: ["Important announcement: Check out our new features!"]
      },
      %Variation{
        id: :dismissible,
        description: "Dismissible banner",
        attributes: %{id: "dismiss-banner", dismissible: true},
        slots: ["This banner can be dismissed."]
      },
      %VariationGroup{
        id: :variants,
        description: "Banner variants",
        variations: [
          %Variation{
            id: :info,
            attributes: %{variant: "info"},
            slots: ["Information: System maintenance scheduled."]
          },
          %Variation{
            id: :success,
            attributes: %{variant: "success"},
            slots: ["Success: Your changes have been saved."]
          },
          %Variation{
            id: :warning,
            attributes: %{variant: "warning"},
            slots: ["Warning: Please update your profile."]
          },
          %Variation{
            id: :error,
            attributes: %{variant: "error"},
            slots: ["Error: Connection failed. Please retry."]
          }
        ]
      },
      %Variation{
        id: :with_icon,
        description: "Banner with icon",
        attributes: %{variant: "info"},
        slots: [
          """
          <:icon>
            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
              <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd" />
            </svg>
          </:icon>
          New documentation available! Check it out.
          """
        ]
      }
    ]
  end
end
