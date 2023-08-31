defmodule Schema.Post do
  @moduledoc ~S"""
  The dummy test model that is not stored in the database.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: Ecto.Schema.t()

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields ~w|title body|a
  @required_fields ~w|title body|a

  embedded_schema do
    field(:title, :string)
    field(:body, :string)
    has_many(:comments, Schema.Comment, foreign_key: :id)
  end

  def changeset(data) when is_map(data) do
    %__MODULE__{}
    |> cast(data, @fields)
    |> validate_required(@required_fields)
    |> apply_changes()
  end
end
