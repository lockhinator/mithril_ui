defmodule MithrilUI.Helpers do
  @moduledoc """
  Utility functions for Mithril UI components.

  Includes error translation, class handling, and other shared utilities.
  """

  @doc """
  Translates form field errors using the configured translator.

  By default, uses simple string interpolation. Applications can configure
  a custom translator function:

      config :mithril_ui,
        error_translator: {MyAppWeb.CoreComponents, :translate_error}

  ## Examples

      iex> MithrilUI.Helpers.translate_error({"is required", []})
      "is required"

      iex> MithrilUI.Helpers.translate_error({"must be at least %{count} characters", [count: 8]})
      "must be at least 8 characters"
  """
  @spec translate_error({String.t(), keyword()}) :: String.t()
  def translate_error(error) do
    case Application.get_env(:mithril_ui, :error_translator) do
      {module, function} -> apply(module, function, [error])
      nil -> default_translate_error(error)
    end
  end

  defp default_translate_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", fn _ -> to_string(value) end)
    end)
  end

  @doc """
  Merges CSS classes, filtering out nil and empty values.

  ## Examples

      iex> MithrilUI.Helpers.class_names(["btn", "btn-primary", nil, ""])
      "btn btn-primary"

      iex> MithrilUI.Helpers.class_names(["btn", {"btn-primary", true}, {"btn-disabled", false}])
      "btn btn-primary"
  """
  @spec class_names(list()) :: String.t()
  def class_names(classes) when is_list(classes) do
    classes
    |> Enum.flat_map(&normalize_class/1)
    |> Enum.filter(&(&1 != nil and &1 != ""))
    |> Enum.join(" ")
  end

  defp normalize_class(nil), do: []
  defp normalize_class(""), do: []
  defp normalize_class(class) when is_binary(class), do: [class]
  defp normalize_class({class, true}) when is_binary(class), do: [class]
  defp normalize_class({_class, false}), do: []
  defp normalize_class(classes) when is_list(classes), do: Enum.flat_map(classes, &normalize_class/1)

  @doc """
  Generates a unique ID for DOM elements.

  ## Examples

      iex> MithrilUI.Helpers.unique_id("modal")
      "modal-abc123def"
  """
  @spec unique_id(String.t()) :: String.t()
  def unique_id(prefix \\ "mithril") do
    suffix =
      :crypto.strong_rand_bytes(6)
      |> Base.encode16(case: :lower)

    "#{prefix}-#{suffix}"
  end

  @doc """
  Extracts the errors list from a form field.

  Returns an empty list if the field has no errors or if the form
  has not been validated yet.

  ## Examples

      iex> MithrilUI.Helpers.field_errors(%Phoenix.HTML.FormField{errors: [{"is required", []}]})
      ["is required"]
  """
  @spec field_errors(Phoenix.HTML.FormField.t() | nil) :: [String.t()]
  def field_errors(nil), do: []

  def field_errors(%Phoenix.HTML.FormField{errors: errors}) when is_list(errors) do
    Enum.map(errors, &translate_error/1)
  end

  def field_errors(_), do: []

  @doc """
  Checks if a form field has any errors.

  ## Examples

      iex> MithrilUI.Helpers.has_errors?(%Phoenix.HTML.FormField{errors: [{"is required", []}]})
      true

      iex> MithrilUI.Helpers.has_errors?(%Phoenix.HTML.FormField{errors: []})
      false
  """
  @spec has_errors?(Phoenix.HTML.FormField.t() | nil) :: boolean()
  def has_errors?(nil), do: false
  def has_errors?(%Phoenix.HTML.FormField{errors: errors}), do: errors != []
  def has_errors?(_), do: false
end
