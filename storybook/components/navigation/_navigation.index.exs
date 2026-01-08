defmodule Storybook.Components.Navigation do
  use PhoenixStorybook.Index

  def folder_name, do: "Navigation"
  def folder_icon, do: {:fa, "compass", :regular}
  def folder_open?, do: false
end
