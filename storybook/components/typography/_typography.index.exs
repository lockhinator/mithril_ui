defmodule Storybook.Components.Typography do
  use PhoenixStorybook.Index

  def folder_icon, do: {:fa, "font", :light}
  def folder_name, do: "Typography"
  def folder_open?, do: true
end
