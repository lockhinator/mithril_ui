defmodule Storybook.WelcomeTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest

  describe "Storybook.Welcome" do
    test "renders welcome tab" do
      html = render_component(&Storybook.Welcome.render/1, tab: :welcome)

      assert html =~ "Mithril UI"
      assert html =~ "DaisyUI theming"
      assert html =~ "50+ Components"
      assert html =~ "Component Categories"
      assert html =~ "button, button_group, dropdown"
    end

    test "renders getting_started tab" do
      html = render_component(&Storybook.Welcome.render/1, tab: :getting_started)

      assert html =~ "Getting Started"
      assert html =~ "Installation"
      assert html =~ "mithril_ui"
      assert html =~ "mix deps.get"
      assert html =~ "MithrilUI.Components"
      assert html =~ "Mix Tasks"
    end

    test "renders patterns tab" do
      html = render_component(&Storybook.Welcome.render/1, tab: :patterns)

      assert html =~ "Code Patterns"
      assert html =~ "Component Structure"
      assert html =~ "Variants Pattern"
      assert html =~ "Sizes Pattern"
      assert html =~ "Slots Pattern"
      assert html =~ "LiveView.JS Integration"
      assert html =~ "Global Attributes"
    end

    test "renders theming tab" do
      html = render_component(&Storybook.Welcome.render/1, tab: :theming)

      assert html =~ "Theming"
      assert html =~ "35 built-in themes"
      assert html =~ "Built-in Themes"
      assert html =~ "Configuration"
      assert html =~ "Theme Switcher Component"
      assert html =~ "Custom Themes"
      assert html =~ "Semantic Colors"
    end

    test "module defines doc/0" do
      assert Storybook.Welcome.doc() == "Mithril UI - A Phoenix LiveView Component Library"
    end

    test "module defines navigation/0 with all tabs" do
      nav = Storybook.Welcome.navigation()

      assert length(nav) == 4
      assert {:welcome, "Welcome", {:fa, "home", :solid}} in nav
      assert {:getting_started, "Getting Started", {:fa, "rocket", :solid}} in nav
      assert {:patterns, "Patterns", {:fa, "code", :solid}} in nav
      assert {:theming, "Theming", {:fa, "palette", :solid}} in nav
    end
  end
end
