defmodule MithrilUI.Components.BreadcrumbTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Breadcrumb

  describe "breadcrumb/1" do
    test "renders basic breadcrumb" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Breadcrumb.breadcrumb>
          <:item href="/">Home</:item>
          <:item href="/products">Products</:item>
          <:item>Current</:item>
        </Breadcrumb.breadcrumb>
        """)

      assert html =~ "breadcrumbs"
      assert html =~ "<ul>"
      assert html =~ "Home"
      assert html =~ "Products"
      assert html =~ "Current"
    end

    test "renders links for items with href" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Breadcrumb.breadcrumb>
          <:item href="/">Home</:item>
          <:item>Current</:item>
        </Breadcrumb.breadcrumb>
        """)

      assert html =~ ~s(href="/")
      assert html =~ "Home"
      # Current item should be span, not link
      assert html =~ "<span"
    end

    test "renders with navigate attribute" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Breadcrumb.breadcrumb>
          <:item navigate="/dashboard">Dashboard</:item>
        </Breadcrumb.breadcrumb>
        """)

      assert html =~ "navigate="
      assert html =~ "/dashboard"
    end

    test "renders with patch attribute" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Breadcrumb.breadcrumb>
          <:item patch="/settings">Settings</:item>
        </Breadcrumb.breadcrumb>
        """)

      assert html =~ "patch="
      assert html =~ "/settings"
    end

    test "applies text size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Breadcrumb.breadcrumb size="lg">
          <:item href="/">Home</:item>
        </Breadcrumb.breadcrumb>
        """)

      assert html =~ "text-lg"
    end

    test "applies default size" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Breadcrumb.breadcrumb>
          <:item href="/">Home</:item>
        </Breadcrumb.breadcrumb>
        """)

      assert html =~ "text-sm"
    end

    test "applies max width for overflow" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Breadcrumb.breadcrumb max_width="xs">
          <:item href="/">Home</:item>
        </Breadcrumb.breadcrumb>
        """)

      assert html =~ "max-w-xs"
      assert html =~ "overflow-x-auto"
    end

    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Breadcrumb.breadcrumb class="custom-class">
          <:item href="/">Home</:item>
        </Breadcrumb.breadcrumb>
        """)

      assert html =~ "custom-class"
    end

    test "renders icon content" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Breadcrumb.breadcrumb>
          <:item href="/" icon="H">Home</:item>
        </Breadcrumb.breadcrumb>
        """)

      assert html =~ "H"
      assert html =~ "gap-2"
    end
  end

  describe "breadcrumb_from_segments/1" do
    test "renders breadcrumb from segments list" do
      assigns = %{segments: ["products", "electronics"]}

      html =
        rendered_to_string(~H"""
        <Breadcrumb.breadcrumb_from_segments segments={@segments} />
        """)

      assert html =~ "breadcrumbs"
      assert html =~ "Home"
      assert html =~ "Products"
      assert html =~ "Electronics"
    end

    test "generates correct paths" do
      assigns = %{segments: ["products", "phones"]}

      html =
        rendered_to_string(~H"""
        <Breadcrumb.breadcrumb_from_segments segments={@segments} />
        """)

      assert html =~ ~s(href="/")
      assert html =~ ~s(href="/products")
      # Last item is not a link
      assert html =~ "Phones"
    end

    test "uses custom base path" do
      assigns = %{segments: ["users"]}

      html =
        rendered_to_string(~H"""
        <Breadcrumb.breadcrumb_from_segments segments={@segments} base_path="/admin" />
        """)

      assert html =~ ~s(href="/admin")
      assert html =~ "Users"
    end

    test "hides home when home=false" do
      assigns = %{segments: ["products"]}

      html =
        rendered_to_string(~H"""
        <Breadcrumb.breadcrumb_from_segments segments={@segments} home={false} />
        """)

      refute html =~ "Home"
    end

    test "uses custom home label" do
      assigns = %{segments: ["products"]}

      html =
        rendered_to_string(~H"""
        <Breadcrumb.breadcrumb_from_segments segments={@segments} home_label="Dashboard" />
        """)

      assert html =~ "Dashboard"
      refute html =~ ">Home<"
    end

    test "humanizes segment names" do
      assigns = %{segments: ["user-settings", "account_info"]}

      html =
        rendered_to_string(~H"""
        <Breadcrumb.breadcrumb_from_segments segments={@segments} />
        """)

      assert html =~ "User Settings"
      assert html =~ "Account Info"
    end

    test "last segment is not a link" do
      assigns = %{segments: ["products", "current"]}

      html =
        rendered_to_string(~H"""
        <Breadcrumb.breadcrumb_from_segments segments={@segments} />
        """)

      # Current should be a span, not a link
      assert html =~ "<span>Current</span>"
    end
  end
end
