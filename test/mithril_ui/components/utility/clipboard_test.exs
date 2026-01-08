defmodule MithrilUI.Components.ClipboardTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Clipboard

  describe "clipboard_input/1" do
    test "renders input with copy button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Clipboard.clipboard_input id="test-copy" value="test value" />
        """)

      assert html =~ ~s(id="test-copy")
      assert html =~ "test value"
      assert html =~ "join"
      assert html =~ ~s(data-copy-to-clipboard-target="test-copy")
    end

    test "renders with label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Clipboard.clipboard_input id="labeled" value="value" label="API Key" />
        """)

      assert html =~ "API Key"
      assert html =~ "label-text"
    end

    test "renders with custom button text" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Clipboard.clipboard_input id="custom" value="value" button_text="Clone" success_text="Cloned!" />
        """)

      assert html =~ "Clone"
      assert html =~ "Cloned!"
    end

    test "renders readonly by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Clipboard.clipboard_input id="readonly" value="value" />
        """)

      assert html =~ "readonly"
    end

    test "renders with custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Clipboard.clipboard_input id="styled" value="value" class="w-full" />
        """)

      assert html =~ "w-full"
    end
  end

  describe "clipboard_inline/1" do
    test "renders inline copy button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Clipboard.clipboard_inline id="inline-test" value="https://example.com" />
        """)

      assert html =~ ~s(id="inline-test")
      assert html =~ "https://example.com"
      assert html =~ "absolute"
      assert html =~ ~s(data-copy-to-clipboard-target="inline-test")
    end

    test "renders with label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Clipboard.clipboard_inline id="labeled" value="value" label="Share URL" />
        """)

      assert html =~ "Share URL"
    end

    test "includes tooltip elements" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Clipboard.clipboard_inline id="tooltip" value="value" />
        """)

      assert html =~ ~s(id="tooltip-tooltip")
      assert html =~ "Copy to clipboard"
      assert html =~ "Copied!"
    end
  end

  describe "clipboard_icon_button/1" do
    test "renders icon-only copy button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Clipboard.clipboard_icon_button target_id="source-element" />
        """)

      assert html =~ "btn"
      assert html =~ "btn-ghost"
      assert html =~ "btn-square"
      assert html =~ ~s(data-copy-to-clipboard-target="source-element")
    end

    test "renders with tooltip" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Clipboard.clipboard_icon_button target_id="source" tooltip />
        """)

      assert html =~ "tooltip-btn-source"
      assert html =~ "Copy to clipboard"
    end

    test "renders with custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Clipboard.clipboard_icon_button target_id="source" class="btn-primary" />
        """)

      assert html =~ "btn-primary"
    end
  end

  describe "clipboard_code/1" do
    test "renders code block with copy button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Clipboard.clipboard_code id="code-block" code="mix deps.get" />
        """)

      assert html =~ ~s(id="code-block")
      assert html =~ "mix deps.get"
      assert html =~ "mockup-code"
      assert html =~ ~s(data-copy-to-clipboard-target="code-block")
    end

    test "renders with language class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Clipboard.clipboard_code id="bash" code="echo hello" language="bash" />
        """)

      assert html =~ "language-bash"
    end

    test "renders with hover opacity" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Clipboard.clipboard_code id="hover" code="code" />
        """)

      assert html =~ "group"
      assert html =~ "group-hover:opacity-100"
    end
  end

  describe "clipboard_input_group/1" do
    test "renders input group with prefix" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Clipboard.clipboard_input_group id="url" prefix="https://" value="example.com" />
        """)

      assert html =~ "https://"
      assert html =~ "example.com"
      assert html =~ "join"
      assert html =~ "join-item"
    end

    test "renders with copy button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Clipboard.clipboard_input_group id="grouped" prefix="$" value="100" />
        """)

      assert html =~ ~s(data-copy-to-clipboard-target="grouped")
      assert html =~ "Copy"
    end

    test "renders readonly by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Clipboard.clipboard_input_group id="ro" prefix="@" value="user" />
        """)

      assert html =~ "readonly"
    end
  end
end
