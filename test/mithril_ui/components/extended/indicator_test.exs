defmodule MithrilUI.Components.IndicatorTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Indicator

  describe "indicator/1" do
    test "renders indicator container" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Indicator.indicator>
          <span>Content</span>
        </Indicator.indicator>
        """)

      assert html =~ "indicator"
    end

    test "renders badge in indicator" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Indicator.indicator>
          <:badge class="badge badge-primary">New</:badge>
          <span>Content</span>
        </Indicator.indicator>
        """)

      assert html =~ "indicator-item"
      assert html =~ "New"
    end

    test "applies horizontal position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Indicator.indicator horizontal="start">
          <:badge>!</:badge>
          <span>Content</span>
        </Indicator.indicator>
        """)

      assert html =~ "indicator-start"
    end

    test "applies vertical position" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Indicator.indicator vertical="bottom">
          <:badge>!</:badge>
          <span>Content</span>
        </Indicator.indicator>
        """)

      assert html =~ "indicator-bottom"
    end
  end

  describe "status_dot/1" do
    test "renders status dot" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Indicator.status_dot />
        """)

      assert html =~ "rounded-full"
    end

    test "applies color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Indicator.status_dot color="success" />
        """)

      assert html =~ "bg-success"
    end

    test "applies pulse animation" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Indicator.status_dot pulse />
        """)

      assert html =~ "animate-pulse"
    end
  end

  describe "legend_indicator/1" do
    test "renders legend with label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Indicator.legend_indicator label="Online" />
        """)

      assert html =~ "Online"
    end

    test "applies color to dot" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Indicator.legend_indicator label="Active" color="success" />
        """)

      assert html =~ "bg-success"
    end
  end

  describe "count_indicator/1" do
    test "renders count badge" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Indicator.count_indicator count={5}>
          <button>Button</button>
        </Indicator.count_indicator>
        """)

      assert html =~ "5"
      assert html =~ "indicator-item"
    end

    test "shows max+ when count exceeds max" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Indicator.count_indicator count={150} max={99}>
          <button>Button</button>
        </Indicator.count_indicator>
        """)

      assert html =~ "99+"
    end

    test "hides when count is zero and show_zero is false" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Indicator.count_indicator count={0}>
          <button>Button</button>
        </Indicator.count_indicator>
        """)

      refute html =~ "indicator-item"
    end

    test "shows when count is zero and show_zero is true" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Indicator.count_indicator count={0} show_zero>
          <button>Button</button>
        </Indicator.count_indicator>
        """)

      assert html =~ "indicator-item"
    end
  end

  describe "avatar_status/1" do
    test "renders avatar with online status" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Indicator.avatar_status status="online">
          <div class="avatar">Avatar</div>
        </Indicator.avatar_status>
        """)

      assert html =~ "indicator"
      assert html =~ "badge-success"
    end

    test "shows offline status" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Indicator.avatar_status status="offline">
          <div>Avatar</div>
        </Indicator.avatar_status>
        """)

      assert html =~ "badge-neutral"
    end

    test "shows away status" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Indicator.avatar_status status="away">
          <div>Avatar</div>
        </Indicator.avatar_status>
        """)

      assert html =~ "badge-warning"
    end

    test "shows busy status" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Indicator.avatar_status status="busy">
          <div>Avatar</div>
        </Indicator.avatar_status>
        """)

      assert html =~ "badge-error"
    end
  end
end
