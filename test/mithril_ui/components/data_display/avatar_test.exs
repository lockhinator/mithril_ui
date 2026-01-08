defmodule MithrilUI.Components.AvatarTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Avatar

  describe "avatar/1 rendering" do
    test "renders avatar with image" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Avatar.avatar src="/user.jpg" alt="User" />
        """)

      assert html =~ "avatar"
      assert html =~ ~s(src="/user.jpg")
      assert html =~ ~s(alt="User")
    end

    test "renders avatar with placeholder" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Avatar.avatar placeholder="JD" />
        """)

      assert html =~ "JD"
      assert html =~ "bg-neutral"
    end
  end

  describe "avatar sizes" do
    test "renders xs size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Avatar.avatar src="/user.jpg" size="xs" />
        """)

      assert html =~ "w-8"
    end

    test "renders sm size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Avatar.avatar src="/user.jpg" size="sm" />
        """)

      assert html =~ "w-12"
    end

    test "renders md size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Avatar.avatar src="/user.jpg" size="md" />
        """)

      assert html =~ "w-16"
    end

    test "renders lg size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Avatar.avatar src="/user.jpg" size="lg" />
        """)

      assert html =~ "w-20"
    end

    test "renders xl size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Avatar.avatar src="/user.jpg" size="xl" />
        """)

      assert html =~ "w-24"
    end
  end

  describe "avatar shapes" do
    test "renders circle shape by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Avatar.avatar src="/user.jpg" />
        """)

      assert html =~ "rounded-full"
    end

    test "renders square shape" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Avatar.avatar src="/user.jpg" shape="square" />
        """)

      assert html =~ "rounded-none"
    end

    test "renders rounded shape" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Avatar.avatar src="/user.jpg" shape="rounded" />
        """)

      assert html =~ "rounded-xl"
    end
  end

  describe "avatar status" do
    test "renders online status" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Avatar.avatar src="/user.jpg" status="online" />
        """)

      assert html =~ "online"
    end

    test "renders offline status" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Avatar.avatar src="/user.jpg" status="offline" />
        """)

      assert html =~ "offline"
    end
  end

  describe "avatar ring" do
    test "renders with ring" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Avatar.avatar src="/user.jpg" ring />
        """)

      assert html =~ "ring"
      assert html =~ "ring-primary"
    end

    test "renders with custom ring color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Avatar.avatar src="/user.jpg" ring ring_color="secondary" />
        """)

      assert html =~ "ring-secondary"
    end
  end

  describe "avatar_group/1" do
    test "renders avatar group" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Avatar.avatar_group>
          <Avatar.avatar src="/user1.jpg" />
          <Avatar.avatar src="/user2.jpg" />
        </Avatar.avatar_group>
        """)

      assert html =~ "avatar-group"
      assert html =~ "-space-x-6"
    end

    test "applies custom class to group" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Avatar.avatar_group class="my-group">
          <Avatar.avatar src="/user.jpg" />
        </Avatar.avatar_group>
        """)

      assert html =~ "my-group"
    end
  end

  describe "custom classes" do
    test "applies custom class to avatar" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Avatar.avatar src="/user.jpg" class="my-avatar" />
        """)

      assert html =~ "my-avatar"
    end
  end
end
