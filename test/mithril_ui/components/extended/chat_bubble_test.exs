defmodule MithrilUI.Components.ChatBubbleTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.ChatBubble

  describe "chat/1" do
    test "renders chat with start position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ChatBubble.chat position="start">
          <:bubble>Hello!</:bubble>
        </ChatBubble.chat>
        """)

      assert html =~ "chat"
      assert html =~ "chat-start"
    end

    test "renders chat with end position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ChatBubble.chat position="end">
          <:bubble>Hi!</:bubble>
        </ChatBubble.chat>
        """)

      assert html =~ "chat-end"
    end

    test "renders bubble with color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ChatBubble.chat position="start">
          <:bubble color="primary">Message</:bubble>
        </ChatBubble.chat>
        """)

      assert html =~ "chat-bubble-primary"
    end

    test "renders header slot" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ChatBubble.chat position="start">
          <:header>John Doe</:header>
          <:bubble>Hi</:bubble>
        </ChatBubble.chat>
        """)

      assert html =~ "chat-header"
      assert html =~ "John Doe"
    end

    test "renders footer slot" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ChatBubble.chat position="end">
          <:bubble>Message</:bubble>
          <:footer>Delivered</:footer>
        </ChatBubble.chat>
        """)

      assert html =~ "chat-footer"
      assert html =~ "Delivered"
    end

    test "renders avatar slot" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ChatBubble.chat position="start">
          <:avatar src="/avatar.jpg"></:avatar>
          <:bubble>Hi</:bubble>
        </ChatBubble.chat>
        """)

      assert html =~ "chat-image"
      assert html =~ ~s(src="/avatar.jpg")
    end
  end

  describe "chat_message/1" do
    test "renders simple chat message" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ChatBubble.chat_message position="start">
          Hello!
        </ChatBubble.chat_message>
        """)

      assert html =~ "chat-start"
      assert html =~ "chat-bubble"
      assert html =~ "Hello!"
    end

    test "renders with sender and time" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ChatBubble.chat_message position="start" sender="Alice" time="12:45">
          Hi
        </ChatBubble.chat_message>
        """)

      assert html =~ "chat-header"
      assert html =~ "Alice"
      assert html =~ "12:45"
    end

    test "renders with avatar" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ChatBubble.chat_message position="end" avatar_src="/me.jpg">
          Message
        </ChatBubble.chat_message>
        """)

      assert html =~ "chat-image"
      assert html =~ ~s(src="/me.jpg")
    end

    test "renders with status" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ChatBubble.chat_message position="end" status="Read">
          Message
        </ChatBubble.chat_message>
        """)

      assert html =~ "chat-footer"
      assert html =~ "Read"
    end

    test "applies color to bubble" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ChatBubble.chat_message position="end" color="primary">
          Hi
        </ChatBubble.chat_message>
        """)

      assert html =~ "chat-bubble-primary"
    end
  end

  describe "chat_image/1" do
    test "renders chat with image attachment" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ChatBubble.chat_image position="start" image_src="/photo.jpg" />
        """)

      assert html =~ "chat-start"
      assert html =~ ~s(src="/photo.jpg")
    end

    test "renders with caption" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ChatBubble.chat_image position="start" image_src="/photo.jpg" caption="Check this out!" />
        """)

      assert html =~ "Check this out!"
    end
  end

  describe "chat_file/1" do
    test "renders chat with file attachment" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ChatBubble.chat_file position="start" file_name="document.pdf" />
        """)

      assert html =~ "chat-start"
      assert html =~ "document.pdf"
    end

    test "renders with file metadata" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ChatBubble.chat_file position="start" file_name="report.pdf" file_size="2.4 MB" file_type="PDF" />
        """)

      assert html =~ "report.pdf"
      assert html =~ "2.4 MB"
      assert html =~ "PDF"
    end

    test "renders with download link" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ChatBubble.chat_file position="start" file_name="doc.pdf" download_url="/files/doc.pdf" />
        """)

      assert html =~ ~s(href="/files/doc.pdf")
      assert html =~ "download"
    end
  end

  describe "chat_conversation/1" do
    test "renders conversation container" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ChatBubble.chat_conversation>
          Messages here
        </ChatBubble.chat_conversation>
        """)

      assert html =~ "space-y-4"
    end
  end
end
