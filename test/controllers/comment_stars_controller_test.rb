require 'test_helper'

class CommentStarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment_star = comment_stars(:one)
  end

  test "should get index" do
    get comment_stars_url, as: :json
    assert_response :success
  end

  test "should create comment_star" do
    assert_difference('CommentStar.count') do
      post comment_stars_url, params: { comment_star: { comment_id: @comment_star.comment_id, created_by_id: @comment_star.created_by_id } }, as: :json
    end

    assert_response 201
  end

  test "should show comment_star" do
    get comment_star_url(@comment_star), as: :json
    assert_response :success
  end

  test "should update comment_star" do
    patch comment_star_url(@comment_star), params: { comment_star: { comment_id: @comment_star.comment_id, created_by_id: @comment_star.created_by_id } }, as: :json
    assert_response 200
  end

  test "should destroy comment_star" do
    assert_difference('CommentStar.count', -1) do
      delete comment_star_url(@comment_star), as: :json
    end

    assert_response 204
  end
end
