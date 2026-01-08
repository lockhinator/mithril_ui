defmodule Storybook.Components.DataDisplay do
  use PhoenixStorybook.Index

  def folder_icon, do: {:fa, "table", :light}
  def folder_name, do: "Data Display"
  def folder_open?, do: true
end
