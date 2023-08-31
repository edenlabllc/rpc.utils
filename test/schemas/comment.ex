defmodule Schema.Comment do
  use Ecto.Schema

  embedded_schema do
    field(:body, :string)
  end
end
