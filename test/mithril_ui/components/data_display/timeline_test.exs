defmodule MithrilUI.Components.TimelineTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Timeline

  describe "timeline/1 rendering" do
    test "renders basic timeline" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Timeline.timeline>
          <:item>Event 1</:item>
          <:item>Event 2</:item>
        </Timeline.timeline>
        """)

      assert html =~ "timeline"
      assert html =~ "Event 1"
      assert html =~ "Event 2"
    end

    test "renders as unordered list" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Timeline.timeline>
          <:item>Event</:item>
        </Timeline.timeline>
        """)

      assert html =~ "<ul"
      assert html =~ "<li"
    end
  end

  describe "timeline orientation" do
    test "renders vertical by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Timeline.timeline>
          <:item>Event</:item>
        </Timeline.timeline>
        """)

      assert html =~ "timeline-vertical"
    end

    test "renders horizontal" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Timeline.timeline horizontal>
          <:item>Event</:item>
        </Timeline.timeline>
        """)

      assert html =~ "timeline-horizontal"
    end
  end

  describe "timeline item content" do
    test "renders item with time" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Timeline.timeline>
          <:item time="2024-01-01">Event</:item>
        </Timeline.timeline>
        """)

      assert html =~ "2024-01-01"
    end

    test "renders item with title" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Timeline.timeline>
          <:item title="Big Event">Description</:item>
        </Timeline.timeline>
        """)

      assert html =~ "Big Event"
      assert html =~ "font-bold"
    end
  end

  describe "timeline item status" do
    test "renders done status with success color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Timeline.timeline>
          <:item status="done">Done</:item>
        </Timeline.timeline>
        """)

      assert html =~ "text-success"
    end

    test "renders current status with primary color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Timeline.timeline>
          <:item status="current">Current</:item>
        </Timeline.timeline>
        """)

      assert html =~ "text-primary"
    end

    test "renders done status line with success color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Timeline.timeline>
          <:item status="done">First</:item>
          <:item>Second</:item>
        </Timeline.timeline>
        """)

      assert html =~ "bg-success"
    end
  end

  describe "timeline structure" do
    test "renders timeline-middle section" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Timeline.timeline>
          <:item>Event</:item>
        </Timeline.timeline>
        """)

      assert html =~ "timeline-middle"
    end

    test "renders timeline-box for content" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Timeline.timeline>
          <:item>Event</:item>
        </Timeline.timeline>
        """)

      assert html =~ "timeline-box"
    end

    test "renders hr separators between items" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Timeline.timeline>
          <:item>First</:item>
          <:item>Second</:item>
          <:item>Third</:item>
        </Timeline.timeline>
        """)

      assert html =~ "<hr"
    end
  end

  describe "timeline snap_icon" do
    test "snaps icons by default" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Timeline.timeline>
          <:item>Event</:item>
        </Timeline.timeline>
        """)

      assert html =~ "timeline-snap-icon"
    end

    test "does not snap when disabled" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Timeline.timeline snap_icon={false}>
          <:item>Event</:item>
        </Timeline.timeline>
        """)

      refute html =~ "timeline-snap-icon"
    end
  end

  describe "simple_timeline/1" do
    test "renders simple timeline from events list" do
      assigns = %{
        events: [
          %{time: "9:00 AM", title: "Start"},
          %{time: "10:00 AM", title: "Meeting"}
        ]
      }

      html =
        rendered_to_string(~H"""
        <Timeline.simple_timeline events={@events} />
        """)

      assert html =~ "9:00 AM"
      assert html =~ "10:00 AM"
      assert html =~ "Start"
      assert html =~ "Meeting"
    end

    test "renders event description" do
      assigns = %{
        events: [%{title: "Event", description: "Event description"}]
      }

      html =
        rendered_to_string(~H"""
        <Timeline.simple_timeline events={@events} />
        """)

      assert html =~ "Event description"
    end

    test "renders event status" do
      assigns = %{
        events: [%{title: "Done", status: "done"}]
      }

      html =
        rendered_to_string(~H"""
        <Timeline.simple_timeline events={@events} />
        """)

      assert html =~ "text-success"
    end
  end

  describe "custom classes" do
    test "applies custom class to timeline" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Timeline.timeline class="my-timeline">
          <:item>Event</:item>
        </Timeline.timeline>
        """)

      assert html =~ "my-timeline"
    end
  end
end
