defmodule MithrilUI.Components.Checkbox do
  @moduledoc """
  Checkbox component for boolean selection.

  ## Examples

  Basic usage:
      <.checkbox name="terms" label="I agree to the terms" />

  With form field:
      <.checkbox field={@form[:subscribe]} label="Subscribe to newsletter" />

  Checked by default:
      <.checkbox name="active" label="Active" checked={true} />

  Disabled:
      <.checkbox name="locked" label="Locked option" disabled={true} />
  """

  use Phoenix.Component
  import MithrilUI.Helpers, only: [translate_error: 1]

  @doc """
  Renders a checkbox input with label.

  ## Attributes

    * `:id` - Input element ID
    * `:name` - Input name attribute
    * `:label` - Label text (required)
    * `:value` - Value when checked (default: "true")
    * `:checked` - Whether checkbox is checked (default: false)
    * `:field` - Phoenix form field struct
    * `:errors` - List of error messages
    * `:disabled` - Disable the input
    * `:class` - Additional CSS classes for the checkbox
    * Global attributes are passed through

  ## Slots

  None.
  """
  @spec checkbox(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :any, default: nil
  attr :name, :any
  attr :label, :string, required: true
  attr :value, :any, default: "true"
  attr :checked, :boolean, default: false
  attr :field, Phoenix.HTML.FormField, doc: "Form field struct"
  attr :errors, :list, default: []
  attr :disabled, :boolean, default: false
  attr :class, :string, default: nil
  attr :rest, :global

  def checkbox(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(:id, assigns.id || field.id)
    |> assign(:name, field.name)
    |> assign(:checked, Phoenix.HTML.Form.normalize_value("checkbox", field.value))
    |> assign(:errors, Enum.map(field.errors, &translate_error/1))
    |> assign(:field, nil)
    |> checkbox()
  end

  def checkbox(assigns) do
    ~H"""
    <div class="form-control">
      <label class="label cursor-pointer justify-start gap-3">
        <input type="hidden" name={@name} value="false" disabled={@disabled} />
        <input
          type="checkbox"
          id={@id}
          name={@name}
          value={@value}
          checked={@checked}
          disabled={@disabled}
          class={[
            "checkbox checkbox-primary",
            @errors != [] && "checkbox-error",
            @class
          ]}
          aria-invalid={@errors != []}
          aria-describedby={@errors != [] && "#{@id}-error"}
          {@rest}
        />
        <span class="label-text"><%= @label %></span>
      </label>

      <div :if={@errors != []} id={"#{@id}-error"} class="label pt-0">
        <span :for={error <- @errors} class="label-text-alt text-error">
          <%= error %>
        </span>
      </div>
    </div>
    """
  end
end
