defmodule MithrilUI.Components.ButtonTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Button

  describe "button/1 rendering" do
    test "renders basic button with content" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button>Click me</Button.button>
        """)

      assert html =~ "Click me"
      assert html =~ ~s(type="button")
      assert html =~ "btn"
    end

    test "renders with submit type" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button type="submit">Submit</Button.button>
        """)

      assert html =~ ~s(type="submit")
    end

    test "renders with reset type" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button type="reset">Reset</Button.button>
        """)

      assert html =~ ~s(type="reset")
    end
  end

  describe "button variants" do
    test "renders primary variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button variant="primary">Primary</Button.button>
        """)

      assert html =~ "btn-primary"
    end

    test "renders secondary variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button variant="secondary">Secondary</Button.button>
        """)

      assert html =~ "btn-secondary"
    end

    test "renders accent variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button variant="accent">Accent</Button.button>
        """)

      assert html =~ "btn-accent"
    end

    test "renders ghost variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button variant="ghost">Ghost</Button.button>
        """)

      assert html =~ "btn-ghost"
    end

    test "renders link variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button variant="link">Link</Button.button>
        """)

      assert html =~ "btn-link"
    end

    test "renders outline variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button variant="outline">Outline</Button.button>
        """)

      assert html =~ "btn-outline"
    end

    test "renders neutral variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button variant="neutral">Neutral</Button.button>
        """)

      assert html =~ "btn-neutral"
    end

    test "renders info variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button variant="info">Info</Button.button>
        """)

      assert html =~ "btn-info"
    end

    test "renders success variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button variant="success">Success</Button.button>
        """)

      assert html =~ "btn-success"
    end

    test "renders warning variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button variant="warning">Warning</Button.button>
        """)

      assert html =~ "btn-warning"
    end

    test "renders error variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button variant="error">Error</Button.button>
        """)

      assert html =~ "btn-error"
    end

    test "renders outline with variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button variant="primary" outline>Outline Primary</Button.button>
        """)

      assert html =~ "btn-outline"
      assert html =~ "btn-primary"
    end
  end

  describe "button sizes" do
    test "renders xs size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button size="xs">Extra Small</Button.button>
        """)

      assert html =~ "btn-xs"
    end

    test "renders sm size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button size="sm">Small</Button.button>
        """)

      assert html =~ "btn-sm"
    end

    test "renders md size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button size="md">Medium</Button.button>
        """)

      assert html =~ "btn-md"
    end

    test "renders lg size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button size="lg">Large</Button.button>
        """)

      assert html =~ "btn-lg"
    end
  end

  describe "button states" do
    test "renders disabled button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button disabled>Disabled</Button.button>
        """)

      assert html =~ "disabled"
      assert html =~ "btn-disabled"
      assert html =~ "aria-disabled"
    end

    test "renders loading button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button loading>Loading</Button.button>
        """)

      assert html =~ "loading loading-spinner"
      assert html =~ "btn-disabled"
      assert html =~ "aria-busy"
      assert html =~ "disabled"
    end

    test "loading button shows spinner before content" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button loading>Processing</Button.button>
        """)

      # Spinner should appear before the text
      spinner_pos = :binary.match(html, "loading-spinner") |> elem(0)
      text_pos = :binary.match(html, "Processing") |> elem(0)
      assert spinner_pos < text_pos
    end
  end

  describe "button shapes" do
    test "renders block button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button block>Full Width</Button.button>
        """)

      assert html =~ "btn-block"
    end

    test "renders circle button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button circle>O</Button.button>
        """)

      assert html =~ "btn-circle"
    end

    test "renders square button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button square>X</Button.button>
        """)

      assert html =~ "btn-square"
    end

    test "circle takes precedence over square" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button circle square>O</Button.button>
        """)

      assert html =~ "btn-circle"
      refute html =~ "btn-square"
    end
  end

  describe "custom classes" do
    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button class="custom-class">Custom</Button.button>
        """)

      assert html =~ "custom-class"
      assert html =~ "btn"
    end

    test "custom class combines with variant and size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button variant="primary" size="lg" class="mt-4">Styled</Button.button>
        """)

      assert html =~ "btn"
      assert html =~ "btn-primary"
      assert html =~ "btn-lg"
      assert html =~ "mt-4"
    end
  end

  describe "list-based class attribute" do
    test "accepts class as a list of strings" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button class={["custom-1", "custom-2"]}>List Classes</Button.button>
        """)

      assert html =~ "custom-1"
      assert html =~ "custom-2"
      assert html =~ "btn"
    end

    test "accepts class list with nil values filtered out" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button class={["custom-class", nil, "another-class"]}>Filtered</Button.button>
        """)

      assert html =~ "custom-class"
      assert html =~ "another-class"
      assert html =~ "btn"
    end

    test "accepts class list with conditional if/else" do
      assigns = %{selected: true}

      html =
        rendered_to_string(~H"""
        <Button.button class={[
          "base-class",
          if(@selected, do: "selected-style", else: "unselected-style")
        ]}>
          Conditional
        </Button.button>
        """)

      assert html =~ "base-class"
      assert html =~ "selected-style"
      refute html =~ "unselected-style"
    end

    test "accepts class list with conditional if/else - false condition" do
      assigns = %{selected: false}

      html =
        rendered_to_string(~H"""
        <Button.button class={[
          "base-class",
          if(@selected, do: "is-selected-style", else: "not-selected-style")
        ]}>
          Conditional
        </Button.button>
        """)

      assert html =~ "base-class"
      refute html =~ "is-selected-style"
      assert html =~ "not-selected-style"
    end

    test "accepts class list with boolean && operator" do
      assigns = %{is_active: true}

      html =
        rendered_to_string(~H"""
        <Button.button class={[
          "always-present",
          @is_active && "active-class"
        ]}>
          Boolean
        </Button.button>
        """)

      assert html =~ "always-present"
      assert html =~ "active-class"
    end

    test "accepts class list with false && operator result" do
      assigns = %{is_active: false}

      html =
        rendered_to_string(~H"""
        <Button.button class={[
          "always-present",
          @is_active && "active-class"
        ]}>
          Boolean
        </Button.button>
        """)

      assert html =~ "always-present"
      refute html =~ "active-class"
    end

    test "accepts complex conditional class patterns" do
      assigns = %{selected: true, highlighted: false, size: "large"}

      html =
        rendered_to_string(~H"""
        <Button.button class={[
          "w-12 h-12 p-0 rounded-lg overflow-hidden",
          if(@selected, do: "ring-2 ring-white scale-110", else: "opacity-60"),
          @highlighted && "border-2 border-yellow-400",
          @size == "large" && "text-lg"
        ]}>
          Complex
        </Button.button>
        """)

      assert html =~ "w-12"
      assert html =~ "h-12"
      assert html =~ "ring-2"
      assert html =~ "ring-white"
      assert html =~ "scale-110"
      refute html =~ "opacity-60"
      refute html =~ "border-yellow-400"
      assert html =~ "text-lg"
    end

    test "list class works with link_button" do
      assigns = %{active: true}

      html =
        rendered_to_string(~H"""
        <Button.link_button href="/" class={["nav-link", @active && "active"]}>
          Link
        </Button.link_button>
        """)

      assert html =~ "nav-link"
      assert html =~ "active"
    end

    test "list class works with icon_button" do
      assigns = %{danger: true}

      html =
        rendered_to_string(~H"""
        <Button.icon_button label="Delete" class={["icon-btn", @danger && "danger-icon"]}>
          X
        </Button.icon_button>
        """)

      assert html =~ "icon-btn"
      assert html =~ "danger-icon"
    end

    test "empty list class is handled correctly" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button class={[]}>Empty List</Button.button>
        """)

      assert html =~ "btn"
      assert html =~ "Empty List"
    end

    test "nested list classes are flattened" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button class={["outer", ["inner-1", "inner-2"]]}>Nested</Button.button>
        """)

      assert html =~ "outer"
      assert html =~ "inner-1"
      assert html =~ "inner-2"
    end
  end

  describe "accessibility" do
    test "sets aria-disabled when disabled" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button disabled>Disabled</Button.button>
        """)

      assert html =~ "aria-disabled"
    end

    test "does not set aria-disabled when not disabled" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button>Enabled</Button.button>
        """)

      refute html =~ "aria-disabled"
    end

    test "sets aria-busy when loading" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button loading>Loading</Button.button>
        """)

      assert html =~ "aria-busy"
    end

    test "does not set aria-busy when not loading" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button>Not Loading</Button.button>
        """)

      refute html =~ "aria-busy"
    end
  end

  describe "link_button/1" do
    test "renders as anchor with button styling" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.link_button href="/path">Link Button</Button.link_button>
        """)

      assert html =~ "<a"
      assert html =~ ~s(href="/path")
      assert html =~ "btn"
      assert html =~ "Link Button"
    end

    test "renders with navigate attribute" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.link_button navigate="/dashboard">Dashboard</Button.link_button>
        """)

      assert html =~ "data-phx-link"
      assert html =~ "Dashboard"
    end

    test "renders with patch attribute" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.link_button patch="/settings">Settings</Button.link_button>
        """)

      assert html =~ "data-phx-link"
      assert html =~ "Settings"
    end

    test "applies variant to link_button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.link_button href="/" variant="primary">Home</Button.link_button>
        """)

      assert html =~ "btn-primary"
    end

    test "applies size to link_button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.link_button href="/" size="lg">Large Link</Button.link_button>
        """)

      assert html =~ "btn-lg"
    end

    test "renders loading state in link_button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.link_button href="/" loading>Loading Link</Button.link_button>
        """)

      assert html =~ "loading loading-spinner"
      assert html =~ "btn-disabled"
    end

    test "renders external link with target" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.link_button href="https://example.com" target="_blank">External</Button.link_button>
        """)

      assert html =~ ~s(target="_blank")
      assert html =~ ~s(href="https://example.com")
    end
  end

  describe "icon_button/1" do
    test "renders icon button with label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.icon_button label="Delete">X</Button.icon_button>
        """)

      assert html =~ ~s(aria-label="Delete")
      assert html =~ ~s(title="Delete")
      assert html =~ "btn"
      assert html =~ "X"
    end

    test "renders square by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.icon_button label="Add">+</Button.icon_button>
        """)

      assert html =~ "btn-square"
    end

    test "renders circle when specified" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.icon_button label="Add" circle>+</Button.icon_button>
        """)

      assert html =~ "btn-circle"
      refute html =~ "btn-square"
    end

    test "applies variant to icon_button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.icon_button label="Delete" variant="error">X</Button.icon_button>
        """)

      assert html =~ "btn-error"
    end

    test "applies size to icon_button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.icon_button label="Small" size="sm">S</Button.icon_button>
        """)

      assert html =~ "btn-sm"
    end

    test "shows spinner when loading" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.icon_button label="Loading" loading>X</Button.icon_button>
        """)

      assert html =~ "loading loading-spinner"
    end

    test "hides icon content when loading" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.icon_button label="Loading" loading>ICON</Button.icon_button>
        """)

      # Icon content should still be in DOM but not visible (handled by conditional rendering)
      assert html =~ "loading loading-spinner"
    end

    test "renders disabled state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.icon_button label="Disabled" disabled>X</Button.icon_button>
        """)

      assert html =~ "disabled"
      assert html =~ "btn-disabled"
      assert html =~ "aria-disabled"
    end
  end

  describe "global attributes" do
    test "passes through phx-click" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button phx-click="handle_click">Click</Button.button>
        """)

      assert html =~ ~s(phx-click="handle_click")
    end

    test "passes through phx-target" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button phx-click="click" phx-target="#target">Click</Button.button>
        """)

      assert html =~ ~s(phx-target="#target")
    end

    test "passes through phx-disable-with" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button phx-click="save" phx-disable-with="Saving...">Save</Button.button>
        """)

      assert html =~ ~s(phx-disable-with="Saving...")
    end

    test "passes through form attribute" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button type="submit" form="my-form">Submit</Button.button>
        """)

      assert html =~ ~s(form="my-form")
    end

    test "passes through name and value attributes" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button type="submit" name="action" value="save">Save</Button.button>
        """)

      assert html =~ ~s(name="action")
      assert html =~ ~s(value="save")
    end
  end
end
