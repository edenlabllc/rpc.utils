defmodule RpcView do
  @moduledoc """
  Strips out metadata and Ecto not loaded associactions from the struct and returns map.
  """

  @doc """

  ## Examples

      iex> RpcView.strip_meta_info(%{__meta__: "test", id: 1})
      %{id: 1}

      iex> RpcView.strip_meta_info(%{__meta__: "test", id: 1, comments: %Ecto.Association.NotLoaded{}})
      %{id: 1}
  """

  def strip_meta_info(data) when is_map(data) do
    data
    |> Map.drop([:__meta__, :__struct__])
    |> Enum.reduce(%{}, fn {key, value}, acc ->
      unless assoc_not_loaded?(value) do
        Map.put(acc, key, strip_meta_info(value))
      else
        acc
      end
    end)
  end

  def strip_meta_info(data) when is_list(data), do: Enum.map(data, &strip_meta_info/1)

  def strip_meta_info(data), do: data

  defp assoc_not_loaded?(%Ecto.Association.NotLoaded{}), do: true
  defp assoc_not_loaded?(_), do: false
end
