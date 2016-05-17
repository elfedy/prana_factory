require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  def setup
    @normal_product = products(:valid_normal_product)
    @category = categories(:valid_category)
  end

  test "should get new" do
    get :new, category_id: @category.id
    assert_response :success
  end

  test "should create product and sku for each package when new product is valid" do
    assert_difference('Product.count', 1,"should create product") do
      assert_difference('Sku.count', @category.packages.count, "should create one sku per category package") do
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
    get :edit, category_id: @category.id, id: @normal_product.id
    assert_response :success
  end

  test "should update product and skus when product is valid" do
    patch :update, category_id: @category.id, id: @normal_product.id,
          product: { name: "Updated Product", premium: true }

    updated_product = Product.find(@normal_product.id)

    assert updated_product.name == "Updated Product", "should update product name"

    updated_product.skus.each do |sku|
        assert sku.price == sku.package.premium_price
    end

    assert_redirected_to categories_path, "should redirect to categories path"
  end

  test "should not update product nor skus when product is invalid" do
    patch :update, category_id: @category.id, id: @normal_product.id, product: { name: "     ", premium: true }
    updated_product = Product.find(@normal_product.id)

    assert_not updated_product.name == "     ", "should not update product name"

    updated_product.skus.each do |sku|
        assert_not sku.price == sku.package.premium_price
    end

    assert_template "edit"
  end

  test "should destroy product" do
    assert_difference('Product.count', -1, "should destroy product") do
      delete :destroy, id: @normal_product.id
    end

    assert_redirected_to categories_path, "should redirect to categories path"
  end

end
