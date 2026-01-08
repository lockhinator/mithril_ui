defmodule MithrilUI.Theme.GeneratorTest do
  use ExUnit.Case, async: true

  alias MithrilUI.Theme.Generator

  describe "generate_css/0" do
    test "returns empty string when no themes configured" do
      # With default config (no custom themes), returns empty
      css = Generator.generate_css()
      assert is_binary(css)
    end
  end

  describe "theme_to_css/1" do
    test "generates valid CSS for a theme with colors" do
      theme = %{
        name: "test_theme",
        color_scheme: :light,
        colors: %{
          primary: "#4F46E5",
          primary_content: "#FFFFFF"
        }
      }

      css = Generator.theme_to_css(theme)

      assert css =~ ~s([data-theme="test_theme"])
      assert css =~ "color-scheme: light"
      assert css =~ "--color-primary: #4F46E5"
      assert css =~ "--color-primary-content: #FFFFFF"
    end

    test "generates CSS with dark color scheme" do
      theme = %{
        name: "dark_theme",
        color_scheme: :dark,
        colors: %{
          primary: "#818CF8"
        }
      }

      css = Generator.theme_to_css(theme)

      assert css =~ "color-scheme: dark"
    end

    test "includes radius values when provided" do
      theme = %{
        name: "rounded_theme",
        color_scheme: :light,
        colors: %{primary: "#000"},
        radius: %{
          selector: "0.5rem",
          field: "0.375rem"
        }
      }

      css = Generator.theme_to_css(theme)

      assert css =~ "--radius-selector: 0.5rem"
      assert css =~ "--radius-field: 0.375rem"
    end

    test "includes border, depth, and noise effects" do
      theme = %{
        name: "effects_theme",
        color_scheme: :light,
        colors: %{primary: "#000"},
        border: "2px",
        depth: "2",
        noise: "0.5"
      }

      css = Generator.theme_to_css(theme)

      assert css =~ "--border: 2px"
      assert css =~ "--depth: 2"
      assert css =~ "--noise: 0.5"
    end

    test "uses default values for optional properties" do
      theme = %{
        name: "minimal_theme",
        colors: %{primary: "#000"}
      }

      css = Generator.theme_to_css(theme)

      # Default color_scheme is :light
      assert css =~ "color-scheme: light"
      # Default border is 1px
      assert css =~ "--border: 1px"
    end

    test "returns empty string for invalid theme" do
      assert Generator.theme_to_css(%{}) == ""
      assert Generator.theme_to_css(nil) == ""
    end

    test "converts underscore keys to hyphenated CSS vars" do
      theme = %{
        name: "underscore_test",
        color_scheme: :light,
        colors: %{
          primary_content: "#FFF",
          base_100: "#000"
        }
      }

      css = Generator.theme_to_css(theme)

      assert css =~ "--color-primary-content"
      assert css =~ "--color-base-100"
    end
  end

  describe "default_output_path/0" do
    test "returns path ending with mithril_ui_themes.css" do
      path = Generator.default_output_path()
      assert String.ends_with?(path, "mithril_ui_themes.css")
    end

    test "returns absolute path" do
      path = Generator.default_output_path()
      assert String.starts_with?(path, "/")
    end
  end

  describe "write_css/1" do
    @tag :tmp_dir
    test "writes CSS to specified path", %{tmp_dir: tmp_dir} do
      path = Path.join(tmp_dir, "themes.css")

      # This won't write anything meaningful without custom themes configured
      result = Generator.write_css(path)

      assert result == :ok
      assert File.exists?(path)
    end

    test "returns error for invalid path" do
      result = Generator.write_css("/nonexistent/directory/themes.css")
      assert {:error, _} = result
    end
  end
end
