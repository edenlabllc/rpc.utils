defmodule Schema.Post do
  use Ecto.Schema

  embedded_schema do
    field(:title, :string)
    field(:body, :string)
    has_many(:comments, Schema.Comment)
  end
end
