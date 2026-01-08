defmodule MithrilUI.Components.Stepper do
  @moduledoc """
  Stepper component for displaying multi-step progress indicators.

  ## Examples

  Basic stepper:

      <.steps>
        <.step status="complete">Register</.step>
        <.step status="current">Choose plan</.step>
        <.step>Purchase</.step>
      </.steps>

  Vertical stepper:

      <.steps vertical>
        <.step status="complete">Step 1</.step>
        <.step status="current">Step 2</.step>
      </.steps>

  ## DaisyUI Classes

  - `steps` - Container class
  - `step` - Individual step class
  - `step-{color}` - Step color variants
  - `steps-vertical` - Vertical layout
  - `steps-horizontal` - Horizontal layout
  """

  use Phoenix.Component

  @colors ~w(primary secondary accent neutral info success warning error)
  @statuses ~w(pending current complete)

  @doc """
  Renders a steps container.

  ## Attributes

    * `:vertical` - Display steps vertically. Defaults to false.
    * `:responsive` - Switch to horizontal on larger screens. Defaults to false.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Step components (required).

  ## Examples

      <.steps>
        <.step>Step 1</.step>
        <.step>Step 2</.step>
      </.steps>

      <.steps vertical>
        <.step status="complete">Done</.step>
        <.step status="current">In Progress</.step>
      </.steps>
  """
  @spec steps(map()) :: Phoenix.LiveView.Rendered.t()

  attr :vertical, :boolean, default: false
  attr :responsive, :boolean, default: false
  attr :class, :string, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def steps(assigns) do
    ~H"""
    <ul
      class={[
        "steps",
        @vertical && "steps-vertical",
        @responsive && "steps-vertical lg:steps-horizontal",
        @class
      ]}
      {@rest}
    >
      {render_slot(@inner_block)}
    </ul>
    """
  end

  @doc """
  Renders an individual step.

  ## Attributes

    * `:status` - Step status: pending, current, complete. Defaults to "pending".
    * `:color` - Step color when active/complete.
    * `:icon` - Custom icon content for the step indicator.
    * `:data_content` - Custom content to show in step circle (e.g., checkmark).
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Step label content (required).

  ## Examples

      <.step status="complete">Register</.step>

      <.step status="current" color="primary">Choose plan</.step>

      <.step data_content="✓" status="complete">Done</.step>
  """
  @spec step(map()) :: Phoenix.LiveView.Rendered.t()

  attr :status, :string, default: "pending", values: @statuses
  attr :color, :string, default: nil, values: @colors ++ [nil]
  attr :data_content, :string, default: nil
  attr :class, :string, default: nil
  attr :rest, :global

  slot :icon
  slot :inner_block, required: true

  def step(assigns) do
    color = step_color(assigns.status, assigns.color)
    assigns = assign(assigns, :computed_color, color)

    ~H"""
    <li
      class={[
        "step",
        @computed_color && "step-#{@computed_color}",
        @class
      ]}
      data-content={@data_content}
      {@rest}
    >
      <span :if={@icon != []} class="step-icon">
        {render_slot(@icon)}
      </span>
      {render_slot(@inner_block)}
    </li>
    """
  end

  defp step_color("complete", nil), do: "primary"
  defp step_color("current", nil), do: "primary"
  defp step_color("pending", nil), do: nil
  defp step_color(_, color), do: color

  @doc """
  Renders a detailed stepper with numbers, titles, and descriptions.

  ## Attributes

    * `:steps` - List of step maps with :title, :description, and optional :status.
    * `:current` - Current step index (0-based).
    * `:vertical` - Display vertically. Defaults to false.
    * `:class` - Additional CSS classes.

  ## Examples

      <.detailed_steps
        steps={[
          %{title: "Account", description: "Create your account"},
          %{title: "Profile", description: "Set up your profile"},
          %{title: "Complete", description: "Start using the app"}
        ]}
        current={1}
      />
  """
  @spec detailed_steps(map()) :: Phoenix.LiveView.Rendered.t()

  attr :steps, :list, required: true
  attr :current, :integer, default: 0
  attr :vertical, :boolean, default: false
  attr :class, :string, default: nil
  attr :rest, :global

  def detailed_steps(assigns) do
    ~H"""
    <ol
      class={[
        "flex",
        if(@vertical, do: "flex-col space-y-4", else: "items-center space-x-4 sm:space-x-8"),
        @class
      ]}
      {@rest}
    >
      <%= for {step, index} <- Enum.with_index(@steps) do %>
        <li class={["flex items-center", !@vertical && index < length(@steps) - 1 && "flex-1"]}>
          <span class={[
            "flex items-center justify-center w-8 h-8 rounded-full shrink-0",
            cond do
              index < @current -> "bg-primary text-primary-content"
              index == @current -> "bg-primary text-primary-content"
              true -> "bg-base-300 text-base-content"
            end
          ]}>
            <%= if index < @current do %>
              <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                <path
                  fill-rule="evenodd"
                  d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                  clip-rule="evenodd"
                />
              </svg>
            <% else %>
              {index + 1}
            <% end %>
          </span>
          <div class="ml-3">
            <p class={[
              "text-sm font-medium",
              if(index <= @current, do: "text-base-content", else: "text-base-content/60")
            ]}>
              {step.title}
            </p>
            <p :if={Map.has_key?(step, :description)} class="text-xs text-base-content/60">
              {step.description}
            </p>
          </div>
          <div
            :if={!@vertical && index < length(@steps) - 1}
            class="hidden sm:flex flex-1 mx-4 h-0.5 bg-base-300"
          >
            <div class={[
              "h-full bg-primary transition-all",
              if(index < @current, do: "w-full", else: "w-0")
            ]} />
          </div>
        </li>
      <% end %>
    </ol>
    """
  end

  @doc """
  Renders a breadcrumb-style stepper for wizard navigation.

  ## Attributes

    * `:steps` - List of step labels.
    * `:current` - Current step index (0-based).
    * `:class` - Additional CSS classes.

  ## Examples

      <.breadcrumb_steps steps={["Cart", "Shipping", "Payment", "Review"]} current={2} />
  """
  @spec breadcrumb_steps(map()) :: Phoenix.LiveView.Rendered.t()

  attr :steps, :list, required: true
  attr :current, :integer, default: 0
  attr :class, :string, default: nil
  attr :rest, :global

  def breadcrumb_steps(assigns) do
    ~H"""
    <nav class={["flex items-center", @class]} aria-label="Progress" {@rest}>
      <%= for {step, index} <- Enum.with_index(@steps) do %>
        <div class="flex items-center">
          <span class={[
            "flex items-center justify-center w-6 h-6 rounded-full text-xs font-medium",
            cond do
              index < @current -> "bg-primary text-primary-content"
              index == @current -> "bg-primary text-primary-content"
              true -> "bg-base-300 text-base-content"
            end
          ]}>
            {index + 1}
          </span>
          <span class={[
            "ml-2 text-sm",
            if(index <= @current, do: "font-medium text-base-content", else: "text-base-content/60")
          ]}>
            {step}
          </span>
          <svg
            :if={index < length(@steps) - 1}
            class="w-4 h-4 mx-4 text-base-content/40 rtl:rotate-180"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
          </svg>
        </div>
      <% end %>
    </nav>
    """
  end
end
