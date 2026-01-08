defmodule MithrilUI.Components.ToastTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Toast

  describe "toast/1 rendering" do
    test "renders basic toast" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Toast.toast id="my-toast">Toast message</Toast.toast>
        """)

      assert html =~ "alert"
      assert html =~ "Toast message"
      assert html =~ ~s(id="my-toast")
    end

    test "renders with role=alert" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Toast.toast id="t1">Message</Toast.toast>
        """)

      assert html =~ ~s(role="alert")
    end
  end

  describe "toast variants" do
    test "renders info variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Toast.toast id="t1" variant="info">Info</Toast.toast>
        """)

      assert html =~ "alert-info"
    end

    test "renders success variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Toast.toast id="t1" variant="success">Success</Toast.toast>
        """)

      assert html =~ "alert-success"
    end

    test "renders warning variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Toast.toast id="t1" variant="warning">Warning</Toast.toast>
        """)

      assert html =~ "alert-warning"
    end

    test "renders error variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Toast.toast id="t1" variant="error">Error</Toast.toast>
        """)

      assert html =~ "alert-error"
    end
  end

  describe "toast dismissible" do
    test "shows dismiss button by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Toast.toast id="t1">Message</Toast.toast>
        """)

      assert html =~ ~s(aria-label="Dismiss")
    end

    test "hides dismiss button when dismissible=false" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Toast.toast id="t1" dismissible={false}>Message</Toast.toast>
        """)

      refute html =~ ~s(aria-label="Dismiss")
    end
  end

  describe "toast auto_dismiss" do
    test "adds phx-mounted when auto_dismiss > 0" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Toast.toast id="t1" auto_dismiss={3000}>Auto dismiss</Toast.toast>
        """)

      assert html =~ "phx-mounted"
    end

    test "no phx-mounted when auto_dismiss is 0" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Toast.toast id="t1" auto_dismiss={0}>Manual dismiss</Toast.toast>
        """)

      refute html =~ "phx-mounted"
    end
  end

  describe "toast_container/1" do
    test "renders container with default position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Toast.toast_container>
          <Toast.toast id="t1">Toast</Toast.toast>
        </Toast.toast_container>
        """)

      assert html =~ "toast"
      assert html =~ "toast-bottom"
      assert html =~ "toast-end"
    end

    test "renders with top-start position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Toast.toast_container position="top-start">
          <Toast.toast id="t1">Toast</Toast.toast>
        </Toast.toast_container>
        """)

      assert html =~ "toast-top"
      assert html =~ "toast-start"
    end

    test "renders with top-center position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Toast.toast_container position="top-center">
          <Toast.toast id="t1">Toast</Toast.toast>
        </Toast.toast_container>
        """)

      assert html =~ "toast-top"
      assert html =~ "toast-center"
    end

    test "renders with middle-center position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Toast.toast_container position="middle-center">
          <Toast.toast id="t1">Toast</Toast.toast>
        </Toast.toast_container>
        """)

      assert html =~ "toast-middle"
      assert html =~ "toast-center"
    end
  end

  describe "custom classes" do
    test "applies custom class to toast" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Toast.toast id="t1" class="custom-toast">Message</Toast.toast>
        """)

      assert html =~ "custom-toast"
    end

    test "applies custom class to container" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Toast.toast_container class="custom-container">
          <Toast.toast id="t1">Toast</Toast.toast>
        </Toast.toast_container>
        """)

      assert html =~ "custom-container"
    end
  end

  describe "JS functions" do
    test "show_toast returns JS struct" do
      js = Toast.show_toast("test")
      assert %Phoenix.LiveView.JS{} = js
    end

    test "hide_toast returns JS struct" do
      js = Toast.hide_toast("test")
      assert %Phoenix.LiveView.JS{} = js
    end
  end
end
