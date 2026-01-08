defmodule MithrilUI.Components.Table do
  @moduledoc """
  Table component for displaying tabular data with optional sorting and selection.

  ## Examples

  Basic table:

      <.table id="users" rows={@users}>
        <:col :let={user} label="Name"><%= user.name %></:col>
        <:col :let={user} label="Email"><%= user.email %></:col>
      </.table>

  With row click:

      <.table id="users" rows={@users} row_click={fn user -> JS.navigate("/users/\#{user.id}") end}>
        <:col :let={user} label="Name"><%= user.name %></:col>
      </.table>

  ## DaisyUI Classes

  - `table` - Base table styling
  - `table-zebra` - Alternating row colors
  - `table-pin-rows` - Pin header rows
  - `table-pin-cols` - Pin first column
  """

  use Phoenix.Component

  @doc """
  Renders a data table.

  ## Attributes

    * `:id` - Required. Table identifier.
    * `:rows` - The list of data rows.
    * `:row_id` - Function to generate row id. Defaults to using row index.
    * `:row_click` - JS command to run on row click.
    * `:row_class` - Function or string for row classes.
    * `:zebra` - Enable zebra striping. Defaults to false.
    * `:pin_rows` - Pin header rows. Defaults to false.
    * `:pin_cols` - Pin first column. Defaults to false.
    * `:compact` - Use compact sizing. Defaults to false.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:col` - Column definitions with `:label` for header.
      - `:label` - Column header text.
      - `:class` - Column cell classes.

  ## Examples

      <.table id="products" rows={@products} zebra>
        <:col :let={p} label="SKU"><%= p.sku %></:col>
        <:col :let={p} label="Name"><%= p.name %></:col>
        <:col :let={p} label="Price" class="text-right">$<%= p.price %></:col>
      </.table>
  """
  @spec table(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :string, required: true
  attr :rows, :list, required: true
  attr :row_id, :any, default: nil, doc: "Function to generate row id"
  attr :row_click, :any, default: nil, doc: "JS command for row click"
  attr :row_class, :any, default: nil, doc: "Function or string for row classes"
  attr :zebra, :boolean, default: false
  attr :pin_rows, :boolean, default: false
  attr :pin_cols, :boolean, default: false
  attr :compact, :boolean, default: false
  attr :class, :string, default: nil

  slot :col, required: true do
    attr :label, :string
    attr :class, :string
  end

  slot :action, doc: "Action column slot"

  def table(assigns) do
    assigns =
      with %{rows: %Phoenix.LiveView.LiveStream{}} <- assigns do
        assign(assigns, row_id: assigns.row_id || fn {id, _item} -> id end)
      end

    ~H"""
    <div class="overflow-x-auto">
      <table class={table_classes(@zebra, @pin_rows, @pin_cols, @compact, @class)}>
        <thead>
          <tr>
            <th :for={col <- @col}><%= col[:label] %></th>
            <th :if={@action != []}><span class="sr-only">Actions</span></th>
          </tr>
        </thead>
        <tbody id={@id} phx-update={match?(%Phoenix.LiveView.LiveStream{}, @rows) && "stream"}>
          <tr
            :for={row <- @rows}
            id={@row_id && @row_id.(row)}
            class={[@row_click && "cursor-pointer hover", row_class(@row_class, row)]}
            phx-click={@row_click && @row_click.(row)}
          >
            <td :for={col <- @col} class={col[:class]}>
              {render_slot(col, extract_row(row))}
            </td>
            <td :if={@action != []}>
              <div class="flex gap-2 justify-end">
                {render_slot(@action, extract_row(row))}
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    """
  end

  defp extract_row({_id, row}), do: row
  defp extract_row(row), do: row

  defp row_class(nil, _row), do: nil
  defp row_class(class, _row) when is_binary(class), do: class
  defp row_class(func, row) when is_function(func, 1), do: func.(row)

  defp table_classes(zebra, pin_rows, pin_cols, compact, extra_class) do
    [
      "table",
      zebra && "table-zebra",
      pin_rows && "table-pin-rows",
      pin_cols && "table-pin-cols",
      compact && "table-xs",
      extra_class
    ]
  end
end
