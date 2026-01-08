defmodule Storybook.Components do
  use PhoenixStorybook.Index

  def folder_icon, do: {:fa, "puzzle-piece", :light}
  def folder_name, do: "Components"
  def folder_open?, do: true
end
