defmodule MithrilUI.Components.Toggle do
  @moduledoc """
  Toggle switch component for boolean on/off states.

  Styled like an iOS switch, ideal for settings and preferences.

  ## Examples

  Basic usage:
      <.toggle name="notifications" label="Enable notifications" />

  With form field:
      <.toggle field={@form[:dark_mode]} label="Dark mode" />

  Checked by default:
      <.toggle name="auto_save" label="Auto-save" checked={true} />

  Without label:
      <.toggle name="enabled" />

  Disabled:
      <.toggle name="premium_feature" label="Premium Feature" disabled={true} />
  """

  use Phoenix.Component
  import MithrilUI.Helpers, only: [translate_error: 1]

  @doc """
  Renders a toggle switch input.

  ## Attributes

    * `:id` - Input element ID
    * `:name` - Input name attribute
    * `:label` - Label text (optional)
    * `:checked` - Whether toggle is on (default: false)
    * `:field` - Phoenix form field struct
    * `:errors` - List of error messages
    * `:disabled` - Disable the input
    * `:class` - Additional CSS classes for the toggle
    * Global attributes are passed through

  ## Slots

  None.
  """
  @spec toggle(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :any, default: nil
  attr :name, :any
  attr :label, :string, default: nil
  attr :checked, :boolean, default: false
  attr :field, Phoenix.HTML.FormField, doc: "Form field struct"
  attr :errors, :list, default: []
  attr :disabled, :boolean, default: false
  attr :class, :string, default: nil
  attr :rest, :global

  def toggle(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(:id, assigns.id || field.id)
    |> assign(:name, field.name)
    |> assign(:checked, Phoenix.HTML.Form.normalize_value("checkbox", field.value))
    |> assign(:errors, Enum.map(field.errors, &translate_error/1))
    |> assign(:field, nil)
    |> toggle()
  end

  def toggle(assigns) do
    ~H"""
    <div class="form-control">
      <label class="label cursor-pointer justify-start gap-3">
        <input type="hidden" name={@name} value="false" disabled={@disabled} />
        <input
          type="checkbox"
          id={@id}
          name={@name}
          value="true"
          checked={@checked}
          disabled={@disabled}
          class={[
            "toggle toggle-primary",
            @errors != [] && "toggle-error",
            @class
          ]}
          aria-invalid={@errors != []}
          aria-describedby={@errors != [] && "#{@id}-error"}
          {@rest}
        />
        <span :if={@label} class="label-text"><%= @label %></span>
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
