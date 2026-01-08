defmodule Storybook.Components.Overlays.Popover do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Popover.popover/1

  def description do
    """
    Popover component for displaying rich contextual content.

    Popovers are similar to tooltips but can contain more complex content
    including titles, descriptions, actions, and custom HTML. They support
    hover, click, and programmatic control triggers.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Basic hover popover",
        slots: [
          """
          <:trigger>
            <button class="btn">Hover me</button>
          </:trigger>
          <:content>
            <p>This is the popover content.</p>
          </:content>
          """
        ]
      },
      %Variation{
        id: :with_title,
        description: "Popover with title",
        slots: [
          """
          <:trigger>
            <button class="btn">With Title</button>
          </:trigger>
          <:title>Popover Title</:title>
          <:content>
            <p>This popover has a title header.</p>
          </:content>
          """
        ]
      },
      %Variation{
        id: :with_footer,
        description: "Popover with footer actions",
        slots: [
          """
          <:trigger>
            <button class="btn">With Footer</button>
          </:trigger>
          <:title>User Profile</:title>
          <:content>
            <div class="flex items-center gap-3">
              <div class="avatar placeholder">
                <div class="bg-neutral text-neutral-content rounded-full w-12">
                  <span>JD</span>
                </div>
              </div>
              <div>
                <p class="font-semibold">John Doe</p>
                <p class="text-xs text-base-content/60">john@example.com</p>
              </div>
            </div>
          </:content>
          <:footer>
            <div class="flex gap-2">
              <button class="btn btn-sm btn-primary">Follow</button>
              <button class="btn btn-sm btn-ghost">Message</button>
            </div>
          </:footer>
          """
        ]
      },
      %VariationGroup{
        id: :positions,
        description: "Popover positions",
        variations: [
          %Variation{
            id: :top,
            attributes: %{position: :top},
            slots: [
              """
              <:trigger><button class="btn">Top</button></:trigger>
              <:content>Popover on top</:content>
              """
            ]
          },
          %Variation{
            id: :bottom,
            attributes: %{position: :bottom},
            slots: [
              """
              <:trigger><button class="btn">Bottom</button></:trigger>
              <:content>Popover on bottom</:content>
              """
            ]
          },
          %Variation{
            id: :left,
            attributes: %{position: :left},
            slots: [
              """
              <:trigger><button class="btn">Left</button></:trigger>
              <:content>Popover on left</:content>
              """
            ]
          },
          %Variation{
            id: :right,
            attributes: %{position: :right},
            slots: [
              """
              <:trigger><button class="btn">Right</button></:trigger>
              <:content>Popover on right</:content>
              """
            ]
          }
        ]
      },
      %Variation{
        id: :help_icon,
        description: "Help icon popover",
        attributes: %{position: :right},
        slots: [
          """
          <:trigger>
            <button class="btn btn-circle btn-ghost btn-sm">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-8-3a1 1 0 00-.867.5 1 1 0 11-1.731-1A3 3 0 0113 8a3.001 3.001 0 01-2 2.83V11a1 1 0 11-2 0v-1a1 1 0 011-1 1 1 0 100-2zm0 8a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd" />
              </svg>
            </button>
          </:trigger>
          <:title>Need Help?</:title>
          <:content>
            <p>Click here to learn more about this feature.</p>
            <p class="mt-2 text-xs text-base-content/60">Press ESC to close.</p>
          </:content>
          """
        ]
      },
      %Variation{
        id: :rich_content,
        description: "Popover with rich content",
        slots: [
          """
          <:trigger>
            <button class="btn">Rich Content</button>
          </:trigger>
          <:title>Product Details</:title>
          <:content>
            <div class="space-y-2">
              <div class="flex justify-between">
                <span class="text-base-content/60">Price:</span>
                <span class="font-semibold">$99.99</span>
              </div>
              <div class="flex justify-between">
                <span class="text-base-content/60">Stock:</span>
                <span class="badge badge-success badge-sm">In Stock</span>
              </div>
              <div class="flex justify-between">
                <span class="text-base-content/60">Rating:</span>
                <span>⭐⭐⭐⭐⭐</span>
              </div>
            </div>
          </:content>
          <:footer>
            <button class="btn btn-primary btn-sm btn-block">Add to Cart</button>
          </:footer>
          """
        ]
      }
    ]
  end
end
