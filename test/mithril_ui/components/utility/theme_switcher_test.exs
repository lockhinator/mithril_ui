defmodule MithrilUI.Components.ThemeSwitcherTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.ThemeSwitcher

  describe "theme_switcher/1" do
    test "renders basic theme switcher dropdown" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ThemeSwitcher.theme_switcher />
        """)

      assert html =~ "dropdown"
      assert html =~ "dropdown-end"
      assert html =~ "dropdown-content"
      assert html =~ "data-set-theme"
    end

    test "renders with custom id" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ThemeSwitcher.theme_switcher id="my-theme-picker" />
        """)

      assert html =~ "dropdown"
    end

    test "renders with label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ThemeSwitcher.theme_switcher label="Theme" />
        """)

      assert html =~ "Theme"
    end

    test "renders custom themes list" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ThemeSwitcher.theme_switcher themes={["light", "dark", "cupcake"]} />
        """)

      assert html =~ "light"
      assert html =~ "dark"
      assert html =~ "cupcake"
    end

    test "renders with custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ThemeSwitcher.theme_switcher class="my-custom-class" />
        """)

      assert html =~ "my-custom-class"
    end
  end

  describe "theme_toggle/1" do
    test "renders light/dark toggle button" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ThemeSwitcher.theme_toggle />
        """)

      assert html =~ "swap"
      assert html =~ "swap-rotate"
      assert html =~ "theme-controller"
    end

    test "renders with custom themes" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ThemeSwitcher.theme_toggle light_theme="corporate" dark_theme="business" />
        """)

      assert html =~ "business"
      assert html =~ "corporate"
    end

    test "renders with custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ThemeSwitcher.theme_toggle class="custom-toggle" />
        """)

      assert html =~ "custom-toggle"
    end
  end

  describe "theme_preview_selector/1" do
    test "renders theme preview grid" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ThemeSwitcher.theme_preview_selector />
        """)

      assert html =~ "grid"
      assert html =~ "data-set-theme"
    end

    test "renders with custom themes" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ThemeSwitcher.theme_preview_selector themes={["light", "dark"]} />
        """)

      assert html =~ "light"
      assert html =~ "dark"
    end

    test "renders with custom columns" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ThemeSwitcher.theme_preview_selector columns={2} />
        """)

      assert html =~ "grid-cols-2"
    end

    test "renders with custom id" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ThemeSwitcher.theme_preview_selector id="preview-selector" />
        """)

      assert html =~ ~s(id="preview-selector")
    end
  end

  describe "theme_radio_group/1" do
    test "renders radio button group" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ThemeSwitcher.theme_radio_group name="theme-select" />
        """)

      assert html =~ ~s(type="radio")
      assert html =~ ~s(name="theme-select")
      assert html =~ "badge"
    end

    test "renders with custom themes" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ThemeSwitcher.theme_radio_group name="theme" themes={["light", "dark"]} />
        """)

      assert html =~ "light"
      assert html =~ "dark"
    end

    test "renders with selected theme" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ThemeSwitcher.theme_radio_group name="theme" themes={["light", "dark"]} selected="dark" />
        """)

      assert html =~ "checked"
    end

    test "renders with custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <ThemeSwitcher.theme_radio_group name="theme" class="custom-class" />
        """)

      assert html =~ "custom-class"
    end
  end
end
