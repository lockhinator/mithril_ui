defmodule Storybook.Components.Extended.Footer do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.Footer.footer/1

  def description do
    """
    Footer component for page footers with navigation links,
    branding, social icons, and copyright information.
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Basic footer",
        slots: [
          """
          <MithrilUI.Components.Footer.footer_nav title="Services">
            <a class="link link-hover">Branding</a>
            <a class="link link-hover">Design</a>
            <a class="link link-hover">Marketing</a>
          </MithrilUI.Components.Footer.footer_nav>
          <MithrilUI.Components.Footer.footer_nav title="Company">
            <a class="link link-hover">About us</a>
            <a class="link link-hover">Contact</a>
            <a class="link link-hover">Jobs</a>
          </MithrilUI.Components.Footer.footer_nav>
          """
        ]
      },
      %Variation{
        id: :centered,
        description: "Centered footer",
        attributes: %{center: true},
        slots: [
          """
          <p>Copyright © 2024 - All rights reserved</p>
          """
        ]
      },
      %Variation{
        id: :with_aside,
        description: "Footer with branding",
        slots: [
          """
          <MithrilUI.Components.Footer.footer_aside>
            <:logo>
              <span class="text-xl font-bold">ACME</span>
            </:logo>
            <p>ACME Industries Ltd.<br/>Providing reliable tech since 1992</p>
          </MithrilUI.Components.Footer.footer_aside>
          """
        ]
      },
      %Variation{
        id: :dark,
        description: "Dark footer",
        attributes: %{bg: "bg-neutral", text: "text-neutral-content"},
        slots: [
          """
          <MithrilUI.Components.Footer.footer_nav title="Services">
            <a class="link link-hover">Branding</a>
            <a class="link link-hover">Design</a>
          </MithrilUI.Components.Footer.footer_nav>
          """
        ]
      }
    ]
  end
end
