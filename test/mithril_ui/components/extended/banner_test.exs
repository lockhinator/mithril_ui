defmodule MithrilUI.Components.BannerTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Banner

  describe "banner/1" do
    test "renders basic banner" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner>
          Announcement
        </Banner.banner>
        """)

      assert html =~ "Announcement"
    end

    test "renders dismissible banner with close button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner id="test-banner" dismissible>
          Dismissible
        </Banner.banner>
        """)

      assert html =~ ~s(aria-label="Close")
    end

    test "does not render close button when not dismissible" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner>
          Static
        </Banner.banner>
        """)

      refute html =~ ~s(aria-label="Close")
    end

    test "renders fixed top banner" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner fixed position="top">
          Top
        </Banner.banner>
        """)

      assert html =~ "fixed"
      assert html =~ "top-0"
    end

    test "renders fixed bottom banner" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner fixed position="bottom">
          Bottom
        </Banner.banner>
        """)

      assert html =~ "fixed"
      assert html =~ "bottom-0"
    end

    test "applies info variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner variant="info">
          Info
        </Banner.banner>
        """)

      assert html =~ "bg-info"
      assert html =~ "text-info-content"
    end

    test "applies success variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner variant="success">
          Success
        </Banner.banner>
        """)

      assert html =~ "bg-success"
      assert html =~ "text-success-content"
    end

    test "applies warning variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner variant="warning">
          Warning
        </Banner.banner>
        """)

      assert html =~ "bg-warning"
      assert html =~ "text-warning-content"
    end

    test "applies error variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner variant="error">
          Error
        </Banner.banner>
        """)

      assert html =~ "bg-error"
      assert html =~ "text-error-content"
    end

    test "renders icon slot" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner>
          <:icon>Icon</:icon>
          Text
        </Banner.banner>
        """)

      assert html =~ "Icon"
    end
  end

  describe "banner_cta/1" do
    test "renders CTA banner with title and button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner_cta href="/signup">
          <:title>Join Us</:title>
          <:button>Sign Up</:button>
        </Banner.banner_cta>
        """)

      assert html =~ "Join Us"
      assert html =~ "Sign Up"
      assert html =~ ~s(href="/signup")
    end

    test "renders CTA banner with description" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner_cta href="#">
          <:title>Title</:title>
          <:description>Description text</:description>
          <:button>Click</:button>
        </Banner.banner_cta>
        """)

      assert html =~ "Description text"
    end

    test "renders dismissible CTA banner" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner_cta id="cta-banner" href="#" dismissible>
          <:title>Title</:title>
          <:button>Click</:button>
        </Banner.banner_cta>
        """)

      assert html =~ ~s(aria-label="Close")
    end
  end

  describe "banner_newsletter/1" do
    test "renders newsletter banner with form" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner_newsletter action="/subscribe">
          <:title>Newsletter</:title>
        </Banner.banner_newsletter>
        """)

      assert html =~ ~s(action="/subscribe")
      assert html =~ ~s(type="email")
      assert html =~ ~s(type="submit")
    end

    test "uses custom placeholder" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner_newsletter action="#" placeholder="Your email here">
          <:title>Subscribe</:title>
        </Banner.banner_newsletter>
        """)

      assert html =~ ~s(placeholder="Your email here")
    end

    test "uses custom button text" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner_newsletter action="#" button_text="Join Now">
          <:title>Subscribe</:title>
        </Banner.banner_newsletter>
        """)

      assert html =~ "Join Now"
    end
  end

  describe "banner_info/1" do
    test "renders informational banner" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner_info>
          <:title>Notice</:title>
          <:description>Important info</:description>
        </Banner.banner_info>
        """)

      assert html =~ "Notice"
      assert html =~ "Important info"
    end

    test "renders with action buttons" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner_info>
          <:title>Title</:title>
          <:actions>Action Button</:actions>
        </Banner.banner_info>
        """)

      assert html =~ "Action Button"
    end

    test "renders with icon" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner_info>
          <:icon>Icon</:icon>
          <:title>Title</:title>
        </Banner.banner_info>
        """)

      assert html =~ "Icon"
    end

    test "applies variant styling" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Banner.banner_info variant="warning">
          <:title>Warning</:title>
        </Banner.banner_info>
        """)

      assert html =~ "bg-warning"
      assert html =~ "text-warning-content"
    end
  end
end
