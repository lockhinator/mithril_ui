defmodule MithrilUI.Components.TableTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Table

  describe "table/1 rendering" do
    test "renders basic table" do
      assigns = %{rows: [%{name: "Alice"}, %{name: "Bob"}]}

      html =
        rendered_to_string(~H"""
        <Table.table id="test-table" rows={@rows}>
          <:col :let={row} label="Name">{row.name}</:col>
        </Table.table>
        """)

      assert html =~ "<table"
      assert html =~ "Alice"
      assert html =~ "Bob"
    end

    test "renders column headers" do
      assigns = %{rows: []}

      html =
        rendered_to_string(~H"""
        <Table.table id="test" rows={@rows}>
          <:col :let={_row} label="Name">-</:col>
          <:col :let={_row} label="Email">-</:col>
        </Table.table>
        """)

      assert html =~ "<thead"
      assert html =~ "Name"
      assert html =~ "Email"
    end

    test "renders empty table" do
      assigns = %{rows: []}

      html =
        rendered_to_string(~H"""
        <Table.table id="empty" rows={@rows}>
          <:col :let={row} label="Name">{row.name}</:col>
        </Table.table>
        """)

      assert html =~ "<table"
      assert html =~ "<tbody"
    end
  end

  describe "table variants" do
    test "renders zebra striping" do
      assigns = %{rows: [%{name: "Test"}]}

      html =
        rendered_to_string(~H"""
        <Table.table id="zebra" rows={@rows} zebra>
          <:col :let={row} label="Name">{row.name}</:col>
        </Table.table>
        """)

      assert html =~ "table-zebra"
    end

    test "renders pinned rows" do
      assigns = %{rows: []}

      html =
        rendered_to_string(~H"""
        <Table.table id="pin" rows={@rows} pin_rows>
          <:col :let={_row} label="Name">-</:col>
        </Table.table>
        """)

      assert html =~ "table-pin-rows"
    end

    test "renders pinned columns" do
      assigns = %{rows: []}

      html =
        rendered_to_string(~H"""
        <Table.table id="pin-col" rows={@rows} pin_cols>
          <:col :let={_row} label="Name">-</:col>
        </Table.table>
        """)

      assert html =~ "table-pin-cols"
    end

    test "renders compact table" do
      assigns = %{rows: []}

      html =
        rendered_to_string(~H"""
        <Table.table id="compact" rows={@rows} compact>
          <:col :let={_row} label="Name">-</:col>
        </Table.table>
        """)

      assert html =~ "table-xs"
    end
  end

  describe "table column classes" do
    test "applies column class" do
      assigns = %{rows: [%{price: 100}]}

      html =
        rendered_to_string(~H"""
        <Table.table id="col-class" rows={@rows}>
          <:col :let={row} label="Price" class="text-right">{row.price}</:col>
        </Table.table>
        """)

      assert html =~ "text-right"
    end
  end

  describe "table actions" do
    test "renders action column" do
      assigns = %{rows: [%{id: 1, name: "Test"}]}

      html =
        rendered_to_string(~H"""
        <Table.table id="actions" rows={@rows}>
          <:col :let={row} label="Name">{row.name}</:col>
          <:action :let={row}>
            <button>Edit {row.id}</button>
          </:action>
        </Table.table>
        """)

      assert html =~ "Edit 1"
      assert html =~ "sr-only"
      assert html =~ "Actions"
    end
  end

  describe "table row_id" do
    test "generates row id with function" do
      assigns = %{rows: [%{id: 123, name: "Test"}]}

      html =
        rendered_to_string(~H"""
        <Table.table id="row-id" rows={@rows} row_id={fn row -> "row-#{row.id}" end}>
          <:col :let={row} label="Name">{row.name}</:col>
        </Table.table>
        """)

      assert html =~ ~s(id="row-123")
    end
  end

  describe "custom classes" do
    test "applies custom class to table" do
      assigns = %{rows: []}

      html =
        rendered_to_string(~H"""
        <Table.table id="custom" rows={@rows} class="w-full">
          <:col :let={_row} label="Name">-</:col>
        </Table.table>
        """)

      assert html =~ "w-full"
    end
  end
end
