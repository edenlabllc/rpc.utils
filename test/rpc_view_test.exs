defmodule RpcViewTest do
  use ExUnit.Case
  doctest RpcView

  alias Schemas.{Comment, Post}

  describe "render/1" do
    test "returns map without __metadata__ key" do
      comment = struct!(Comment, %{body: "test_body", inserted_at: ~U[2021-01-01 00:00:00Z]})

      assert %{body: "test_body", id: nil, inserted_at: ~U[2021-01-01 00:00:00Z]} =
               RpcView.render(comment)
    end

    test "returns map without __metadata__ key and NotLoaded associations" do
      post = struct!(Post, %{title: "test_title", body: "test_body", posted_at: ~D[2020-01-01]})

      assert %{title: "test_title", body: "test_body", id: nil, posted_at: ~D[2020-01-01]} =
               RpcView.render(post)
    end

    test "returns map with preloaded relation" do
      comment = struct!(Comment, %{body: "test_comment", inserted_at: ~U[2021-01-01 00:00:00Z]})

      post =
        struct!(Post, %{
          title: "test_title",
          body: "test_body",
          posted_at: ~D[2020-01-01],
          comments: [comment]
        })

      assert %{
               title: "test_title",
               body: "test_body",
               posted_at: ~D[2020-01-01],
               id: nil,
               comments: [%{body: "test_comment", id: nil, inserted_at: ~U[2021-01-01 00:00:00Z]}]
             } = RpcView.render(post)
    end
  end
end
