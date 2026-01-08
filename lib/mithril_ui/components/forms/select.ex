defmodule MithrilUI.Components.Select do
  @moduledoc """
  Select dropdown component for choosing one or more options from a list.

  Supports single and multiple selection modes, integration with Phoenix forms,
  and automatic error display.

  ## Examples

  Basic usage with tuple options:

      <.select
        name="country"
        label="Country"
        options={[{"United States", "us"}, {"Canada", "ca"}, {"Mexico", "mx"}]}
      />

  With simple value options:

      <.select name="color" options={["Red", "Green", "Blue"]} />

  With form field integration:

      <.select field={@form[:role]} options={[{"Admin", "admin"}, {"User", "user"}]} />

  Multiple selection:

      <.select
        name="tags[]"
        label="Tags"
        options={[{"Elixir", "elixir"}, {"Phoenix", "phoenix"}, {"LiveView", "liveview"}]}
        multiple
      />

  With prompt placeholder:

      <.select
        name="category"
        options={[{"Books", "books"}, {"Electronics", "electronics"}]}
        prompt="Select a category"
      />
  """

  use Phoenix.Component
  import MithrilUI.Helpers, only: [translate_error: 1]

  @doc """
  Renders a select dropdown input.

  ## Attributes

    * `:id` - Select element ID
    * `:name` - Select name attribute
    * `:label` - Label text displayed above the select
    * `:value` - Currently selected value (or list for multiple)
    * `:field` - Phoenix form field struct for automatic integration
    * `:options` - List of options as {label, value} tuples or simple values
    * `:prompt` - Placeholder option displayed when no selection is made
    * `:errors` - List of error messages to display
    * `:help_text` - Helper text displayed below the select
    * `:required` - Mark the field as required
    * `:disabled` - Disable the select
    * `:multiple` - Allow multiple selections
    * `:class` - Additional CSS classes for the wrapper
    * Global attributes are passed through to the select element

  ## Slots

  None.
  """
  @spec select(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :any, default: nil
  attr :name, :any
  attr :label, :string, default: nil
  attr :value, :any, default: nil
  attr :field, Phoenix.HTML.FormField, doc: "Form field struct"
  attr :options, :list, required: true, doc: "List of {label, value} tuples or values"
  attr :prompt, :string, default: nil, doc: "Placeholder option"
  attr :errors, :list, default: []
  attr :help_text, :string, default: nil
  attr :required, :boolean, default: false
  attr :disabled, :boolean, default: false
  attr :multiple, :boolean, default: false
  attr :class, :any, default: nil
  attr :rest, :global

  def select(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(:id, assigns.id || field.id)
    |> assign(:name, field.name)
    |> assign(:value, field.value)
    |> assign(:errors, Enum.map(field.errors, &translate_error/1))
    |> assign(:field, nil)
    |> select()
  end

  def select(assigns) do
    ~H"""
    <div class={["form-control w-full", @class]}>
      <label :if={@label} for={@id} class="label">
        <span class="label-text">
          {@label}
          <span :if={@required} class="text-error" aria-hidden="true">*</span>
        </span>
      </label>

      <select
        id={@id}
        name={@name}
        required={@required}
        disabled={@disabled}
        multiple={@multiple}
        class={[
          "select select-bordered w-full",
          @errors != [] && "select-error"
        ]}
        aria-invalid={@errors != []}
        aria-describedby={(@errors != [] || @help_text) && "#{@id}-description"}
        aria-required={@required}
        {@rest}
      >
        <option :if={@prompt} value="" disabled selected={@value == nil || @value == ""}>
          {@prompt}
        </option>
        <%= for option <- @options do %>
          <% {label, value} = normalize_option(option) %>
          <option value={value} selected={selected?(@value, value)}>
            {label}
          </option>
        <% end %>
      </select>

      <div
        :if={@help_text || @errors != []}
        id={"#{@id}-description"}
        class="label"
      >
        <span :if={@help_text && @errors == []} class="label-text-alt">
          {@help_text}
        </span>
        <span :for={error <- @errors} class="label-text-alt text-error">
          {error}
        </span>
      </div>
    </div>
    """
  end

  @doc false
  defp normalize_option({label, value}), do: {label, value}
  defp normalize_option(value), do: {value, value}

  @doc false
  defp selected?(current, value) when is_list(current) do
    Enum.any?(current, fn v -> to_string(v) == to_string(value) end)
  end

  defp selected?(nil, _value), do: false
  defp selected?(current, value), do: to_string(current) == to_string(value)
end
