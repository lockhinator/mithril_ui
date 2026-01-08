defmodule MithrilUI.Components.Textarea do
  @moduledoc """
  Textarea component for multiline text input.

  Provides a styled textarea with support for labels, help text, validation errors,
  and various states like disabled and readonly.

  ## Examples

  Basic usage:
      <.textarea name="description" placeholder="Enter description..." />

  With form field:
      <.textarea field={@form[:description]} label="Description" />

  With help text and rows:
      <.textarea
        field={@form[:bio]}
        label="Bio"
        help_text="Tell us about yourself"
        rows={5}
      />

  Disabled state:
      <.textarea name="notes" label="Notes" disabled />
  """

  use Phoenix.Component
  import MithrilUI.Helpers, only: [translate_error: 1]

  @doc """
  Renders a textarea input with label and error messages.

  ## Attributes

    * `:id` - Textarea element ID
    * `:name` - Textarea name attribute
    * `:label` - Label text displayed above the textarea
    * `:value` - Current value
    * `:field` - Phoenix form field struct
    * `:errors` - List of error messages
    * `:help_text` - Helper text displayed below the textarea
    * `:placeholder` - Placeholder text
    * `:required` - Whether the field is required
    * `:disabled` - Disable the textarea
    * `:readonly` - Make the textarea read-only
    * `:rows` - Number of visible text rows (default: 3)
    * `:class` - Additional CSS classes for the textarea
    * Global attributes are passed through (autocomplete, autofocus, minlength, maxlength, etc.)

  ## Slots

  None.
  """
  @spec textarea(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :any, default: nil
  attr :name, :any
  attr :label, :string, default: nil
  attr :value, :any, default: nil
  attr :field, Phoenix.HTML.FormField, doc: "Form field struct"
  attr :errors, :list, default: []
  attr :help_text, :string, default: nil
  attr :placeholder, :string, default: nil
  attr :required, :boolean, default: false
  attr :disabled, :boolean, default: false
  attr :readonly, :boolean, default: false
  attr :rows, :integer, default: 3
  attr :class, :any, default: nil
  attr :rest, :global, include: ~w(autocomplete autofocus minlength maxlength form wrap)

  def textarea(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    errors = if Phoenix.Component.used_input?(field), do: field.errors, else: []

    assigns
    |> assign(:id, assigns.id || field.id)
    |> assign(:name, field.name)
    |> assign(:value, field.value)
    |> assign(:errors, Enum.map(errors, &translate_error/1))
    |> assign(:field, nil)
    |> textarea()
  end

  def textarea(assigns) do
    ~H"""
    <div class="form-control w-full">
      <label :if={@label} for={@id} class="label">
        <span class="label-text">
          {@label}{if @required, do: " *"}
        </span>
      </label>

      <textarea
        id={@id}
        name={@name}
        placeholder={@placeholder}
        rows={@rows}
        required={@required}
        disabled={@disabled}
        readonly={@readonly}
        class={[
          "textarea textarea-bordered w-full",
          @errors != [] && "textarea-error",
          @class
        ]}
        aria-invalid={@errors != []}
        aria-describedby={aria_describedby(@id, @help_text, @errors)}
        aria-required={@required}
        {@rest}
      ><%= Phoenix.HTML.Form.normalize_value("textarea", @value) %></textarea>

      <div :if={@help_text && @errors == []} id={"#{@id}-help"} class="label">
        <span class="label-text-alt text-base-content/70">{@help_text}</span>
      </div>

      <div :if={@errors != []} id={"#{@id}-errors"} class="label" role="alert">
        <span :for={error <- @errors} class="label-text-alt text-error">
          {error}
        </span>
      </div>
    </div>
    """
  end

  defp aria_describedby(id, help_text, errors) do
    cond do
      errors != [] -> "#{id}-errors"
      help_text != nil -> "#{id}-help"
      true -> nil
    end
  end
end
