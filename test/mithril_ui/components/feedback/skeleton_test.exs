defmodule MithrilUI.Components.SkeletonTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Skeleton

  describe "skeleton/1 rendering" do
    test "renders basic skeleton" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton class="h-4 w-32" />
        """)

      assert html =~ "skeleton"
    end

    test "has aria-hidden" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton class="h-4 w-32" />
        """)

      assert html =~ ~s(aria-hidden="true")
    end

    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton class="h-8 w-full" />
        """)

      assert html =~ "h-8"
      assert html =~ "w-full"
    end
  end

  describe "skeleton rounded" do
    test "renders md rounded by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton class="h-4 w-32" />
        """)

      assert html =~ "rounded-md"
    end

    test "renders full rounded" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton class="h-4 w-32" rounded="full" />
        """)

      assert html =~ "rounded-full"
    end

    test "renders no rounded" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton class="h-4 w-32" rounded="none" />
        """)

      assert html =~ "rounded-none"
    end
  end

  describe "skeleton_text/1" do
    test "renders 3 lines by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton_text />
        """)

      # Count skeleton divs (should be 3)
      count = length(String.split(html, "skeleton h-3")) - 1
      assert count == 3
    end

    test "renders custom number of lines" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton_text lines={5} />
        """)

      count = length(String.split(html, "skeleton h-3")) - 1
      assert count == 5
    end

    test "last line is shorter" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton_text />
        """)

      assert html =~ "w-2/3"
    end
  end

  describe "skeleton_avatar/1" do
    test "renders avatar skeleton" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton_avatar />
        """)

      assert html =~ "skeleton"
      assert html =~ "rounded-full"
    end

    test "renders md size by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton_avatar />
        """)

      assert html =~ "h-10"
      assert html =~ "w-10"
    end

    test "renders different sizes" do
      assigns = %{}

      html_xs =
        rendered_to_string(~H"""
        <Skeleton.skeleton_avatar size="xs" />
        """)

      html_xl =
        rendered_to_string(~H"""
        <Skeleton.skeleton_avatar size="xl" />
        """)

      assert html_xs =~ "h-6"
      assert html_xl =~ "h-16"
    end

    test "renders square shape" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton_avatar shape="square" />
        """)

      assert html =~ "rounded-lg"
      refute html =~ "rounded-full"
    end
  end

  describe "skeleton_card/1" do
    test "renders card skeleton" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton_card />
        """)

      assert html =~ "card"
      assert html =~ "card-body"
    end

    test "includes image placeholder by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton_card />
        """)

      assert html =~ "h-48"
      assert html =~ "figure"
    end

    test "hides image when with_image=false" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton_card with_image={false} />
        """)

      refute html =~ "figure"
    end

    test "renders custom lines" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton_card lines={2} />
        """)

      count = length(String.split(html, "skeleton h-3")) - 1
      assert count == 2
    end
  end

  describe "skeleton_table/1" do
    test "renders table skeleton" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton_table />
        """)

      assert html =~ "<table"
      assert html =~ "<thead"
      assert html =~ "<tbody"
    end

    test "renders 5 rows by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton_table />
        """)

      # Count tbody rows
      # subtract header row and empty split
      count = length(String.split(html, "<tr>")) - 2
      assert count == 5
    end

    test "renders custom rows" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton_table rows={3} />
        """)

      count = length(String.split(html, "<tr>")) - 2
      assert count == 3
    end
  end

  describe "skeleton_list/1" do
    test "renders list skeleton" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton_list />
        """)

      assert html =~ "<ul"
      assert html =~ "<li"
    end

    test "renders 5 items by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton_list />
        """)

      count = length(String.split(html, "<li")) - 1
      assert count == 5
    end

    test "renders avatar when enabled" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton_list with_avatar />
        """)

      assert html =~ "rounded-full"
      assert html =~ "h-10 w-10"
    end

    test "no avatar by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton_list />
        """)

      refute html =~ "rounded-full"
    end
  end

  describe "custom classes" do
    test "applies class to skeleton_text" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton_text class="my-text" />
        """)

      assert html =~ "my-text"
    end

    test "applies class to skeleton_card" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Skeleton.skeleton_card class="my-card" />
        """)

      assert html =~ "my-card"
    end
  end
end
