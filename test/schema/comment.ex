defmodule Schema.Comment do
  @moduledoc ~S"""
  The dummy test model that is not stored in the database.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: Ecto.Schema.t()

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields ~w|body|a
  @required_fields ~w|body|a

  embedded_schema do
    field(:body, :string)
  end

  def changeset(data) when is_map(data) do
    %__MODULE__{}
    |> cast(data, @fields)
    |> validate_required(@required_fields)
    |> apply_changes()
  end
end
