defmodule MithrilUI.Components.TabsTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Tabs

  describe "tabs/1" do
    test "renders tabs container" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tabs.tabs>
          <:tab label="Tab 1" active>Content 1</:tab>
          <:tab label="Tab 2">Content 2</:tab>
        </Tabs.tabs>
        """)

      assert html =~ ~s(role="tablist")
      assert html =~ "tabs"
    end

    test "renders tab buttons" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tabs.tabs>
          <:tab label="First" active>Content</:tab>
          <:tab label="Second">Content</:tab>
        </Tabs.tabs>
        """)

      assert html =~ "First"
      assert html =~ "Second"
      assert html =~ ~s(role="tab")
    end

    test "marks active tab" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tabs.tabs>
          <:tab label="Active" active>Content</:tab>
          <:tab label="Inactive">Content</:tab>
        </Tabs.tabs>
        """)

      assert html =~ "tab-active"
      assert html =~ "aria-selected"
    end

    test "marks disabled tab" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tabs.tabs>
          <:tab label="Normal" active>Content</:tab>
          <:tab label="Disabled" disabled>Content</:tab>
        </Tabs.tabs>
        """)

      assert html =~ "tab-disabled"
      assert html =~ "disabled"
    end

    test "renders bordered variant by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tabs.tabs>
          <:tab label="Tab" active>Content</:tab>
        </Tabs.tabs>
        """)

      assert html =~ "tabs-bordered"
    end

    test "renders lifted variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tabs.tabs variant="lifted">
          <:tab label="Tab" active>Content</:tab>
        </Tabs.tabs>
        """)

      assert html =~ "tabs-lifted"
    end

    test "renders boxed variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tabs.tabs variant="boxed">
          <:tab label="Tab" active>Content</:tab>
        </Tabs.tabs>
        """)

      assert html =~ "tabs-boxed"
    end

    test "renders default variant without modifier class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tabs.tabs variant="default">
          <:tab label="Tab" active>Content</:tab>
        </Tabs.tabs>
        """)

      refute html =~ "tabs-bordered"
      refute html =~ "tabs-lifted"
      refute html =~ "tabs-boxed"
    end

    test "renders tab content for active tab" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tabs.tabs>
          <:tab label="Tab 1" active>Active Content</:tab>
          <:tab label="Tab 2">Inactive Content</:tab>
        </Tabs.tabs>
        """)

      assert html =~ ~s(role="tabpanel")
      assert html =~ "Active Content"
    end

    test "applies size variant" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tabs.tabs size="lg">
          <:tab label="Tab" active>Content</:tab>
        </Tabs.tabs>
        """)

      assert html =~ "tabs-lg"
    end

    test "renders icon in tab" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tabs.tabs>
          <:tab label="Tab" active icon="ICON">Content</:tab>
        </Tabs.tabs>
        """)

      assert html =~ "ICON"
    end
  end

  describe "controlled_tabs/1" do
    test "renders controlled tabs" do
      assigns = %{tabs: [%{id: "tab1", label: "Tab 1"}, %{id: "tab2", label: "Tab 2"}]}

      html =
        rendered_to_string(~H"""
        <Tabs.controlled_tabs tabs={@tabs} active_tab="tab1" />
        """)

      assert html =~ "Tab 1"
      assert html =~ "Tab 2"
    end

    test "marks active tab correctly" do
      assigns = %{tabs: [%{id: "first", label: "First"}, %{id: "second", label: "Second"}]}

      html =
        rendered_to_string(~H"""
        <Tabs.controlled_tabs tabs={@tabs} active_tab="first" />
        """)

      assert html =~ "tab-active"
      assert html =~ "aria-selected"
    end

    test "includes phx-click event" do
      assigns = %{tabs: [%{id: "tab1", label: "Tab"}]}

      html =
        rendered_to_string(~H"""
        <Tabs.controlled_tabs tabs={@tabs} active_tab="tab1" on_change="tab_changed" />
        """)

      assert html =~ ~s(phx-click="tab_changed")
      assert html =~ "phx-value-tab"
    end

    test "renders disabled tabs" do
      assigns = %{tabs: [%{id: "tab1", label: "Normal"}, %{id: "tab2", label: "Disabled", disabled: true}]}

      html =
        rendered_to_string(~H"""
        <Tabs.controlled_tabs tabs={@tabs} active_tab="tab1" />
        """)

      assert html =~ "tab-disabled"
    end

    test "applies variant" do
      assigns = %{tabs: [%{id: "tab1", label: "Tab"}]}

      html =
        rendered_to_string(~H"""
        <Tabs.controlled_tabs tabs={@tabs} active_tab="tab1" variant="boxed" />
        """)

      assert html =~ "tabs-boxed"
    end
  end

  describe "radio_tabs/1" do
    test "renders radio inputs" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tabs.radio_tabs name="my-tabs">
          <:tab label="Tab 1" checked>Content 1</:tab>
          <:tab label="Tab 2">Content 2</:tab>
        </Tabs.radio_tabs>
        """)

      assert html =~ ~s(type="radio")
      assert html =~ ~s(name="my-tabs")
    end

    test "sets checked state" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tabs.radio_tabs name="tabs">
          <:tab label="Checked" checked>Content</:tab>
          <:tab label="Unchecked">Content</:tab>
        </Tabs.radio_tabs>
        """)

      assert html =~ "checked"
    end

    test "renders tab content" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tabs.radio_tabs name="tabs">
          <:tab label="Tab" checked>Tab Content Here</:tab>
        </Tabs.radio_tabs>
        """)

      assert html =~ "Tab Content Here"
      assert html =~ ~s(role="tabpanel")
    end

    test "uses lifted variant by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tabs.radio_tabs name="tabs">
          <:tab label="Tab" checked>Content</:tab>
        </Tabs.radio_tabs>
        """)

      assert html =~ "tabs-lifted"
    end

    test "includes aria-label" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Tabs.radio_tabs name="tabs">
          <:tab label="My Tab" checked>Content</:tab>
        </Tabs.radio_tabs>
        """)

      assert html =~ ~s(aria-label="My Tab")
    end
  end
end
