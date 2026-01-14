# Check if web tests should be run (via --include web flag)
# We need to check this before ExUnit.start() to start the application
run_web_tests? =
  case Enum.find_index(System.argv(), &(&1 == "--include")) do
    nil -> false
    idx -> Enum.at(System.argv(), idx + 1) == "web"
  end

# Start the endpoint for web tests if not already started
# (the application supervisor may have already started it)
if run_web_tests? do
  {:ok, _} = Application.ensure_all_started(:phoenix)
  {:ok, _} = Application.ensure_all_started(:phoenix_live_view)

  case MithrilUiWeb.Endpoint.start_link() do
    {:ok, _} -> :ok
    {:error, {:already_started, _}} -> :ok
  end
end

# Exclude web tests by default since they require the endpoint.
# Run them explicitly with: mix test --include web
ExUnit.start(exclude: [:web])
