defmodule MithrilUI.Components.SearchSelectTest do
  use ExUnit.Case, async: true
  use Phoenix.Component

  import Phoenix.LiveViewTest
  import MithrilUI.Components.SearchSelect

  describe "search_select/1" do
    test "renders basic search select with map options" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{id: "1", display: "John Doe"}, %{id: "2", display: "Jane Smith"}]}
        />
        """)

      assert html =~ ~s(id="user-select")
      assert html =~ ~s(name="user_id")
      assert html =~ "John Doe"
      assert html =~ "Jane Smith"
      assert html =~ ~s(role="combobox")
      assert html =~ ~s(role="listbox")
    end

    test "renders with custom value_key and display_key" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="product-select"
          name="product_id"
          options={[%{code: "ABC", name: "Product A"}, %{code: "DEF", name: "Product B"}]}
          value_key={:code}
          display_key={:name}
        />
        """)

      assert html =~ "Product A"
      assert html =~ "Product B"
    end

    test "renders with label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          label="Select User"
          options={[%{id: "1", display: "John"}]}
        />
        """)

      assert html =~ ~s(<label)
      assert html =~ "Select User"
      assert html =~ "label-text"
    end

    test "renders required indicator in label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          label="Select User"
          options={[%{id: "1", display: "John"}]}
          required
        />
        """)

      assert html =~ "Select User"
      assert html =~ "text-error"
      assert html =~ "*"
      assert html =~ ~s(aria-hidden="true")
    end

    test "renders with placeholder" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[]}
          placeholder="Type to search users..."
        />
        """)

      assert html =~ ~s(placeholder="Type to search users...")
    end

    test "renders with selected value displaying selected item" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{id: "1", display: "John Doe"}, %{id: "2", display: "Jane Smith"}]}
          value="2"
        />
        """)

      # Hidden input should have the value
      assert html =~ ~s(value="2")
      # The visible input should show the display text
      assert html =~ ~s(placeholder="Jane Smith")
    end

    test "renders disabled state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{id: "1", display: "John"}]}
          disabled
        />
        """)

      assert html =~ "disabled"
    end

    test "renders with errors" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{id: "1", display: "John"}]}
          errors={["is required"]}
        />
        """)

      assert html =~ "is required"
      assert html =~ "text-error"
      assert html =~ "input-error"
      assert html =~ "aria-invalid"
    end

    test "renders with help text" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{id: "1", display: "John"}]}
          help_text="Start typing to search for users"
        />
        """)

      assert html =~ "Start typing to search for users"
      assert html =~ "label-text-alt"
      assert html =~ ~s(aria-describedby="user-select-description")
    end

    test "errors take precedence over help text display" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{id: "1", display: "John"}]}
          help_text="Select a user"
          errors={["is required"]}
        />
        """)

      assert html =~ "is required"
      refute html =~ "Select a user"
    end

    test "renders with form field" do
      field = %Phoenix.HTML.FormField{
        id: "post_author_id",
        name: "post[author_id]",
        value: "42",
        errors: [],
        field: :author_id,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.search_select
          field={@field}
          options={[%{id: "42", display: "John Author"}, %{id: "43", display: "Jane Writer"}]}
        />
        """)

      assert html =~ ~s(id="post_author_id")
      assert html =~ ~s(name="post[author_id]")
      assert html =~ ~s(value="42")
    end

    test "renders with form field errors" do
      field = %Phoenix.HTML.FormField{
        id: "post_author_id",
        name: "post[author_id]",
        value: nil,
        errors: [{"is required", []}],
        field: :author_id,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.search_select
          field={@field}
          options={[%{id: "42", display: "John Author"}]}
        />
        """)

      assert html =~ "is required"
      assert html =~ "input-error"
    end

    test "renders with form field and interpolated errors" do
      field = %Phoenix.HTML.FormField{
        id: "post_priority",
        name: "post[priority]",
        value: nil,
        errors: [{"must be at least %{count}", [count: 1]}],
        field: :priority,
        form: nil
      }

      assigns = %{field: field}

      html =
        rendered_to_string(~H"""
        <.search_select
          field={@field}
          options={[%{id: "0", display: "Low"}, %{id: "1", display: "High"}]}
        />
        """)

      assert html =~ "must be at least 1"
    end

    test "applies custom wrapper class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{id: "1", display: "John"}]}
          class="my-custom-class"
        />
        """)

      assert html =~ "my-custom-class"
    end

    test "applies custom input class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{id: "1", display: "John"}]}
          input_class="input-lg"
        />
        """)

      assert html =~ "input-lg"
    end

    test "applies custom dropdown class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{id: "1", display: "John"}]}
          dropdown_class="max-h-40"
        />
        """)

      assert html =~ "max-h-40"
    end

    test "renders empty state when no options" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[]}
        />
        """)

      assert html =~ "No options available"
    end

    test "renders integer value options correctly" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="rating-select"
          name="rating"
          options={[%{id: 1, display: "One"}, %{id: 2, display: "Two"}]}
          value={2}
        />
        """)

      assert html =~ "One"
      assert html =~ "Two"
      # Selected item should show in placeholder
      assert html =~ ~s(placeholder="Two")
    end

    test "supports tuple options for backwards compatibility" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="country-select"
          name="country"
          options={[{"United States", "us"}, {"Canada", "ca"}]}
        />
        """)

      assert html =~ "United States"
      assert html =~ "Canada"
    end

    test "passes through global attributes to hidden input" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{id: "1", display: "John"}]}
          data-testid="user-select"
        />
        """)

      assert html =~ ~s(data-testid="user-select")
    end

    test "generates unique id when not provided" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          name="user_id"
          options={[%{id: "1", display: "John"}]}
        />
        """)

      assert html =~ ~s(id="search-select-)
    end

    test "renders clear button when value is set" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{id: "1", display: "John"}]}
          value="1"
        />
        """)

      assert html =~ ~s(aria-label="Clear selection")
    end

    test "does not render clear button when disabled" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{id: "1", display: "John"}]}
          value="1"
          disabled
        />
        """)

      refute html =~ ~s(aria-label="Clear selection")
    end

    test "renders with prompt text" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{id: "1", display: "John"}]}
          prompt="Select a user..."
        />
        """)

      assert html =~ ~s(placeholder="Select a user...")
    end

    test "renders aria-selected for selected option" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{id: "1", display: "John"}, %{id: "2", display: "Jane"}]}
          value="1"
        />
        """)

      assert html =~ ~s(aria-selected="true")
      assert html =~ ~s(aria-selected="false")
    end

    test "renders with search_event attribute for server filtering" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{id: "1", display: "John"}]}
          search_event="filter_users"
        />
        """)

      assert html =~ ~s(phx-change="filter_users")
    end

    test "renders options with string keys in maps" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{"id" => "1", "display" => "John"}, %{"id" => "2", "display" => "Jane"}]}
        />
        """)

      assert html =~ "John"
      assert html =~ "Jane"
    end

    test "shows selected display for string key maps" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{"id" => "1", "display" => "John Doe"}, %{"id" => "2", "display" => "Jane"}]}
          value="1"
        />
        """)

      assert html =~ ~s(placeholder="John Doe")
    end

    test "renders with required aria attributes" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{id: "1", display: "John"}]}
          required
        />
        """)

      assert html =~ ~s(aria-required)
    end

    test "renders listbox with proper aria-label from label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          label="Select User"
          options={[%{id: "1", display: "John"}]}
        />
        """)

      assert html =~ ~s(aria-label="Select User")
    end

    test "renders with hidden dropdown initially" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{id: "1", display: "John"}]}
        />
        """)

      # The listbox should be hidden initially
      assert html =~ ~r/id="user-select-listbox"[^>]*class="[^"]*hidden/
    end

    test "renders option indices for keyboard navigation" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.search_select
          id="user-select"
          name="user_id"
          options={[%{id: "1", display: "John"}, %{id: "2", display: "Jane"}]}
        />
        """)

      assert html =~ ~s(id="user-select-option-0")
      assert html =~ ~s(id="user-select-option-1")
    end
  end

  describe "JS commands" do
    test "show_dropdown/1 returns JS struct" do
      js = show_dropdown("test-select")
      assert %Phoenix.LiveView.JS{} = js
    end

    test "hide_dropdown/1 returns JS struct" do
      js = hide_dropdown("test-select")
      assert %Phoenix.LiveView.JS{} = js
    end

    test "toggle_dropdown/1 returns JS struct" do
      js = toggle_dropdown("test-select")
      assert %Phoenix.LiveView.JS{} = js
    end

    test "select_option/3 returns JS struct" do
      js = select_option("test-select", "value1", "Display Text")
      assert %Phoenix.LiveView.JS{} = js
    end

    test "clear_selection/1 returns JS struct" do
      js = clear_selection("test-select")
      assert %Phoenix.LiveView.JS{} = js
    end
  end
end
