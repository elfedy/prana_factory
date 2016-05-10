require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = Product.new(name: "Producto")
  end

  test "should be valid" do
    assert @product.valid?
  end

  test "name should be present" do
    @product.name = "   "
    assert_not @product.valid?
  end

  test "should not accept same name if in same category" do
    same_name_product = categories(:valid_category).products.build(name: products(:valid_product).name)
    assert_not same_name_product.valid?
  end

  test "should accept same name in different category" do
    same_name_product = categories(:another_valid_category).products.build(name: products(:valid_product).name)
    assert same_name_product.valid?
  end

  test "should accept valid names" do
    valid_names = ["Ejemplo", "Rúcula", "Cáscara de Banana"]
    valid_names.each do |valid_name|
      @product.name = valid_name
      assert @product.valid?, "#{valid_name.inspect} should be valid"
    end
  end

  test "should not accept invalid names" do
    valid_names = ["ejemplo", "$$$", "xjdsl Cads"]
    valid_names.each do |invalid_name|
      @product.name = invalid_name
      assert_not @product.valid?, "#{invalid_name.inspect} should not be valid"
    end
  end
end
