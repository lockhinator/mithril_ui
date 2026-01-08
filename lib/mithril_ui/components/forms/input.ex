defmodule MithrilUI.Components.Input do
  @moduledoc """
  A versatile input component for forms with full Phoenix.HTML.FormField integration.

  Supports all common HTML5 input types and integrates seamlessly with Phoenix forms,
  automatically extracting field values and displaying validation errors.

  ## Examples

  Basic text input:

      <.input name="username" placeholder="Enter your username" />

  With form field integration:

      <.input field={@form[:email]} type="email" label="Email Address" />

  Password input with help text:

      <.input
        field={@form[:password]}
        type="password"
        label="Password"
        help_text="Must be at least 8 characters"
      />

  Disabled input:

      <.input name="readonly_field" value="Cannot edit" disabled />

  ## DaisyUI Classes

  The component uses the following DaisyUI classes:
  - `input` - Base input styling
  - `input-bordered` - Adds border styling
  - `input-error` - Applied when there are validation errors
  - `input-disabled` - Applied when disabled

  ## Accessibility

  - Labels are properly associated with inputs via `for` attribute
  - Error messages are linked via `aria-describedby`
  - Invalid state is indicated via `aria-invalid`
  - Required fields are marked with `aria-required`
  """

  use Phoenix.Component
  import MithrilUI.Helpers, only: [translate_error: 1]

  @input_types ~w(text email password number tel url search date time datetime-local hidden)

  @doc """
  Renders a styled input field with optional label, help text, and error display.

  ## Attributes

    * `:id` - The DOM id for the input element. Defaults to the field id when using form fields.
    * `:name` - The input name attribute. Required unless using `field`.
    * `:label` - Optional label text displayed above the input.
    * `:value` - The input value.
    * `:type` - The input type. Defaults to "text".
      Supported types: #{Enum.join(@input_types, ", ")}.
    * `:field` - A Phoenix.HTML.FormField struct for form integration.
    * `:errors` - List of error tuples or strings to display.
    * `:help_text` - Optional help text displayed below the input.
    * `:required` - Whether the field is required. Defaults to false.
    * `:disabled` - Whether the input is disabled. Defaults to false.
    * `:readonly` - Whether the input is read-only. Defaults to false.
    * `:placeholder` - Placeholder text for the input.
    * `:class` - Additional CSS classes for the input element.
    * Global attributes like `autocomplete`, `autofocus`, `min`, `max`, etc. are passed through.

  ## Examples

      <.input type="email" name="user_email" label="Email" required />

      <.input field={@form[:name]} label="Full Name" placeholder="John Doe" />
  """
  @spec input(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :any, default: nil
  attr :name, :any
  attr :label, :string, default: nil
  attr :value, :any, default: nil

  attr :type, :string,
    default: "text",
    values: @input_types,
    doc: "The type of input to render"

  attr :field, Phoenix.HTML.FormField,
    default: nil,
    doc: "A form field struct from Phoenix.HTML.Form"

  attr :errors, :list, default: [], doc: "List of error messages to display"
  attr :help_text, :string, default: nil, doc: "Help text displayed below the input"
  attr :required, :boolean, default: false, doc: "Whether the field is required"
  attr :disabled, :boolean, default: false, doc: "Whether the input is disabled"
  attr :readonly, :boolean, default: false, doc: "Whether the input is read-only"
  attr :placeholder, :string, default: nil, doc: "Placeholder text"
  attr :class, :string, default: nil, doc: "Additional CSS classes for the input"

  attr :rest, :global,
    include: ~w(autocomplete autofocus min max minlength maxlength pattern step inputmode list form)

  def input(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    errors = if Phoenix.Component.used_input?(field), do: field.errors, else: []

    assigns
    |> assign(:id, assigns.id || field.id)
    |> assign(:name, field.name)
    |> assign(:value, field.value)
    |> assign(:errors, Enum.map(errors, &translate_error/1))
    |> assign(:field, nil)
    |> input()
  end

  def input(%{type: "hidden"} = assigns) do
    ~H"""
    <input
      type="hidden"
      id={@id}
      name={@name}
      value={@value}
      {@rest}
    />
    """
  end

  def input(assigns) do
    assigns = assign_new(assigns, :error_id, fn ->
      if assigns.errors != [] and assigns.id do
        "#{assigns.id}-error"
      end
    end)

    assigns = assign_new(assigns, :help_id, fn ->
      if assigns.help_text && assigns.id do
        "#{assigns.id}-help"
      end
    end)

    ~H"""
    <div class="form-control w-full">
      <label :if={@label} for={@id} class="label">
        <span class="label-text">
          <%= @label %>
          <span :if={@required} class="text-error ml-1" aria-hidden="true">*</span>
        </span>
      </label>

      <input
        type={@type}
        id={@id}
        name={@name}
        value={@value}
        placeholder={@placeholder}
        disabled={@disabled}
        readonly={@readonly}
        required={@required}
        class={input_classes(@errors, @disabled, @class)}
        aria-invalid={@errors != []}
        aria-required={@required}
        aria-describedby={described_by(@error_id, @help_id)}
        {@rest}
      />

      <div :if={@help_text && @errors == []} class="label" id={@help_id}>
        <span class="label-text-alt text-base-content/70"><%= @help_text %></span>
      </div>

      <div :if={@errors != []} class="label" id={@error_id}>
        <span :for={error <- @errors} class="label-text-alt text-error text-sm">
          <%= error %>
        </span>
      </div>
    </div>
    """
  end

  defp input_classes(errors, disabled, extra_class) do
    [
      "input input-bordered w-full",
      errors != [] && "input-error",
      disabled && "input-disabled",
      extra_class
    ]
  end

  defp described_by(nil, nil), do: nil
  defp described_by(error_id, nil), do: error_id
  defp described_by(nil, help_id), do: help_id
  defp described_by(error_id, help_id), do: "#{error_id} #{help_id}"
end
