defmodule Storybook.Components.Feedback.Modal do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Modal.modal/1
  def render_source, do: :function
  def layout, do: :one_column

  def imports do
    [{MithrilUI.Components.Modal, [show_modal: 1]}]
  end

  def template do
    """
    <div class="flex flex-col gap-4">
      <button class="btn btn-primary" phx-click={show_modal(":variation_id")}>
        Open Modal
      </button>
      <.psb-variation/>
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :basic,
        description: "Basic modals",
        variations: [
          %Variation{
            id: :simple,
            attributes: %{id: "modal-basic-simple"},
            slots: [
              """
              <:title>Modal Title</:title>
              <p>This is the modal content. You can put any content here.</p>
              <:actions>
                <button class="btn">Close</button>
              </:actions>
              """
            ]
          }
        ]
      },
      %VariationGroup{
        id: :with_actions,
        description: "Modals with action buttons",
        variations: [
          %Variation{
            id: :confirm,
            attributes: %{id: "modal-with_actions-confirm"},
            slots: [
              """
              <:title>Confirm Action</:title>
              <p>Are you sure you want to proceed? This action cannot be undone.</p>
              <:actions>
                <button class="btn">Cancel</button>
                <button class="btn btn-primary">Confirm</button>
              </:actions>
              """
            ]
          },
          %Variation{
            id: :delete,
            attributes: %{id: "modal-with_actions-delete"},
            slots: [
              """
              <:title>Delete Item</:title>
              <p>This will permanently delete the selected item.</p>
              <:actions>
                <button class="btn">Cancel</button>
                <button class="btn btn-error">Delete</button>
              </:actions>
              """
            ]
          }
        ]
      }
    ]
  end
end
