defmodule RpcView do
  @moduledoc """
  Strips out metadata and Ecto not loaded associactions from the struct and returns map.
  """

  @doc """

  ## Examples

      iex> RpcView.render(%{__meta__: "test", id: 1})
      %{id: 1}

      iex> RpcView.render(%{__meta__: "test", id: 1, comments: %Ecto.Association.NotLoaded{}})
      %{id: 1}
  """

  def render(data) when is_map(data) do
    data
    |> Map.drop([:__meta__, :__struct__])
    |> Enum.reduce(%{}, fn {key, value}, acc ->
      case value do
        %Ecto.Association.NotLoaded{} -> acc
        _ -> Map.put(acc, key, render(value))
      end
    end)
  end

  def render(data) when is_list(data), do: Enum.map(data, &render/1)
  def render(data), do: data
end
