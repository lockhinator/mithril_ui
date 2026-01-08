defmodule MithrilUI.Components.AlertTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Alert

  describe "alert/1 rendering" do
    test "renders basic alert" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Alert.alert>This is a message</Alert.alert>
        """)

      assert html =~ "alert"
      assert html =~ "This is a message"
      assert html =~ ~s(role="alert")
    end

    test "renders with id" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Alert.alert id="my-alert">Message</Alert.alert>
        """)

      assert html =~ ~s(id="my-alert")
    end
  end

  describe "alert variants" do
    test "renders info variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Alert.alert variant="info">Info</Alert.alert>
        """)

      assert html =~ "alert-info"
    end

    test "renders success variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Alert.alert variant="success">Success</Alert.alert>
        """)

      assert html =~ "alert-success"
    end

    test "renders warning variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Alert.alert variant="warning">Warning</Alert.alert>
        """)

      assert html =~ "alert-warning"
    end

    test "renders error variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Alert.alert variant="error">Error</Alert.alert>
        """)

      assert html =~ "alert-error"
    end
  end

  describe "alert title" do
    test "renders with title" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Alert.alert title="Important">Message</Alert.alert>
        """)

      assert html =~ "Important"
      assert html =~ "font-bold"
    end

    test "renders without title" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Alert.alert>No title</Alert.alert>
        """)

      refute html =~ "font-bold"
    end
  end

  describe "alert icon" do
    test "shows icon by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Alert.alert>Message</Alert.alert>
        """)

      assert html =~ "<svg"
    end

    test "hides icon when icon=false" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Alert.alert icon={false}>Message</Alert.alert>
        """)

      refute html =~ "<svg"
    end
  end

  describe "dismissible alert" do
    test "shows dismiss button when dismissible" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Alert.alert id="dismiss-alert" dismissible>Dismissible</Alert.alert>
        """)

      assert html =~ ~s(aria-label="Dismiss")
      assert html =~ "btn"
    end

    test "hides dismiss button when not dismissible" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Alert.alert>Not dismissible</Alert.alert>
        """)

      refute html =~ ~s(aria-label="Dismiss")
    end
  end

  describe "alert actions slot" do
    test "renders actions slot" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Alert.alert>
          Message
          <:actions>
            <button>Retry</button>
          </:actions>
        </Alert.alert>
        """)

      assert html =~ "Retry"
    end
  end

  describe "custom classes" do
    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Alert.alert class="my-custom-class">Message</Alert.alert>
        """)

      assert html =~ "my-custom-class"
    end
  end

  describe "JS functions" do
    test "show_alert returns JS struct" do
      js = Alert.show_alert("test")
      assert %Phoenix.LiveView.JS{} = js
    end

    test "hide_alert returns JS struct" do
      js = Alert.hide_alert("test")
      assert %Phoenix.LiveView.JS{} = js
    end
  end
end
