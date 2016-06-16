require 'test_helper'

class AdminsControllerTest < ActionController::TestCase
  def setup
    @admin = admins(:valid_admin)
    admin_login(@admin)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get actions" do
    get :actions
    assert_response :success
  end

end
