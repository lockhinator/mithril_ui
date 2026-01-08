defmodule Mix.Tasks.MithrilUi.InstallTest do
  use ExUnit.Case, async: false

  import ExUnit.CaptureIO

  @test_dir "test/tmp/install_test"

  setup do
    # Create a fresh test directory for each test
    File.rm_rf!(@test_dir)
    File.mkdir_p!(@test_dir)

    # Change to test directory
    original_dir = File.cwd!()
    File.cd!(@test_dir)

    # Create the common directories that installer expects
    File.mkdir_p!("config")
    File.mkdir_p!("assets/js")
    File.mkdir_p!("assets/css")

    on_exit(fn ->
      File.cd!(original_dir)
      File.rm_rf!(@test_dir)
    end)

    :ok
  end

  describe "run/1" do
    test "shows installer banner" do
      output =
        capture_io(fn ->
          Mix.Tasks.MithrilUi.Install.run(["--dry-run"])
        end)

      assert output =~ "Mithril UI Installer"
    end

    test "dry run does not create files" do
      capture_io(fn ->
        Mix.Tasks.MithrilUi.Install.run(["--dry-run"])
      end)

      refute File.exists?("config/mithril_ui.exs")
    end

    test "creates config file when not present" do
      File.write!("config/config.exs", """
      import Config
      import_config "\#{config_env()}.exs"
      """)

      capture_io(fn ->
        Mix.Tasks.MithrilUi.Install.run([])
      end)

      assert File.exists?("config/mithril_ui.exs")
      content = File.read!("config/mithril_ui.exs")
      assert content =~ "config :mithril_ui"
      assert content =~ "default_theme"
    end

    test "injects import into config.exs" do
      File.write!("config/config.exs", """
      import Config
      import_config "\#{config_env()}.exs"
      """)

      capture_io(fn ->
        Mix.Tasks.MithrilUi.Install.run([])
      end)

      config_content = File.read!("config/config.exs")
      assert config_content =~ "mithril_ui.exs"
    end

    test "skips config with --no-config flag" do
      File.write!("config/config.exs", "import Config\n")

      output =
        capture_io(fn ->
          Mix.Tasks.MithrilUi.Install.run(["--no-config"])
        end)

      refute File.exists?("config/mithril_ui.exs")
      assert output =~ "skipped (--no-config)"
    end

    test "updates tailwind config with daisyui" do
      File.write!("assets/tailwind.config.js", """
      module.exports = {
        content: ["./js/**/*.js"],
        plugins: []
      };
      """)

      capture_io(fn ->
        Mix.Tasks.MithrilUi.Install.run([])
      end)

      content = File.read!("assets/tailwind.config.js")
      assert content =~ "daisyui"
    end

    test "skips tailwind with --no-tailwind flag" do
      File.write!("assets/tailwind.config.js", """
      module.exports = { plugins: [] };
      """)

      output =
        capture_io(fn ->
          Mix.Tasks.MithrilUi.Install.run(["--no-tailwind"])
        end)

      content = File.read!("assets/tailwind.config.js")
      refute content =~ "daisyui"
      assert output =~ "skipped (--no-tailwind)"
    end

    test "adds source directive to app.css" do
      File.write!("assets/css/app.css", """
      @import "tailwindcss";
      body { margin: 0; }
      """)

      capture_io(fn ->
        Mix.Tasks.MithrilUi.Install.run([])
      end)

      content = File.read!("assets/css/app.css")
      assert content =~ "@source"
      assert content =~ "mithril_ui"
    end

    test "adds javascript hooks to app.js" do
      File.write!("assets/js/app.js", """
      import "phoenix_html"
      """)

      capture_io(fn ->
        Mix.Tasks.MithrilUi.Install.run([])
      end)

      content = File.read!("assets/js/app.js")
      assert content =~ "MithrilTheme"
      assert content =~ "MithrilClipboard"
      assert content =~ "MithrilHooks"
    end

    test "skips js with --no-js flag" do
      File.write!("assets/js/app.js", "// app.js\n")

      output =
        capture_io(fn ->
          Mix.Tasks.MithrilUi.Install.run(["--no-js"])
        end)

      content = File.read!("assets/js/app.js")
      refute content =~ "MithrilTheme"
      assert output =~ "skipped (--no-js)"
    end

    test "prints next steps" do
      output =
        capture_io(fn ->
          Mix.Tasks.MithrilUi.Install.run(["--dry-run"])
        end)

      assert output =~ "Next Steps"
      assert output =~ "Install DaisyUI"
      assert output =~ "Import components"
      assert output =~ "use MithrilUI.Components"
    end

    test "detects already configured files" do
      File.write!("assets/css/app.css", """
      @source "../../deps/mithril_ui/lib/**/*.ex";
      """)

      output =
        capture_io(fn ->
          Mix.Tasks.MithrilUi.Install.run([])
        end)

      assert output =~ "already configured"
    end

    test "handles missing tailwind config gracefully" do
      output =
        capture_io(fn ->
          Mix.Tasks.MithrilUi.Install.run([])
        end)

      assert output =~ "not found"
    end
  end
end
