defmodule MithrilUI.Components.RatingTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Rating

  describe "rating/1" do
    test "renders basic rating" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Rating.rating name="test-rating" />
        """)

      assert html =~ "rating"
      assert html =~ ~s(name="test-rating")
    end

    test "renders rating with specified value" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Rating.rating name="test" value={3.0} />
        """)

      assert html =~ ~s(checked)
    end

    test "renders rating with custom max" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Rating.rating name="test" max={10} />
        """)

      # Should have 10 star inputs
      assert String.split(html, "mask-star") |> length() > 10
    end

    test "applies size class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Rating.rating name="test" size="lg" />
        """)

      assert html =~ "rating-lg"
    end

    test "applies half star mode" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Rating.rating name="test" half />
        """)

      assert html =~ "rating-half"
      assert html =~ "mask-half-1"
      assert html =~ "mask-half-2"
    end

    test "applies custom color" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Rating.rating name="test" color="bg-orange-400" />
        """)

      assert html =~ "bg-orange-400"
    end

    test "uses star-2 shape" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Rating.rating name="test" shape="star-2" />
        """)

      assert html =~ "mask-star-2"
    end

    test "uses heart shape" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Rating.rating name="test" shape="heart" />
        """)

      assert html =~ "mask-heart"
    end
  end

  describe "rating_display/1" do
    test "renders read-only rating display" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Rating.rating_display value={4.0} />
        """)

      assert html =~ "rating"
      assert html =~ ~s(aria-label="Rating: 4.0 out of 5")
    end

    test "applies custom colors" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Rating.rating_display value={3.0} color="bg-red-500" empty_color="bg-gray-200" />
        """)

      assert html =~ "bg-red-500"
      assert html =~ "bg-gray-200"
    end

    test "applies size class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Rating.rating_display value={5.0} size="xl" />
        """)

      assert html =~ "rating-xl"
    end
  end

  describe "rating_with_text/1" do
    test "renders rating with numeric value" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Rating.rating_with_text value={4.5} />
        """)

      assert html =~ "4.5"
    end

    test "renders rating with out of max format" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Rating.rating_with_text value={4.0} max={5} show_max />
        """)

      assert html =~ "4"
      assert html =~ "out of"
      assert html =~ "5"
    end
  end

  describe "rating_breakdown/1" do
    test "renders rating breakdown with progress bars" do
      assigns = %{ratings: %{5 => 70, 4 => 20, 3 => 5, 2 => 3, 1 => 2}}

      html =
        rendered_to_string(~H"""
        <Rating.rating_breakdown ratings={@ratings} />
        """)

      assert html =~ "5 star"
      assert html =~ "1 star"
      assert html =~ "70"
    end

    test "handles empty ratings" do
      assigns = %{ratings: %{5 => 0, 4 => 0, 3 => 0, 2 => 0, 1 => 0}}

      html =
        rendered_to_string(~H"""
        <Rating.rating_breakdown ratings={@ratings} />
        """)

      assert html =~ "5 star"
    end
  end
end
