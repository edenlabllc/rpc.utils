defmodule Schemas.Comment do
  @moduledoc """
  Comment schema for testing.
  """
  use Ecto.Schema

  embedded_schema do
    field(:body, :string)
    field(:post_id, :integer)
    field(:inserted_at, :utc_datetime)
  end
end
