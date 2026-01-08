defmodule MithrilUI.Components.FileInput do
  @moduledoc """
  File input component for uploading files.

  ## Examples

  Basic usage:
      <.file_input name="avatar" label="Profile Picture" />

  With accept filter:
      <.file_input name="document" accept=".pdf,.doc,.docx" />

  Multiple files:
      <.file_input name="photos" multiple />

  With form field:
      <.file_input field={@form[:avatar]} label="Avatar" />
  """

  use Phoenix.Component
  import MithrilUI.Helpers, only: [translate_error: 1]

  @doc """
  Renders a file input.

  ## Attributes

    * `:id` - Input element ID
    * `:name` - Input name attribute
    * `:label` - Label text displayed above the input
    * `:field` - Phoenix form field struct
    * `:errors` - List of error messages
    * `:help_text` - Helper text shown below input
    * `:accept` - Accepted file types (e.g., ".jpg,.png" or "image/*")
    * `:multiple` - Allow multiple file selection
    * `:disabled` - Disable the input
    * `:required` - Mark as required
    * `:class` - Additional CSS classes
    * Global attributes are passed through

  ## Slots

  None.
  """
  @spec file_input(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :any, default: nil
  attr :name, :any
  attr :label, :string, default: nil
  attr :field, Phoenix.HTML.FormField, doc: "Form field struct"
  attr :errors, :list, default: []
  attr :help_text, :string, default: nil
  attr :accept, :string, default: nil, doc: "Accepted file types"
  attr :multiple, :boolean, default: false, doc: "Allow multiple files"
  attr :disabled, :boolean, default: false
  attr :required, :boolean, default: false
  attr :class, :string, default: nil
  attr :rest, :global

  def file_input(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(:id, assigns.id || field.id)
    |> assign(:name, field.name)
    |> assign(:errors, Enum.map(field.errors, &translate_error/1))
    |> assign(:field, nil)
    |> file_input()
  end

  def file_input(assigns) do
    ~H"""
    <div class={["form-control w-full", @class]}>
      <label :if={@label} for={@id} class="label">
        <span class="label-text">
          <%= @label %>
          <span :if={@required} class="text-error">*</span>
        </span>
      </label>

      <input
        type="file"
        id={@id}
        name={@name}
        accept={@accept}
        multiple={@multiple}
        disabled={@disabled}
        required={@required}
        class={[
          "file-input file-input-bordered w-full",
          @errors != [] && "file-input-error"
        ]}
        aria-invalid={@errors != []}
        aria-describedby={@errors != [] && "#{@id}-error"}
        {@rest}
      />

      <div :if={@help_text && @errors == []} class="label">
        <span class="label-text-alt text-base-content/70"><%= @help_text %></span>
      </div>

      <div :if={@errors != []} id={"#{@id}-error"} class="label">
        <span :for={error <- @errors} class="label-text-alt text-error">
          <%= error %>
        </span>
      </div>
    </div>
    """
  end
end
