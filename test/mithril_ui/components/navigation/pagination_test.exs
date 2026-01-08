defmodule MithrilUI.Components.PaginationTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Pagination

  describe "pagination/1" do
    test "renders pagination controls" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Pagination.pagination current_page={1} total_pages={5} />
        """)

      assert html =~ "<nav"
      assert html =~ ~s(aria-label="Pagination")
      assert html =~ "join"
    end

    test "renders page numbers" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Pagination.pagination current_page={3} total_pages={5} />
        """)

      # Page numbers have whitespace around them
      assert html =~ "1"
      assert html =~ "2"
      assert html =~ "3"
      assert html =~ "4"
      assert html =~ "5"
      assert html =~ "phx-value-page"
    end

    test "marks current page as active" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Pagination.pagination current_page={3} total_pages={5} />
        """)

      assert html =~ "btn-active"
      assert html =~ ~s(aria-current="page")
    end

    test "disables previous button on first page" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Pagination.pagination current_page={1} total_pages={5} />
        """)

      # Check that the « button has disabled state
      assert html =~ "btn-disabled"
      assert html =~ "disabled"
    end

    test "disables next button on last page" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Pagination.pagination current_page={5} total_pages={5} />
        """)

      # Check that the » button has disabled state
      assert html =~ "btn-disabled"
    end

    test "shows ellipsis for many pages" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Pagination.pagination current_page={5} total_pages={20} />
        """)

      assert html =~ "…"
    end

    test "applies size variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Pagination.pagination current_page={1} total_pages={5} size="lg" />
        """)

      assert html =~ "btn-lg"
    end

    test "shows info text when enabled" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Pagination.pagination
          current_page={2}
          total_pages={5}
          total_entries={100}
          page_size={20}
          show_info
        />
        """)

      assert html =~ "Showing 21 to 40 of 100 entries"
    end

    test "includes phx-click event" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Pagination.pagination
          current_page={1}
          total_pages={5}
          on_page_change="change_page"
        />
        """)

      assert html =~ ~s(phx-click="change_page")
      assert html =~ "phx-value-page"
    end

    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Pagination.pagination current_page={1} total_pages={5} class="custom" />
        """)

      assert html =~ "custom"
    end
  end

  describe "simple_pagination/1" do
    test "renders previous and next buttons" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Pagination.simple_pagination current_page={3} total_pages={10} />
        """)

      assert html =~ "Previous"
      assert html =~ "Next"
    end

    test "shows current page info by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Pagination.simple_pagination current_page={5} total_pages={20} />
        """)

      assert html =~ "Page 5 of 20"
    end

    test "hides page info when show_current=false" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Pagination.simple_pagination current_page={5} total_pages={20} show_current={false} />
        """)

      refute html =~ "Page 5 of 20"
    end

    test "disables previous on first page" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Pagination.simple_pagination current_page={1} total_pages={10} />
        """)

      assert html =~ "btn-disabled"
    end

    test "disables next on last page" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Pagination.simple_pagination current_page={10} total_pages={10} />
        """)

      assert html =~ "btn-disabled"
    end

    test "applies size variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Pagination.simple_pagination current_page={1} total_pages={5} size="xs" />
        """)

      assert html =~ "btn-xs"
    end
  end

  describe "icon_pagination/1" do
    test "renders with arrow icons" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Pagination.icon_pagination current_page={3} total_pages={5} />
        """)

      assert html =~ "<svg"
      assert html =~ "viewBox"
    end

    test "renders page numbers" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Pagination.icon_pagination current_page={2} total_pages={3} />
        """)

      # Page numbers have whitespace around them
      assert html =~ "1"
      assert html =~ "2"
      assert html =~ "3"
      assert html =~ "phx-value-page"
    end

    test "includes aria labels for icon buttons" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Pagination.icon_pagination current_page={1} total_pages={5} />
        """)

      assert html =~ ~s(aria-label="Previous page")
      assert html =~ ~s(aria-label="Next page")
    end
  end
end
