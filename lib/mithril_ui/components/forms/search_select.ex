defmodule MithrilUI.Components.SearchSelect do
  @moduledoc """
  A searchable select dropdown component for choosing from a filterable list of options.

  Supports large option lists, streaming data, real-time search filtering, and
  integration with Phoenix forms.

  ## Examples

  Basic usage with a list of options:

      <.search_select
        id="user-select"
        name="user_id"
        label="Select User"
        options={[%{id: "1", display: "John Doe"}, %{id: "2", display: "Jane Smith"}]}
        placeholder="Search users..."
      />

  With form field integration:

      <.search_select
        field={@form[:user_id]}
        options={@users}
        placeholder="Search users..."
      />

  With streaming/async data (handle filtering in LiveView):

      <.search_select
        id="product-select"
        name="product_id"
        options={@filtered_products}
        placeholder="Search products..."
        phx-change="filter_products"
        phx-target={@myself}
      />

  ## Options Format

  Options should be provided as a list of maps with `:id` and `:display` keys:

      [
        %{id: "value1", display: "Display Text 1"},
        %{id: "value2", display: "Display Text 2"}
      ]

  Alternatively, you can use custom key names with the `value_key` and `display_key` attributes.

  ## LiveView Integration

  For server-side filtering with streaming data, handle the search in your LiveView:

      def handle_event("filter_products", %{"search" => query}, socket) do
        filtered = filter_products(socket.assigns.all_products, query)
        {:noreply, assign(socket, filtered_products: filtered)}
      end
  """

  use Phoenix.Component
  alias Phoenix.LiveView.JS
  import MithrilUI.Helpers, only: [translate_error: 1, unique_id: 1]

  @doc """
  Renders a searchable select dropdown.

  ## Attributes

    * `:id` - Unique identifier for the component (auto-generated if not provided)
    * `:name` - Form input name attribute
    * `:label` - Label text displayed above the input
    * `:value` - Currently selected value
    * `:field` - Phoenix form field struct for automatic integration
    * `:options` - List of option maps with id/display keys
    * `:value_key` - Key to use for the option value (default: :id)
    * `:display_key` - Key to use for the option display text (default: :display)
    * `:placeholder` - Placeholder text for the search input
    * `:prompt` - Text to show when no selection is made
    * `:errors` - List of error messages to display
    * `:help_text` - Helper text displayed below the select
    * `:required` - Mark the field as required
    * `:disabled` - Disable the select
    * `:class` - Additional CSS classes for the wrapper
    * `:input_class` - Additional CSS classes for the input element
    * `:dropdown_class` - Additional CSS classes for the dropdown
    * `:search_event` - Phoenix event name for search changes (for server-side filtering)
    * Global attributes are passed through to the hidden input element

  ## Slots

    * `:option` - Custom rendering for each option (receives `option` assign)

  ## Examples

      <.search_select
        id="country-select"
        name="country"
        label="Country"
        options={@countries}
        placeholder="Type to search..."
        required
      />
  """
  @spec search_select(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :string, default: nil
  attr :name, :any
  attr :label, :string, default: nil
  attr :value, :any, default: nil
  attr :field, Phoenix.HTML.FormField, doc: "Form field struct"
  attr :options, :list, default: [], doc: "List of option maps with id and display keys"
  attr :value_key, :atom, default: :id, doc: "Key to use for option value"
  attr :display_key, :atom, default: :display, doc: "Key to use for option display text"
  attr :placeholder, :string, default: "Search...", doc: "Placeholder for search input"
  attr :prompt, :string, default: nil, doc: "Text shown when no selection"
  attr :errors, :list, default: []
  attr :help_text, :string, default: nil
  attr :required, :boolean, default: false
  attr :disabled, :boolean, default: false
  attr :class, :any, default: nil
  attr :input_class, :any, default: nil
  attr :dropdown_class, :any, default: nil
  attr :search_event, :string, default: nil, doc: "Event name for server-side search filtering"
  attr :rest, :global

  slot :option, doc: "Custom option rendering" do
    attr :class, :any
  end

  def search_select(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(:id, assigns.id || field.id)
    |> assign(:name, field.name)
    |> assign(:value, field.value)
    |> assign(:errors, Enum.map(field.errors, &translate_error/1))
    |> assign(:field, nil)
    |> search_select()
  end

  def search_select(assigns) do
    # Generate ID if not provided (assign_new doesn't override nil)
    id = assigns[:id] || unique_id("search-select")

    assigns =
      assigns
      |> assign(:id, id)
      |> assign(:selected_display, get_selected_display(assigns))

    ~H"""
    <div
      id={@id}
      class={["form-control w-full relative search-select-wrapper", @class]}
      phx-click-away={hide_dropdown(@id)}
    >
      <label :if={@label} for={"#{@id}-input"} class="label">
        <span class="label-text">
          {@label}
          <span :if={@required} class="text-error" aria-hidden="true">*</span>
        </span>
      </label>

      <%!-- Hidden input for form submission --%>
      <input
        type="hidden"
        id={"#{@id}-value"}
        name={@name}
        value={@value}
        {@rest}
      />

      <%!-- Search input with buttons --%>
      <div class="w-full" style="position: relative !important;">
        <input
          type="text"
          id={"#{@id}-input"}
          class={[
            "input input-bordered w-full pr-16",
            @errors != [] && "input-error",
            @input_class
          ]}
          placeholder={@selected_display || @prompt || @placeholder}
          value={@selected_display}
          disabled={@disabled}
          autocomplete="off"
          role="combobox"
          aria-expanded="false"
          aria-haspopup="listbox"
          aria-controls={"#{@id}-listbox"}
          aria-autocomplete="list"
          aria-invalid={@errors != []}
          aria-describedby={(@errors != [] || @help_text) && "#{@id}-description"}
          aria-required={@required}
          phx-focus={show_dropdown(@id)}
          phx-keydown={JS.dispatch("search_select:keydown", to: "##{@id}")}
          phx-change={@search_event}
          phx-debounce="150"
        />

        <%!-- Clear button --%>
        <button
          :if={@value && !@disabled}
          type="button"
          class="absolute right-10 top-1/2 -translate-y-1/2 btn btn-ghost btn-xs btn-circle"
          phx-click={clear_selection(@id)}
          aria-label="Clear selection"
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd" />
          </svg>
        </button>

        <%!-- Dropdown toggle button --%>
        <button
          type="button"
          class="absolute right-2 top-1/2 -translate-y-1/2 btn btn-ghost btn-xs btn-circle"
          phx-click={toggle_dropdown(@id)}
          disabled={@disabled}
          aria-label="Toggle dropdown"
          tabindex="-1"
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
          </svg>
        </button>

        <%!-- Dropdown listbox - positioned relative to input container --%>
        <ul
          id={"#{@id}-listbox"}
          class={[
            "hidden absolute left-0 menu rounded-box w-full",
            "max-h-60 overflow-y-auto shadow-2xl border-2 border-base-300",
            "p-2 flex-nowrap search-select-dropdown",
            "!bg-base-100",
            @dropdown_class
          ]}
          style="top: calc(100% + 0.25rem);"
          role="listbox"
          aria-label={@label || "Options"}
        >
          <li
            :if={@options == []}
            class="disabled"
            role="option"
            aria-disabled="true"
          >
            <span class="text-base-content/60 italic">No options available</span>
          </li>
          <%= for {option, index} <- Enum.with_index(@options) do %>
            <% opt_value = get_option_value(option, @value_key) %>
            <% opt_display = get_option_display(option, @display_key) %>
            <% is_selected = to_string(@value) == to_string(opt_value) %>
            <li
              id={"#{@id}-option-#{index}"}
              role="option"
              aria-selected={to_string(is_selected)}
            >
              <a
                class={[
                  is_selected && "active"
                ]}
                phx-click={select_option(@id, opt_value, opt_display)}
              >
                <%= if @option != [] do %>
                  {render_slot(@option, option)}
                <% else %>
                  {opt_display}
                <% end %>
              </a>
            </li>
          <% end %>
        </ul>
      </div>

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

  @doc """
  Shows the dropdown menu and closes any other open search-select dropdowns.
  """
  @spec show_dropdown(String.t()) :: Phoenix.LiveView.JS.t()
  def show_dropdown(id) do
    # First hide all other search-select dropdowns and reset their positioning
    JS.hide(to: ".search-select-dropdown:not(##{id}-listbox)")
    |> JS.remove_class("dropdown-open", to: ".search-select-wrapper")
    # Then show this dropdown (CSS handles z-index via .dropdown-open class)
    |> JS.show(to: "##{id}-listbox")
    |> JS.add_class("dropdown-open", to: "##{id}")
    |> JS.set_attribute({"aria-expanded", "true"}, to: "##{id}-input")
    |> JS.focus(to: "##{id}-input")
  end

  @doc """
  Hides the dropdown menu.
  """
  @spec hide_dropdown(String.t()) :: Phoenix.LiveView.JS.t()
  def hide_dropdown(id) do
    JS.hide(to: "##{id}-listbox")
    |> JS.remove_class("dropdown-open", to: "##{id}")
    |> JS.set_attribute({"aria-expanded", "false"}, to: "##{id}-input")
  end

  @doc """
  Toggles the dropdown menu visibility.
  """
  @spec toggle_dropdown(String.t()) :: Phoenix.LiveView.JS.t()
  def toggle_dropdown(id) do
    # First close any other open dropdowns
    JS.hide(to: ".search-select-dropdown:not(##{id}-listbox)")
    |> JS.remove_class("dropdown-open", to: ".search-select-wrapper:not(##{id})")
    # Then toggle this dropdown (CSS handles z-index via .dropdown-open class)
    |> JS.toggle(to: "##{id}-listbox")
    |> JS.toggle_class("dropdown-open", to: "##{id}")
    |> JS.toggle_attribute({"aria-expanded", "true", "false"}, to: "##{id}-input")
  end

  @doc """
  Selects an option and updates the hidden input value.
  """
  @spec select_option(String.t(), any(), String.t()) :: Phoenix.LiveView.JS.t()
  def select_option(id, value, display) do
    JS.set_attribute({"value", to_string(value)}, to: "##{id}-value")
    |> JS.set_attribute({"value", display}, to: "##{id}-input")
    |> JS.set_attribute({"placeholder", display}, to: "##{id}-input")
    |> JS.dispatch("change", to: "##{id}-value")
    |> JS.dispatch("input", to: "##{id}-value")
    |> JS.hide(to: "##{id}-listbox")
    |> JS.remove_class("dropdown-open", to: "##{id}")
    |> JS.set_attribute({"aria-expanded", "false"}, to: "##{id}-input")
    # Mark as just-selected to prevent focus handler from reopening dropdown
    |> JS.set_attribute({"data-just-selected", "true"}, to: "##{id}")
  end

  @doc """
  Clears the current selection.
  """
  @spec clear_selection(String.t()) :: Phoenix.LiveView.JS.t()
  def clear_selection(id) do
    JS.set_attribute({"value", ""}, to: "##{id}-value")
    |> JS.set_attribute({"value", ""}, to: "##{id}-input")
    |> JS.dispatch("change", to: "##{id}-value")
    |> JS.dispatch("input", to: "##{id}-value")
  end

  # Private helpers

  defp get_selected_display(%{value: nil}), do: nil
  defp get_selected_display(%{value: ""}), do: nil

  defp get_selected_display(%{value: value, options: options, value_key: value_key, display_key: display_key}) do
    case Enum.find(options, fn opt -> to_string(get_option_value(opt, value_key)) == to_string(value) end) do
      nil -> nil
      option -> get_option_display(option, display_key)
    end
  end

  defp get_option_value(option, key) when is_map(option) do
    Map.get(option, key) || Map.get(option, to_string(key))
  end

  defp get_option_value({_label, value}, _key), do: value
  defp get_option_value(value, _key), do: value

  defp get_option_display(option, key) when is_map(option) do
    Map.get(option, key) || Map.get(option, to_string(key)) || inspect(option)
  end

  defp get_option_display({label, _value}, _key), do: label
  defp get_option_display(value, _key), do: to_string(value)
end
