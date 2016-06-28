require 'test_helper'
class LineItemsControllerTest < ActionController::TestCase
  def setup
    @sku = skus(:valid_sku_normal_product)
  end

  test "create line_item" do
    assert_difference('LineItem.count') do
      post :create, sku_id: @sku.id
    end
    assert_redirected_to comprar_path
  end

  test "create line_item via ajax" do
    assert_difference('LineItem.count') do
      xhr :post, :create, sku_id: @sku.id
    end
  end
end
