require 'test_helper'

class ItemStarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item_star = item_stars(:one)
  end

  test "should get index" do
    get item_stars_url, as: :json
    assert_response :success
  end

  test "should create item_star" do
    assert_difference('ItemStar.count') do
      post item_stars_url, params: { item_star: { created_by_id: @item_star.created_by_id, item_id: @item_star.item_id } }, as: :json
    end

    assert_response 201
  end

  test "should show item_star" do
    get item_star_url(@item_star), as: :json
    assert_response :success
  end

  test "should update item_star" do
    patch item_star_url(@item_star), params: { item_star: { created_by_id: @item_star.created_by_id, item_id: @item_star.item_id } }, as: :json
    assert_response 200
  end

  test "should destroy item_star" do
    assert_difference('ItemStar.count', -1) do
      delete item_star_url(@item_star), as: :json
    end

    assert_response 204
  end
end
