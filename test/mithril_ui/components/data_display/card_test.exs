defmodule MithrilUI.Components.CardTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest
  import Phoenix.Component

  alias MithrilUI.Components.Card

  describe "card/1 rendering" do
    test "renders basic card" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Card.card>
          <:body>Card content</:body>
        </Card.card>
        """)

      assert html =~ "card"
      assert html =~ "card-body"
      assert html =~ "Card content"
    end

    test "renders with shadow" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Card.card>
          <:body>Content</:body>
        </Card.card>
        """)

      assert html =~ "shadow-xl"
    end
  end

  describe "card slots" do
    test "renders figure slot" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Card.card>
          <:figure>
            <img src="/test.jpg" alt="Test" />
          </:figure>
          <:body>Content</:body>
        </Card.card>
        """)

      assert html =~ "<figure"
      assert html =~ ~s(src="/test.jpg")
    end

    test "renders title slot" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Card.card>
          <:title>Card Title</:title>
          <:body>Content</:body>
        </Card.card>
        """)

      assert html =~ "card-title"
      assert html =~ "Card Title"
    end

    test "renders actions slot" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Card.card>
          <:body>Content</:body>
          <:actions>
            <button>Action</button>
          </:actions>
        </Card.card>
        """)

      assert html =~ "card-actions"
      assert html =~ "Action"
    end
  end

  describe "card variants" do
    test "renders bordered card" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Card.card bordered>
          <:body>Content</:body>
        </Card.card>
        """)

      assert html =~ "card-bordered"
    end

    test "renders compact card" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Card.card compact>
          <:body>Content</:body>
        </Card.card>
        """)

      assert html =~ "card-compact"
    end

    test "renders image-full card" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Card.card image_full>
          <:body>Content</:body>
        </Card.card>
        """)

      assert html =~ "image-full"
    end

    test "renders horizontal card" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Card.card horizontal>
          <:body>Content</:body>
        </Card.card>
        """)

      assert html =~ "card-side"
    end

    test "renders glass card" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Card.card glass>
          <:body>Content</:body>
        </Card.card>
        """)

      assert html =~ "glass"
    end
  end

  describe "simple_card/1" do
    test "renders simple card with title" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Card.simple_card title="My Card" />
        """)

      assert html =~ "card-title"
      assert html =~ "My Card"
    end

    test "renders simple card with description" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Card.simple_card title="Title" description="Description text" />
        """)

      assert html =~ "Description text"
    end

    test "renders simple card with image" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Card.simple_card title="Title" image="/image.jpg" image_alt="Alt text" />
        """)

      assert html =~ "<figure"
      assert html =~ ~s(src="/image.jpg")
      assert html =~ ~s(alt="Alt text")
    end

    test "renders simple card with inner_block" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Card.simple_card title="Title">
          Custom content here
        </Card.simple_card>
        """)

      assert html =~ "Custom content here"
    end
  end

  describe "custom classes" do
    test "applies custom class" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <Card.card class="w-96">
          <:body>Content</:body>
        </Card.card>
        """)

      assert html =~ "w-96"
    end
  end
end
