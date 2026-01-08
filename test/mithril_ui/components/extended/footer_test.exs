defmodule MithrilUI.Components.FooterTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Footer

  describe "footer/1" do
    test "renders footer container" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Footer.footer>
          <span>Content</span>
        </Footer.footer>
        """)

      assert html =~ "<footer"
      assert html =~ "footer"
    end

    test "renders centered footer" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Footer.footer center>
          <span>Content</span>
        </Footer.footer>
        """)

      assert html =~ "footer-center"
    end

    test "renders horizontal footer" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Footer.footer horizontal>
          <span>Content</span>
        </Footer.footer>
        """)

      assert html =~ "footer-horizontal"
    end

    test "applies custom background" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Footer.footer bg="bg-neutral">
          <span>Content</span>
        </Footer.footer>
        """)

      assert html =~ "bg-neutral"
    end

    test "applies custom text color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Footer.footer text="text-neutral-content">
          <span>Content</span>
        </Footer.footer>
        """)

      assert html =~ "text-neutral-content"
    end
  end

  describe "footer_nav/1" do
    test "renders navigation section" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Footer.footer_nav>
          <a href="#">Link</a>
        </Footer.footer_nav>
        """)

      assert html =~ "<nav"
    end

    test "renders with title" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Footer.footer_nav title="Services">
          <a href="#">Link</a>
        </Footer.footer_nav>
        """)

      assert html =~ "footer-title"
      assert html =~ "Services"
    end
  end

  describe "footer_aside/1" do
    test "renders aside section" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Footer.footer_aside>
          Company info
        </Footer.footer_aside>
        """)

      assert html =~ "<aside"
      assert html =~ "Company info"
    end

    test "renders with logo slot" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Footer.footer_aside>
          <:logo>Logo</:logo>
          Info
        </Footer.footer_aside>
        """)

      assert html =~ "Logo"
    end
  end

  describe "footer_social/1" do
    test "renders social links section" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Footer.footer_social>
          <a href="#">Twitter</a>
        </Footer.footer_social>
        """)

      assert html =~ "<nav"
      assert html =~ "grid-flow-col"
    end
  end

  describe "footer_with_social/1" do
    test "renders footer with Twitter link" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Footer.footer_with_social twitter="https://twitter.com/example" />
        """)

      assert html =~ ~s(href="https://twitter.com/example")
      assert html =~ ~s(aria-label="Twitter")
    end

    test "renders footer with GitHub link" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Footer.footer_with_social github="https://github.com/example" />
        """)

      assert html =~ ~s(href="https://github.com/example")
      assert html =~ ~s(aria-label="GitHub")
    end

    test "renders footer with YouTube link" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Footer.footer_with_social youtube="https://youtube.com/c/example" />
        """)

      assert html =~ ~s(href="https://youtube.com/c/example")
    end

    test "renders footer with Facebook link" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Footer.footer_with_social facebook="https://facebook.com/example" />
        """)

      assert html =~ ~s(href="https://facebook.com/example")
    end

    test "renders footer with multiple social links" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Footer.footer_with_social twitter="https://twitter.com/ex" github="https://github.com/ex" linkedin="https://linkedin.com/in/ex" />
        """)

      assert html =~ "twitter.com"
      assert html =~ "github.com"
      assert html =~ "linkedin.com"
    end

    test "renders with custom background" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Footer.footer_with_social bg="bg-primary" text="text-primary-content" />
        """)

      assert html =~ "bg-primary"
      assert html =~ "text-primary-content"
    end
  end

  describe "footer_two_row/1" do
    test "renders two-row footer with copyright" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Footer.footer_two_row copyright="Copyright 2024 - All rights reserved" />
        """)

      assert html =~ "Copyright 2024"
    end

    test "renders navigation sections" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Footer.footer_two_row copyright="2024">
          <:nav>Nav content</:nav>
        </Footer.footer_two_row>
        """)

      # Should have 2 footer elements
      assert String.split(html, "<footer") |> length() > 2
    end
  end
end
