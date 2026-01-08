defmodule Storybook.Components.Forms.FileInput do
  use PhoenixStorybook.Story, :component

  def function, do: &MithrilUI.Components.FileInput.file_input/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default file input",
        attributes: %{
          name: "file"
        }
      },
      %Variation{
        id: :with_label,
        description: "File input with label",
        attributes: %{
          name: "avatar",
          label: "Profile Picture"
        }
      },
      %Variation{
        id: :required,
        description: "Required file input",
        attributes: %{
          name: "document",
          label: "Upload Document",
          required: true
        }
      },
      %Variation{
        id: :with_help_text,
        description: "File input with help text",
        attributes: %{
          name: "image",
          label: "Image",
          help_text: "Max 5MB, JPG or PNG format"
        }
      },
      %Variation{
        id: :with_accept,
        description: "File input with accept filter",
        attributes: %{
          name: "photo",
          label: "Photo",
          accept: "image/*",
          help_text: "Only image files allowed"
        }
      },
      %Variation{
        id: :multiple,
        description: "Multiple file selection",
        attributes: %{
          name: "photos",
          label: "Photos",
          multiple: true,
          help_text: "Select multiple files"
        }
      },
      %Variation{
        id: :disabled,
        description: "Disabled file input",
        attributes: %{
          name: "disabled_file",
          label: "Disabled",
          disabled: true
        }
      },
      %Variation{
        id: :with_error,
        description: "File input with error",
        attributes: %{
          name: "error_file",
          label: "Upload",
          errors: ["File is too large"]
        }
      }
    ]
  end
end
