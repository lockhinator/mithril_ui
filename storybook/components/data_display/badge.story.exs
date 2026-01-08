defmodule Storybook.Components.DataDisplay.Badge do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Badge.badge/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="flex flex-wrap gap-4 items-center" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :variants,
        description: "Badge color variants",
        variations: [
          %Variation{id: :default, slots: ["Default"]},
          %Variation{id: :primary, attributes: %{variant: "primary"}, slots: ["Primary"]},
          %Variation{id: :secondary, attributes: %{variant: "secondary"}, slots: ["Secondary"]},
          %Variation{id: :accent, attributes: %{variant: "accent"}, slots: ["Accent"]},
          %Variation{id: :ghost, attributes: %{variant: "ghost"}, slots: ["Ghost"]},
          %Variation{id: :info, attributes: %{variant: "info"}, slots: ["Info"]},
          %Variation{id: :success, attributes: %{variant: "success"}, slots: ["Success"]},
          %Variation{id: :warning, attributes: %{variant: "warning"}, slots: ["Warning"]},
          %Variation{id: :error, attributes: %{variant: "error"}, slots: ["Error"]}
        ]
      },
      %VariationGroup{
        id: :sizes,
        description: "Badge sizes",
        variations: [
          %Variation{id: :xs, attributes: %{size: "xs", variant: "primary"}, slots: ["XS"]},
          %Variation{id: :sm, attributes: %{size: "sm", variant: "primary"}, slots: ["SM"]},
          %Variation{id: :md, attributes: %{size: "md", variant: "primary"}, slots: ["MD"]},
          %Variation{id: :lg, attributes: %{size: "lg", variant: "primary"}, slots: ["LG"]}
        ]
      },
      %VariationGroup{
        id: :outline,
        description: "Outline badges",
        variations: [
          %Variation{id: :outline_primary, attributes: %{variant: "primary", outline: true}, slots: ["Primary"]},
          %Variation{id: :outline_secondary, attributes: %{variant: "secondary", outline: true}, slots: ["Secondary"]},
          %Variation{id: :outline_success, attributes: %{variant: "success", outline: true}, slots: ["Success"]},
          %Variation{id: :outline_error, attributes: %{variant: "error", outline: true}, slots: ["Error"]}
        ]
      }
    ]
  end
end
