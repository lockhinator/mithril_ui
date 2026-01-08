defmodule Storybook.Components.Extended.Stepper do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Stepper.steps/1

  def description do
    """
    Stepper component for displaying multi-step progress indicators.
    Supports horizontal/vertical layouts, completion states, and
    various styling options.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Basic steps",
        slots: [
          """
          <MithrilUI.Components.Stepper.step status="complete">Register</MithrilUI.Components.Stepper.step>
          <MithrilUI.Components.Stepper.step status="current">Choose plan</MithrilUI.Components.Stepper.step>
          <MithrilUI.Components.Stepper.step>Purchase</MithrilUI.Components.Stepper.step>
          <MithrilUI.Components.Stepper.step>Receive Product</MithrilUI.Components.Stepper.step>
          """
        ]
      },
      %Variation{
        id: :vertical,
        description: "Vertical steps",
        attributes: %{vertical: true},
        slots: [
          """
          <MithrilUI.Components.Stepper.step status="complete">Step 1</MithrilUI.Components.Stepper.step>
          <MithrilUI.Components.Stepper.step status="current">Step 2</MithrilUI.Components.Stepper.step>
          <MithrilUI.Components.Stepper.step>Step 3</MithrilUI.Components.Stepper.step>
          """
        ]
      },
      %VariationGroup{
        id: :colors,
        description: "Step colors",
        variations: [
          %Variation{
            id: :primary,
            slots: [
              """
              <MithrilUI.Components.Stepper.step status="complete" color="primary">Done</MithrilUI.Components.Stepper.step>
              <MithrilUI.Components.Stepper.step>Pending</MithrilUI.Components.Stepper.step>
              """
            ]
          },
          %Variation{
            id: :success,
            slots: [
              """
              <MithrilUI.Components.Stepper.step status="complete" color="success">Done</MithrilUI.Components.Stepper.step>
              <MithrilUI.Components.Stepper.step>Pending</MithrilUI.Components.Stepper.step>
              """
            ]
          },
          %Variation{
            id: :accent,
            slots: [
              """
              <MithrilUI.Components.Stepper.step status="complete" color="accent">Done</MithrilUI.Components.Stepper.step>
              <MithrilUI.Components.Stepper.step>Pending</MithrilUI.Components.Stepper.step>
              """
            ]
          }
        ]
      },
      %Variation{
        id: :with_content,
        description: "Steps with custom content",
        slots: [
          """
          <MithrilUI.Components.Stepper.step status="complete" data_content="✓">Verified</MithrilUI.Components.Stepper.step>
          <MithrilUI.Components.Stepper.step status="current" data_content="●">Processing</MithrilUI.Components.Stepper.step>
          <MithrilUI.Components.Stepper.step data_content="○">Pending</MithrilUI.Components.Stepper.step>
          """
        ]
      }
    ]
  end
end
