defmodule RpcViewTest do
  use ExUnit.Case
  doctest RpcView

  describe "strip_meta_info/1" do
    test "returns map without __metadata__ key" do
      post = Schema.Comment.changeset(%{body: "test_body"})

      assert RpcView.strip_meta_info(post) == %{body: "test_body", id: nil}
    end

    test "returns map without __metadata__ key and NotLoaded associations" do
      post = Schema.Post.changeset(%{title: "test_title", body: "test_body"})

      assert RpcView.strip_meta_info(post) == %{title: "test_title", body: "test_body", id: nil}
    end

    test "returns map without __metadata__ key and NotLoaded associations. Additionaly apply this fuction for internal maps and structs" do
      post = Schema.Post.changeset(%{title: "test_title", body: "test_body"})

      comment = Ecto.build_assoc(post, :comments, %{body: "test_comment"})
      post_map = post |> Map.from_struct() |> Map.put(:comments, [comment])

      assert RpcView.strip_meta_info(post_map) == %{
               title: "test_title",
               body: "test_body",
               id: nil,
               comments: [%{body: "test_comment", id: nil}]
             }
    end
  end
end