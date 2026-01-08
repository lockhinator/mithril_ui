defmodule MithrilUI.ThemeTest do
  use ExUnit.Case, async: true

  alias MithrilUI.Theme

  describe "builtin_themes/0" do
    test "returns all 35 DaisyUI themes" do
      themes = Theme.builtin_themes()
      assert length(themes) == 35
      assert "light" in themes
      assert "dark" in themes
      assert "cupcake" in themes
      assert "synthwave" in themes
    end
  end

  describe "available_themes/0" do
    test "returns builtin themes when no custom themes configured" do
      # Default config includes all builtin themes
      themes = Theme.available_themes()
      assert "light" in themes
      assert "dark" in themes
    end

    test "returns list of theme names as strings" do
      themes = Theme.available_themes()
      assert Enum.all?(themes, &is_binary/1)
    end
  end

  describe "theme_options/0" do
    test "returns list of maps with name, label, and color_scheme" do
      options = Theme.theme_options()

      assert is_list(options)
      assert options != []

      first = hd(options)
      assert Map.has_key?(first, :name)
      assert Map.has_key?(first, :label)
      assert Map.has_key?(first, :color_scheme)
    end

    test "color_scheme is either :light or :dark" do
      options = Theme.theme_options()

      Enum.each(options, fn theme ->
        assert theme.color_scheme in [:light, :dark]
      end)
    end
  end

  describe "default_theme/0" do
    test "returns default theme from config or 'light'" do
      theme = Theme.default_theme()
      assert is_binary(theme)
    end
  end

  describe "dark_theme/0" do
    test "returns dark theme from config or 'dark'" do
      theme = Theme.dark_theme()
      assert is_binary(theme)
    end
  end

  describe "theme_exists?/1" do
    test "returns true for existing theme" do
      assert Theme.theme_exists?("light")
      assert Theme.theme_exists?("dark")
    end

    test "returns false for non-existing theme" do
      refute Theme.theme_exists?("nonexistent_theme")
    end
  end

  describe "theme_label/1" do
    test "returns capitalized name for builtin themes" do
      assert Theme.theme_label("light") == "Light"
      assert Theme.theme_label("dark") == "Dark"
      assert Theme.theme_label("cupcake") == "Cupcake"
    end

    test "handles underscore names" do
      # Note: There may not be underscore names in builtins,
      # but custom themes could have them
      label = Theme.theme_label("some_theme")
      assert is_binary(label)
    end
  end

  describe "theme_color_scheme/1" do
    test "returns :dark for known dark themes" do
      assert Theme.theme_color_scheme("dark") == :dark
      assert Theme.theme_color_scheme("synthwave") == :dark
      assert Theme.theme_color_scheme("halloween") == :dark
      assert Theme.theme_color_scheme("dracula") == :dark
    end

    test "returns :light for light themes" do
      assert Theme.theme_color_scheme("light") == :light
      assert Theme.theme_color_scheme("cupcake") == :light
      assert Theme.theme_color_scheme("corporate") == :light
    end
  end
end
