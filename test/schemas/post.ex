defmodule Schemas.Post do
  use Ecto.Schema

  embedded_schema do
    field(:title, :string)
    field(:body, :string)
    has_many(:comments, Schemas.Comment)
  end
end
