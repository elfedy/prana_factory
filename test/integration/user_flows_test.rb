require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  fixtures :all

  def setup
    @valid_sku_normal = skus(:valid_sku_normal_product)
    @valid_sku_premium = skus(:valid_sku_premium_product)

    @valid_checkout_params = { name: "Federico", email: "fede@example.com", telephone: "45679087",
                               address: "Example 123 6to", delivery_date: define_base_date,
                               delivery_time: "10:00h a 13:00h" }

  end

  test "issue a correct checkout" do
    #Go to comprar and click the link to buy products link
    get comprar_path
    assert_response :success

    @order = Order.find(session[:order_id])

    assert_not @order.nil?
    #Select one product from one sku and two products from another sku
    assert_difference('LineItem.count') do
      assert_difference('@order.reload.total_price', @valid_sku_normal.price) do
        post line_items_path, sku_id: @valid_sku_normal.id
      end
    end

    assert_difference('LineItem.count') do
      assert_difference('@order.reload.total_price', @valid_sku_premium.price) do
         post line_items_path, sku_id: @valid_sku_premium.id
      end
    end

    assert_no_difference('LineItem.count') do
      assert_difference('@order.reload.total_price', @valid_sku_normal.price) do
        post line_items_path, sku_id: @valid_sku_normal.id
      end
    end

    #Click "Realizar Pedido" button and get to the checkout form
    get new_checkout_path
    assert_response :success

    #Enter Valid data and check emails are sent and the checkout saved
    assert_difference('Checkout.count') do
      assert_difference('ActionMailer::Base.deliveries.size', 2) do
        post checkouts_path, checkout: @valid_checkout_params
      end
    end
    assert_redirected_to comprar_path

  end
end

#test "should create checkout with valid data" do
  # Define array in case I want to test another different set of valid data"

#  valid_checkouts.each do |checkout|
#    assert_difference('Checkout.count', 1, "Checkout with user name #{checkout[:name]} should be created") do
#        post :create, checkout: checkout
#    end
#  end
#end
