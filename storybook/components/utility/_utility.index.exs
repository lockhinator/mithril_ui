defmodule Storybook.Components.Utility do
  use PhoenixStorybook.Index

  def folder_name, do: "Utility"
  def folder_icon, do: {:fa, "wrench", :solid}
  def folder_open?, do: false
end
