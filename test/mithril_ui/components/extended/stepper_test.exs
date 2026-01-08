defmodule MithrilUI.Components.StepperTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Stepper

  describe "steps/1" do
    test "renders steps container" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Stepper.steps>
          <Stepper.step>Step 1</Stepper.step>
        </Stepper.steps>
        """)

      assert html =~ "<ul"
      assert html =~ "steps"
    end

    test "renders vertical steps" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Stepper.steps vertical>
          <Stepper.step>Step</Stepper.step>
        </Stepper.steps>
        """)

      assert html =~ "steps-vertical"
    end

    test "renders responsive steps" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Stepper.steps responsive>
          <Stepper.step>Step</Stepper.step>
        </Stepper.steps>
        """)

      assert html =~ "lg:steps-horizontal"
    end
  end

  describe "step/1" do
    test "renders a step" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Stepper.step>Register</Stepper.step>
        """)

      assert html =~ "<li"
      assert html =~ "step"
      assert html =~ "Register"
    end

    test "renders complete step with color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Stepper.step status="complete">Done</Stepper.step>
        """)

      assert html =~ "step-primary"
    end

    test "renders current step with color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Stepper.step status="current">In Progress</Stepper.step>
        """)

      assert html =~ "step-primary"
    end

    test "renders pending step without primary color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Stepper.step status="pending">Pending</Stepper.step>
        """)

      refute html =~ "step-primary"
    end

    test "applies custom color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Stepper.step status="complete" color="success">Done</Stepper.step>
        """)

      assert html =~ "step-success"
    end

    test "renders data-content attribute" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Stepper.step data_content="✓">Done</Stepper.step>
        """)

      assert html =~ ~s(data-content="✓")
    end
  end

  describe "detailed_steps/1" do
    test "renders detailed steps with titles" do
      assigns = %{steps: [%{title: "Account"}, %{title: "Profile"}, %{title: "Complete"}]}

      html =
        rendered_to_string(~H"""
        <Stepper.detailed_steps steps={@steps} current={1} />
        """)

      assert html =~ "Account"
      assert html =~ "Profile"
      assert html =~ "Complete"
    end

    test "renders descriptions" do
      assigns = %{steps: [%{title: "Step 1", description: "First step description"}]}

      html =
        rendered_to_string(~H"""
        <Stepper.detailed_steps steps={@steps} current={0} />
        """)

      assert html =~ "First step description"
    end

    test "renders vertical detailed steps" do
      assigns = %{steps: [%{title: "A"}, %{title: "B"}]}

      html =
        rendered_to_string(~H"""
        <Stepper.detailed_steps steps={@steps} current={0} vertical />
        """)

      assert html =~ "flex-col"
    end
  end

  describe "breadcrumb_steps/1" do
    test "renders breadcrumb-style steps" do
      assigns = %{steps: ["Cart", "Shipping", "Payment", "Review"]}

      html =
        rendered_to_string(~H"""
        <Stepper.breadcrumb_steps steps={@steps} current={2} />
        """)

      assert html =~ "Cart"
      assert html =~ "Shipping"
      assert html =~ "Payment"
      assert html =~ "Review"
    end

    test "shows numbered steps" do
      assigns = %{steps: ["A", "B", "C"]}

      html =
        rendered_to_string(~H"""
        <Stepper.breadcrumb_steps steps={@steps} current={0} />
        """)

      # Numbers rendered with whitespace
      assert html =~ "1"
      assert html =~ "2"
      assert html =~ "3"
    end
  end
end
