defmodule Schemas.Comment do
  use Ecto.Schema

  embedded_schema do
    field(:body, :string)
    field(:post_id, :integer)
  end
end
