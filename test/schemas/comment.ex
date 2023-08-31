defmodule Schemas.Comment do
  @moduledoc """
  Comment schema for testing.
  """
  use Ecto.Schema

  embedded_schema do
    field(:body, :string)
    field(:post_id, :integer)
  end
end
