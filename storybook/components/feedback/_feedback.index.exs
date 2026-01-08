defmodule Storybook.Components.Feedback do
  use PhoenixStorybook.Index

  def folder_icon, do: {:fa, "comment-dots", :light}
  def folder_name, do: "Feedback"
  def folder_open?, do: true
end
