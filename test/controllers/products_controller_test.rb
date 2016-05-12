require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  def setup
    @product = products(:valid_product)
    @category = categories(:valid_category)
  end

  test "should get new" do
    get :new, category_id: @category.id
    assert_response :success
  end

  test "should create product and skus when new product is valid" do
    assert_difference('Product.count', 1,"should create product") do
      assert_difference('Sku.count', @category.packages.count, "should create one sku per package") do
        post :create, category_id: @category.id, product: { name: "New Product" }
      end
    end

    assert_redirected_to categories_path, "should redirect to categories path"
  end

  test "should not create product nor skus when new product is invalid" do
    assert_no_difference('Product.count', "should not create invalid product") do
      assert_no_difference('Sku.count', "should  not create skus for invalid product") do
        post :create, category_id: @category.id, product: { name: "   " }
      end
    end

    assert_template "new" 
  end

  test "should get edit" do
    get :edit, category_id: @category.id, id: @product.id
    assert_response :success
  end

  test "should update product" do
    patch :update, category_id: @category.id, id: @product.id, product: { name: "Updated Product"}
    assert_redirected_to categories_path, "should redirect to categories path"
    assert Product.find(@product.id).name == "Updated Product", "should update product name"
  end

  test "should destroy product" do
    assert_difference('Product.count', -1, "should destroy product") do
      delete :destroy, id: @product.id
    end

    assert_redirected_to categories_path, "should redirect to categories path"
  end

end
