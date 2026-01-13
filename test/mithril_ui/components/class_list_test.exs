defmodule MithrilUI.Components.ClassListTest do
  @moduledoc """
  Tests for list-based class attribute support across all MithrilUI components.

  This feature allows passing the class attribute as either a string or a list,
  enabling flexible conditional class composition:

      # String (traditional)
      <.button class="my-class">Click</.button>

      # List with conditionals
      <.button class={[
        "base-class",
        if(@selected, do: "selected", else: "unselected"),
        @active && "active"
      ]}>
        Click
      </.button>
  """

  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.{
    Accordion,
    Alert,
    Avatar,
    Badge,
    Button,
    Card,
    Heading,
    Link,
    Modal,
    Progress,
    Spinner,
    Tabs,
    Text
  }

  describe "actions components" do
    test "button accepts list class with conditionals" do
      assigns = %{primary: true, large: false}

      html =
        rendered_to_string(~H"""
        <Button.button class={[
          "custom-btn",
          @primary && "is-primary",
          @large && "is-large"
        ]}>
          Click
        </Button.button>
        """)

      assert html =~ "custom-btn"
      assert html =~ "is-primary"
      refute html =~ "is-large"
    end
  end

  describe "data display components" do
    test "avatar accepts list class" do
      assigns = %{online: true}

      html =
        rendered_to_string(~H"""
        <Avatar.avatar
          placeholder="JD"
          class={["user-avatar", @online && "online-indicator"]}
        />
        """)

      assert html =~ "user-avatar"
      assert html =~ "online-indicator"
    end

    test "badge accepts list class with if/else" do
      assigns = %{status: :success}

      html =
        rendered_to_string(~H"""
        <Badge.badge class={[
          "status-badge",
          if(@status == :success, do: "badge-success-custom", else: "badge-default-custom")
        ]}>
          Status
        </Badge.badge>
        """)

      assert html =~ "status-badge"
      assert html =~ "badge-success-custom"
      refute html =~ "badge-default-custom"
    end

    test "card accepts list class" do
      assigns = %{elevated: true, compact: false}

      html =
        rendered_to_string(~H"""
        <Card.card class={[
          "product-card",
          @elevated && "shadow-xl",
          @compact && "p-2"
        ]}>
          <:body>Content</:body>
        </Card.card>
        """)

      assert html =~ "product-card"
      assert html =~ "shadow-xl"
      refute html =~ "p-2"
    end

    test "accordion accepts list class" do
      assigns = %{bordered: true}

      html =
        rendered_to_string(~H"""
        <Accordion.accordion class={["faq-accordion", @bordered && "border-custom"]}>
          <:item title="Question 1">Answer 1</:item>
        </Accordion.accordion>
        """)

      assert html =~ "faq-accordion"
      assert html =~ "border-custom"
    end
  end

  describe "feedback components" do
    test "alert accepts list class" do
      assigns = %{dismissible: true}

      html =
        rendered_to_string(~H"""
        <Alert.alert class={["notification", @dismissible && "has-close-btn"]}>
          Message
        </Alert.alert>
        """)

      assert html =~ "notification"
      assert html =~ "has-close-btn"
    end

    test "progress accepts list class" do
      assigns = %{animated: true}

      html =
        rendered_to_string(~H"""
        <Progress.progress
          value={50}
          class={["upload-progress", @animated && "animate-pulse"]}
        />
        """)

      assert html =~ "upload-progress"
      assert html =~ "animate-pulse"
    end

    test "spinner accepts list class" do
      assigns = %{centered: true}

      html =
        rendered_to_string(~H"""
        <Spinner.spinner class={["loader", @centered && "mx-auto"]} />
        """)

      assert html =~ "loader"
      assert html =~ "mx-auto"
    end

    test "modal accepts list class" do
      assigns = %{fullscreen: false}

      html =
        rendered_to_string(~H"""
        <Modal.modal id="test-modal" class={["custom-modal", @fullscreen && "modal-fullscreen"]}>
          Modal content
        </Modal.modal>
        """)

      assert html =~ "custom-modal"
      refute html =~ "modal-fullscreen"
    end
  end

  describe "typography components" do
    test "text accepts list class" do
      assigns = %{muted: true}

      html =
        rendered_to_string(~H"""
        <Text.text class={["description", @muted && "text-opacity-60"]}>
          Some text
        </Text.text>
        """)

      assert html =~ "description"
      assert html =~ "text-opacity-60"
    end

    test "heading accepts list class" do
      assigns = %{centered: true}

      html =
        rendered_to_string(~H"""
        <Heading.heading class={["page-title", @centered && "text-center"]}>
          Title
        </Heading.heading>
        """)

      assert html =~ "page-title"
      assert html =~ "text-center"
    end

    test "link accepts list class" do
      assigns = %{external: true}

      html =
        rendered_to_string(~H"""
        <Link.styled_link href="/" class={["custom-link", @external && "external-link"]}>
          Click here
        </Link.styled_link>
        """)

      assert html =~ "custom-link"
      assert html =~ "external-link"
    end
  end

  describe "navigation components" do
    test "tabs accepts list class" do
      assigns = %{vertical: false}

      html =
        rendered_to_string(~H"""
        <Tabs.tabs class={["main-tabs", @vertical && "tabs-vertical"]}>
          <:tab label="Tab 1">Content 1</:tab>
          <:tab label="Tab 2">Content 2</:tab>
        </Tabs.tabs>
        """)

      assert html =~ "main-tabs"
      refute html =~ "tabs-vertical"
    end
  end

  describe "complex conditional patterns" do
    test "multiple conditional patterns in same class list" do
      assigns = %{
        selected: true,
        disabled: false,
        loading: false,
        variant: "primary",
        size: "lg"
      }

      html =
        rendered_to_string(~H"""
        <Button.button class={[
          "interactive-element",
          @selected && "ring-2 ring-offset-2",
          @disabled && "cursor-not-allowed opacity-50",
          @loading && "animate-pulse",
          @variant == "primary" && "bg-blue-500",
          @size == "lg" && "text-lg px-6 py-3"
        ]}>
          Complex Button
        </Button.button>
        """)

      assert html =~ "interactive-element"
      assert html =~ "ring-2"
      assert html =~ "ring-offset-2"
      refute html =~ "cursor-not-allowed"
      refute html =~ "animate-pulse"
      assert html =~ "bg-blue-500"
      assert html =~ "text-lg"
      assert html =~ "px-6"
      assert html =~ "py-3"
    end

    test "nested list classes" do
      assigns = %{theme: "dark"}

      html =
        rendered_to_string(~H"""
        <Card.card class={[
          "themed-card",
          [
            "transition-all duration-300",
            @theme == "dark" && ["bg-gray-800", "text-white"]
          ]
        ]}>
          <:body>Dark themed content</:body>
        </Card.card>
        """)

      assert html =~ "themed-card"
      assert html =~ "transition-all"
      assert html =~ "duration-300"
      assert html =~ "bg-gray-800"
      assert html =~ "text-white"
    end

    test "if/else with multiple classes" do
      assigns = %{expanded: true}

      html =
        rendered_to_string(~H"""
        <Button.button class={[
          "accordion-trigger",
          if(@expanded,
            do: "rotate-180 bg-blue-100",
            else: "rotate-0 bg-gray-100"
          )
        ]}>
          Toggle
        </Button.button>
        """)

      assert html =~ "accordion-trigger"
      assert html =~ "rotate-180"
      assert html =~ "bg-blue-100"
      refute html =~ "rotate-0"
      refute html =~ "bg-gray-100"
    end

    test "gallery-style photo selection pattern" do
      # This tests the exact pattern from the user's original request
      assigns = %{
        selected_photo: %{id: 1},
        photo: %{id: 1}
      }

      html =
        rendered_to_string(~H"""
        <Button.button class={[
          "w-12 h-12 p-0 rounded-lg overflow-hidden flex-shrink-0 transition-all",
          if(@selected_photo && @photo.id == @selected_photo.id,
            do: "ring-2 ring-white ring-offset-2 ring-offset-black scale-110",
            else: "opacity-60 hover:opacity-100"
          )
        ]}>
          Photo
        </Button.button>
        """)

      assert html =~ "w-12"
      assert html =~ "h-12"
      assert html =~ "ring-2"
      assert html =~ "ring-white"
      assert html =~ "scale-110"
      refute html =~ "opacity-60"
    end

    test "gallery-style photo selection pattern - unselected" do
      assigns = %{
        selected_photo: %{id: 2},
        photo: %{id: 1}
      }

      html =
        rendered_to_string(~H"""
        <Button.button class={[
          "w-12 h-12 p-0 rounded-lg overflow-hidden flex-shrink-0 transition-all",
          if(@selected_photo && @photo.id == @selected_photo.id,
            do: "ring-2 ring-white ring-offset-2 ring-offset-black scale-110",
            else: "opacity-60 hover:opacity-100"
          )
        ]}>
          Photo
        </Button.button>
        """)

      assert html =~ "w-12"
      assert html =~ "opacity-60"
      assert html =~ "hover:opacity-100"
      refute html =~ "ring-2"
      refute html =~ "scale-110"
    end

    test "nil selected photo handling" do
      assigns = %{
        selected_photo: nil,
        photo: %{id: 1}
      }

      html =
        rendered_to_string(~H"""
        <Button.button class={[
          "base-class",
          if(@selected_photo && @photo.id == @selected_photo.id,
            do: "is-selected",
            else: "not-selected"
          )
        ]}>
          Photo
        </Button.button>
        """)

      assert html =~ "base-class"
      assert html =~ "not-selected"
      refute html =~ "is-selected"
    end
  end

  describe "edge cases" do
    test "empty list class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button class={[]}>Empty</Button.button>
        """)

      assert html =~ "btn"
    end

    test "list with only nil values" do
      assigns = %{a: false, b: false}

      html =
        rendered_to_string(~H"""
        <Button.button class={[@a && "a", @b && "b"]}>Only Nils</Button.button>
        """)

      assert html =~ "btn"
      refute html =~ ~r/class="[^"]*\s{2,}/
    end

    test "list with only false conditions" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button class={[false && "never", nil]}>False Only</Button.button>
        """)

      assert html =~ "btn"
    end

    test "deeply nested lists" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button class={["a", ["b", ["c", ["d"]]]]}>Deep</Button.button>
        """)

      assert html =~ "a"
      assert html =~ "b"
      assert html =~ "c"
      assert html =~ "d"
    end

    test "string class still works (backwards compatibility)" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button class="simple-string-class">String</Button.button>
        """)

      assert html =~ "simple-string-class"
      assert html =~ "btn"
    end

    test "nil class still works (backwards compatibility)" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Button.button class={nil}>Nil</Button.button>
        """)

      assert html =~ "btn"
    end
  end
end
