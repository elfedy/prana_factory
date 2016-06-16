require 'test_helper'

class PackagesControllerTest < ActionController::TestCase
  def setup
    @package = packages(:valid_package)
    @category = categories(:valid_category)
    @admin = admins(:valid_admin)
    admin_login(@admin)
  end

  test "should get new" do
    get :new, category_id: @category.id
    assert_response :success
  end

  test "should create package and sku for each product when new package is valid" do
    valid_new_package_attributes = { unit: "new", quantity: "1", premium_price: 200, normal_price: 100 }
    assert_difference('Package.count', 1,"should create package") do
      assert_difference('Sku.count', @category.products.count, "should create one sku per category product") do
        post :create, category_id: @category.id, package: valid_new_package_attributes
      end
    end

    assert_redirected_to categories_path, "should redirect to categories path"
  end

  test "should not create packages nor skus when new product is invalid" do
    assert_no_difference('Package.count', "should not create invalid package") do
      assert_no_difference('Sku.count', "should not create skus for invalid package") do
        post :create, category_id: @category.id, package: { unit: "   " }
      end
    end

    assert_template "new"
  end

  test "should get edit" do
    get :edit, category_id: @category.id, id: @package.id
    assert_response :success
  end

  test "should update package and skus when package is valid" do
    valid_updated_package_attributes = { unit: "new", quantity: "2", premium_price: rand(1000), normal_price: rand(1000) }
    patch :update, category_id: @category.id, id: @package.id, package: valid_updated_package_attributes

    updated_package = Package.find(@package.id)

    updated_package.skus.each do |sku|
      if sku.product.premium
        assert sku.price == updated_package.premium_price, "should update with correct sku price"
      else
        assert sku.price == updated_package.normal_price, "should update with correct sku price"
      end
    end

    assert_redirected_to categories_path, "should redirect to categories path"
  end

  test "should not update package nor skus when package is invalid" do
    invalid_updated_package_attributes = { unit: "     ", premium_price: 1000, normal_price: 1000 }

    patch :update, category_id: @category.id, id: @package.id, package: invalid_updated_package_attributes
    updated_package = Package.find(@package.id)

    assert_not updated_package.normal_price == invalid_updated_package_attributes[:normal_price], "should not update invalid package"

    updated_package.skus.each do |sku|
      assert_not sku.price == 1000, "should not update sku when package is invalid"
    end

    assert_template "edit"
  end

  test "should destroy package" do
    assert_difference('Package.count', -1, "should destroy product") do
      delete :destroy, id: @package.id
    end

    assert_redirected_to categories_path, "should redirect to categories path"
  end

end
