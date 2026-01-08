defmodule MithrilUiWeb.ErrorJSONTest do
  use MithrilUiWeb.ConnCase, async: true

  @moduletag :web

  test "renders 404" do
    assert MithrilUiWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert MithrilUiWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
