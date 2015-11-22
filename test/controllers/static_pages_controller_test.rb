require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get inicio" do
    get :inicio
    assert_response :success
  end

  test "should get nuestros_productos" do
    get :nuestros_productos
    assert_response :success
  end

  test "should get comprar" do
    get :comprar
    assert_response :success
  end

  test "should get contacto" do
    get :contacto
    assert_response :success
  end

end
