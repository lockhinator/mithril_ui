defmodule Storybook.Components.DataDisplay.Avatar do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Avatar.avatar/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="flex flex-wrap gap-6 items-center" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :basic,
        description: "Basic avatars",
        variations: [
          %Variation{
            id: :with_image,
            attributes: %{src: "https://i.pravatar.cc/150?img=1", alt: "User"}
          },
          %Variation{
            id: :placeholder,
            attributes: %{placeholder: "JD"}
          }
        ]
      },
      %VariationGroup{
        id: :sizes,
        description: "Avatar sizes",
        variations: [
          %Variation{
            id: :xs,
            attributes: %{src: "https://i.pravatar.cc/150?img=2", size: "xs"}
          },
          %Variation{
            id: :sm,
            attributes: %{src: "https://i.pravatar.cc/150?img=2", size: "sm"}
          },
          %Variation{
            id: :md,
            attributes: %{src: "https://i.pravatar.cc/150?img=2", size: "md"}
          },
          %Variation{
            id: :lg,
            attributes: %{src: "https://i.pravatar.cc/150?img=2", size: "lg"}
          },
          %Variation{
            id: :xl,
            attributes: %{src: "https://i.pravatar.cc/150?img=2", size: "xl"}
          }
        ]
      },
      %VariationGroup{
        id: :shapes,
        description: "Avatar shapes",
        variations: [
          %Variation{
            id: :circle,
            attributes: %{src: "https://i.pravatar.cc/150?img=3", shape: "circle"}
          },
          %Variation{
            id: :rounded,
            attributes: %{src: "https://i.pravatar.cc/150?img=3", shape: "rounded"}
          },
          %Variation{
            id: :square,
            attributes: %{src: "https://i.pravatar.cc/150?img=3", shape: "square"}
          }
        ]
      },
      %VariationGroup{
        id: :status,
        description: "Avatar with status",
        variations: [
          %Variation{
            id: :online,
            attributes: %{src: "https://i.pravatar.cc/150?img=4", status: "online"}
          },
          %Variation{
            id: :offline,
            attributes: %{src: "https://i.pravatar.cc/150?img=5", status: "offline"}
          }
        ]
      },
      %VariationGroup{
        id: :ring,
        description: "Avatar with ring",
        variations: [
          %Variation{
            id: :primary_ring,
            attributes: %{src: "https://i.pravatar.cc/150?img=6", ring: true}
          },
          %Variation{
            id: :secondary_ring,
            attributes: %{src: "https://i.pravatar.cc/150?img=7", ring: true, ring_color: "secondary"}
          }
        ]
      }
    ]
  end
end
