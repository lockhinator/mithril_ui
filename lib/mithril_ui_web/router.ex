defmodule MithrilUiWeb.Router do
  use MithrilUiWeb, :router
  import PhoenixStorybook.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {MithrilUiWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Storybook assets (must be outside any scope)
  scope "/" do
    storybook_assets()
  end

  scope "/", MithrilUiWeb do
    pipe_through :browser

    get "/", PageController, :home

    # Phoenix Storybook
    live_storybook "/storybook", backend_module: MithrilUiWeb.Storybook
  end

  # Other scopes may use custom stacks.
  # scope "/api", MithrilUiWeb do
  #   pipe_through :api
  # end
end
