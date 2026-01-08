defmodule Storybook.Components.Overlays do
  use PhoenixStorybook.Index

  def folder_icon, do: {:fa, "layer-group", :light}
  def folder_name, do: "Overlays"
  def folder_open?, do: true
end
