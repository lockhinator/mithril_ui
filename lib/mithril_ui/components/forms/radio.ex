defmodule MithrilUI.Components.Radio do
  @moduledoc """
  Radio button component for selecting one option from a group.

  ## Examples

  Basic usage:
      <.radio name="plan" value="basic" label="Basic Plan" />
      <.radio name="plan" value="pro" label="Pro Plan" />
      <.radio name="plan" value="enterprise" label="Enterprise Plan" />

  With form field:
      <.radio field={@form[:plan]} value="basic" label="Basic Plan" />

  Pre-selected:
      <.radio name="color" value="red" label="Red" checked={true} />

  Disabled:
      <.radio name="tier" value="premium" label="Premium (Coming Soon)" disabled={true} />
  """

  use Phoenix.Component
  import MithrilUI.Helpers, only: [translate_error: 1]

  @doc """
  Renders a radio button input with label.

  ## Attributes

    * `:id` - Input element ID
    * `:name` - Input name attribute (required)
    * `:label` - Label text (required)
    * `:value` - Radio value (required)
    * `:checked` - Whether radio is selected (default: false)
    * `:field` - Phoenix form field struct
    * `:disabled` - Disable the input
    * `:class` - Additional CSS classes for the radio
    * Global attributes are passed through

  ## Slots

  None.
  """
  @spec radio(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :any, default: nil
  attr :name, :any
  attr :label, :string, required: true
  attr :value, :any, required: true
  attr :checked, :boolean, default: false
  attr :field, Phoenix.HTML.FormField, doc: "Form field struct"
  attr :errors, :list, default: []
  attr :disabled, :boolean, default: false
  attr :class, :string, default: nil
  attr :rest, :global

  def radio(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(:id, assigns.id || "#{field.id}_#{assigns.value}")
    |> assign(:name, field.name)
    |> assign(:checked, to_string(field.value) == to_string(assigns.value))
    |> assign(:errors, Enum.map(field.errors, &translate_error/1))
    |> assign(:field, nil)
    |> radio()
  end

  def radio(assigns) do
    ~H"""
    <div class="form-control">
      <label class="label cursor-pointer justify-start gap-3">
        <input
          type="radio"
          id={@id}
          name={@name}
          value={@value}
          checked={@checked}
          disabled={@disabled}
          class={[
            "radio radio-primary",
            @errors != [] && "radio-error",
            @class
          ]}
          aria-invalid={@errors != []}
          {@rest}
        />
        <span class="label-text"><%= @label %></span>
      </label>
    </div>
    """
  end
end
