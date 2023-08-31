defmodule RpcViewTest do
  use ExUnit.Case
  doctest RpcView

  alias Schema.{Comment, Post}

  describe "render/1" do
    test "returns map without __metadata__ key" do
      comment = struct!(Comment, %{body: "test_body"})

      assert %{body: "test_body", id: nil} = RpcView.render(comment)
    end

    test "returns map without __metadata__ key and NotLoaded associations" do
      post = struct!(Post, %{title: "test_title", body: "test_body"})

      assert %{title: "test_title", body: "test_body", id: nil} = RpcView.render(post)
    end

    test "returns map with preloaded relation" do
      comment = struct!(Comment, %{body: "test_body"})
      post = struct!(Post, %{title: "test_title", body: "test_body", comments: [comment]})

      assert %{
               title: "test_title",
               body: "test_body",
               id: nil,
               comments: [%{body: "test_comment", id: nil}]
             } = RpcView.render(post)
    end
  end
end
