defmodule Storybook.Components.Navigation.Pagination do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Pagination.pagination/1
  def render_source, do: :function
  def layout, do: :one_column

  def template do
    """
    <div class="flex flex-col gap-6" psb-code-hidden>
      <.psb-variation-group />
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :basic,
        description: "Basic pagination",
        variations: [
          %Variation{
            id: :simple,
            attributes: %{current_page: 1, total_pages: 5}
          },
          %Variation{
            id: :middle,
            attributes: %{current_page: 3, total_pages: 5}
          },
          %Variation{
            id: :last_page,
            attributes: %{current_page: 5, total_pages: 5}
          }
        ]
      },
      %VariationGroup{
        id: :many_pages,
        description: "Pagination with many pages",
        variations: [
          %Variation{
            id: :start,
            attributes: %{current_page: 1, total_pages: 20}
          },
          %Variation{
            id: :middle,
            attributes: %{current_page: 10, total_pages: 20}
          },
          %Variation{
            id: :near_end,
            attributes: %{current_page: 18, total_pages: 20}
          }
        ]
      },
      %VariationGroup{
        id: :sizes,
        description: "Pagination sizes",
        variations: [
          %Variation{
            id: :xs,
            attributes: %{current_page: 3, total_pages: 5, size: "xs"}
          },
          %Variation{
            id: :sm,
            attributes: %{current_page: 3, total_pages: 5, size: "sm"}
          },
          %Variation{
            id: :md,
            attributes: %{current_page: 3, total_pages: 5, size: "md"}
          },
          %Variation{
            id: :lg,
            attributes: %{current_page: 3, total_pages: 5, size: "lg"}
          }
        ]
      },
      %VariationGroup{
        id: :with_info,
        description: "Pagination with info text",
        variations: [
          %Variation{
            id: :show_entries,
            attributes: %{
              current_page: 2,
              total_pages: 5,
              total_entries: 100,
              page_size: 20,
              show_info: true
            }
          }
        ]
      }
    ]
  end
end
