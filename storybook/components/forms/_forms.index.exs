defmodule Storybook.Components.Forms do
  use PhoenixStorybook.Index

  def folder_icon, do: {:fa, "edit", :light}
  def folder_name, do: "Forms"
  def folder_open?, do: true
end
