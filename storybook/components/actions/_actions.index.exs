defmodule Storybook.Components.Actions do
  use PhoenixStorybook.Index

  def folder_icon, do: {:fa, "hand-pointer", :light}
  def folder_name, do: "Actions"
  def folder_open?, do: true
end
