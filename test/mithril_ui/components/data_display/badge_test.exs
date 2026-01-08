defmodule MithrilUI.Components.BadgeTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Badge

  describe "badge/1 rendering" do
    test "renders basic badge" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.badge>New</Badge.badge>
        """)

      assert html =~ "badge"
      assert html =~ "New"
    end
  end

  describe "badge variants" do
    test "renders primary variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.badge variant="primary">Primary</Badge.badge>
        """)

      assert html =~ "badge-primary"
    end

    test "renders secondary variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.badge variant="secondary">Secondary</Badge.badge>
        """)

      assert html =~ "badge-secondary"
    end

    test "renders success variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.badge variant="success">Success</Badge.badge>
        """)

      assert html =~ "badge-success"
    end

    test "renders warning variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.badge variant="warning">Warning</Badge.badge>
        """)

      assert html =~ "badge-warning"
    end

    test "renders error variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.badge variant="error">Error</Badge.badge>
        """)

      assert html =~ "badge-error"
    end
  end

  describe "badge sizes" do
    test "renders xs size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.badge size="xs">XS</Badge.badge>
        """)

      assert html =~ "badge-xs"
    end

    test "renders sm size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.badge size="sm">SM</Badge.badge>
        """)

      assert html =~ "badge-sm"
    end

    test "renders lg size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.badge size="lg">LG</Badge.badge>
        """)

      assert html =~ "badge-lg"
    end

    test "md size is default (no class)" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.badge size="md">MD</Badge.badge>
        """)

      refute html =~ "badge-md"
    end
  end

  describe "badge outline" do
    test "renders outline style" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.badge outline>Outline</Badge.badge>
        """)

      assert html =~ "badge-outline"
    end

    test "renders outline with variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.badge variant="primary" outline>Outline Primary</Badge.badge>
        """)

      assert html =~ "badge-outline"
      assert html =~ "badge-primary"
    end
  end

  describe "badge_with_icon/1" do
    test "renders badge with icon slot" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.badge_with_icon variant="info">
          <:icon>★</:icon>
          Info
        </Badge.badge_with_icon>
        """)

      assert html =~ "★"
      assert html =~ "Info"
    end

    test "renders icon on left by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.badge_with_icon>
          <:icon>I</:icon>
          Text
        </Badge.badge_with_icon>
        """)

      # Icon should appear before text
      icon_pos = :binary.match(html, "I") |> elem(0)
      text_pos = :binary.match(html, "Text") |> elem(0)
      assert icon_pos < text_pos
    end

    test "renders icon on right when specified" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.badge_with_icon icon_position="right">
          <:icon>ICON</:icon>
          Text
        </Badge.badge_with_icon>
        """)

      # Icon should appear after text
      text_pos = :binary.match(html, "Text") |> elem(0)
      icon_pos = :binary.match(html, "ICON") |> elem(0)
      assert icon_pos > text_pos
    end
  end

  describe "indicator_badge/1" do
    test "renders count badge" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.indicator_badge count={5} />
        """)

      assert html =~ "5"
    end

    test "shows max+ when count exceeds max" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.indicator_badge count={150} max={99} />
        """)

      assert html =~ "99+"
    end

    test "hides badge when count is 0 by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.indicator_badge count={0} />
        """)

      refute html =~ "badge"
    end

    test "shows badge when count is 0 with show_zero" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.indicator_badge count={0} show_zero />
        """)

      assert html =~ "badge"
      assert html =~ "0"
    end

    test "applies variant to indicator badge" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.indicator_badge count={10} variant="error" />
        """)

      assert html =~ "badge-error"
    end
  end

  describe "custom classes" do
    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Badge.badge class="my-badge">Badge</Badge.badge>
        """)

      assert html =~ "my-badge"
    end
  end
end
