defmodule MithrilUI.Components.Range do
  @moduledoc """
  Range slider component for selecting numeric values within a range.

  ## Examples

  Basic usage:
      <.range name="volume" min={0} max={100} value={50} />

  With form field:
      <.range field={@form[:volume]} min={0} max={100} label="Volume" />

  With step:
      <.range name="rating" min={1} max={5} step={1} value={3} />
  """

  use Phoenix.Component
  import MithrilUI.Helpers, only: [translate_error: 1]

  @doc """
  Renders a range slider input.

  ## Attributes

    * `:id` - Input element ID
    * `:name` - Input name attribute
    * `:label` - Label text displayed above the range
    * `:value` - Current value
    * `:min` - Minimum value (default: 0)
    * `:max` - Maximum value (default: 100)
    * `:step` - Step increment (default: 1)
    * `:field` - Phoenix form field struct
    * `:errors` - List of error messages
    * `:show_value` - Whether to display current value (default: false)
    * `:disabled` - Disable the input
    * `:class` - Additional CSS classes
    * Global attributes are passed through

  ## Slots

  None.
  """
  @spec range(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :any, default: nil
  attr :name, :any
  attr :label, :string, default: nil
  attr :value, :any, default: nil
  attr :min, :integer, default: 0
  attr :max, :integer, default: 100
  attr :step, :integer, default: 1
  attr :field, Phoenix.HTML.FormField, doc: "Form field struct"
  attr :errors, :list, default: []
  attr :show_value, :boolean, default: false, doc: "Display current value"
  attr :disabled, :boolean, default: false
  attr :class, :string, default: nil
  attr :rest, :global

  def range(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(:id, assigns.id || field.id)
    |> assign(:name, field.name)
    |> assign(:value, field.value)
    |> assign(:errors, Enum.map(field.errors, &translate_error/1))
    |> assign(:field, nil)
    |> range()
  end

  def range(assigns) do
    ~H"""
    <div class={["form-control w-full", @class]}>
      <label :if={@label || @show_value} for={@id} class="label">
        <span :if={@label} class="label-text"><%= @label %></span>
        <span :if={@show_value} class="label-text-alt"><%= @value || @min %></span>
      </label>

      <input
        type="range"
        id={@id}
        name={@name}
        value={@value || @min}
        min={@min}
        max={@max}
        step={@step}
        disabled={@disabled}
        class={[
          "range",
          @errors != [] && "range-error"
        ]}
        aria-invalid={@errors != []}
        {@rest}
      />

      <div :if={@errors != []} class="label">
        <span :for={error <- @errors} class="label-text-alt text-error">
          <%= error %>
        </span>
      </div>
    </div>
    """
  end
end
