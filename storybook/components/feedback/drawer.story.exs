defmodule Storybook.Components.Feedback.Drawer do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Drawer.drawer/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="h-52 w-full max-w-lg relative overflow-hidden rounded-lg border border-base-300" psb-code-hidden>
      <.psb-variation/>
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :basic,
        description: "Basic drawers",
        variations: [
          %Variation{
            id: :left,
            attributes: %{id: "drawer-basic-left", side: "left"},
            slots: [
              """
              <:trigger>
                <span class="btn btn-primary absolute right-4 top-4">Open Left Drawer</span>
              </:trigger>
              <ul class="menu p-4 w-64 h-full bg-base-200">
                <li><a>Home</a></li>
                <li><a>About</a></li>
                <li><a>Contact</a></li>
              </ul>
              """
            ]
          },
          %Variation{
            id: :right,
            attributes: %{id: "drawer-basic-right", side: "right"},
            slots: [
              """
              <:trigger>
                <span class="btn btn-secondary absolute left-4 top-4">Open Right Drawer</span>
              </:trigger>
              <div class="p-4 w-64 h-full bg-base-200">
                <h2 class="text-xl font-bold mb-4">Settings</h2>
                <p>Drawer content here</p>
              </div>
              """
            ]
          }
        ]
      }
    ]
  end
end
