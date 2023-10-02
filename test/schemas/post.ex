defmodule Schemas.Post do
  @moduledoc """
  Post schema for testing.
  """
  use Ecto.Schema

  embedded_schema do
    field(:title, :string)
    field(:body, :string)
    field(:posted_at, :date)
    has_many(:comments, Schemas.Comment)
  end
end
