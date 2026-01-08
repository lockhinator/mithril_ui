defmodule MithrilUI.Components.ModalTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Modal

  describe "modal/1 rendering" do
    test "renders basic modal" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Modal.modal id="my-modal">
          Modal content
        </Modal.modal>
        """)

      assert html =~ "modal"
      assert html =~ "Modal content"
      assert html =~ ~s(id="my-modal")
    end

    test "renders modal-box container" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Modal.modal id="m1">Content</Modal.modal>
        """)

      assert html =~ "modal-box"
    end

    test "renders backdrop" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Modal.modal id="m1">Content</Modal.modal>
        """)

      assert html =~ "modal-backdrop"
    end
  end

  describe "modal title slot" do
    test "renders title when provided" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Modal.modal id="m1">
          <:title>My Title</:title>
          Content
        </Modal.modal>
        """)

      assert html =~ "My Title"
      assert html =~ "font-bold"
    end

    test "sets aria-labelledby when title provided" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Modal.modal id="m1">
          <:title>Title</:title>
          Content
        </Modal.modal>
        """)

      assert html =~ ~s(aria-labelledby="m1-title")
      assert html =~ ~s(id="m1-title")
    end
  end

  describe "modal actions slot" do
    test "renders actions when provided" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Modal.modal id="m1">
          Content
          <:actions>
            <button>Save</button>
          </:actions>
        </Modal.modal>
        """)

      assert html =~ "modal-action"
      assert html =~ "Save"
    end

    test "hides actions section when not provided" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Modal.modal id="m1">Content only</Modal.modal>
        """)

      refute html =~ "modal-action"
    end
  end

  describe "modal close button" do
    test "renders close button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Modal.modal id="m1">Content</Modal.modal>
        """)

      assert html =~ ~s(aria-label="Close")
    end
  end

  describe "modal accessibility" do
    test "has role=dialog" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Modal.modal id="m1">Content</Modal.modal>
        """)

      assert html =~ ~s(role="dialog")
    end

    test "has aria-modal=true" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Modal.modal id="m1">Content</Modal.modal>
        """)

      assert html =~ ~s(aria-modal="true")
    end

    test "has escape key handler" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Modal.modal id="m1">Content</Modal.modal>
        """)

      assert html =~ ~s(phx-key="escape")
    end
  end

  describe "modal custom class" do
    test "applies custom class to modal-box" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Modal.modal id="m1" class="max-w-lg">Content</Modal.modal>
        """)

      assert html =~ "max-w-lg"
    end
  end

  describe "JS functions" do
    test "show_modal returns JS struct" do
      js = Modal.show_modal("test")
      assert %Phoenix.LiveView.JS{} = js
    end

    test "hide_modal returns JS struct" do
      js = Modal.hide_modal("test")
      assert %Phoenix.LiveView.JS{} = js
    end
  end
end
