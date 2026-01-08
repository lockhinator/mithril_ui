defmodule MithrilUiWeb.PageController do
  use MithrilUiWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
