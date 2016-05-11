require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = Product.new(name: "Producto")
  end

  test "is valid" do
    assert @product.valid?
  end

  test "is invalid without a name" do
    @product.name = "   "
    assert_not @product.valid?
  end

  test "is invalid if same name is already taken within the category" do
    same_name_product = categories(:valid_category).products.build(name: products(:valid_product).name)
    assert_not same_name_product.valid?
  end

  test "is valid when using the same name in different categories" do
    same_name_product = categories(:another_valid_category).products.build(name: products(:valid_product).name)
    assert same_name_product.valid?
  end

  test "is valid when name starts with a capital letter" do
    valid_names = ["Ejemplo", "Rúcula", "Cáscara de Banana"]
    valid_names.each do |valid_name|
      @product.name = valid_name
      assert @product.valid?, "#{valid_name.inspect} should be valid"
    end
  end

  test "is invalid if name does not start with a capital letter" do
    valid_names = ["ejemplo", "$$$", "xjdsl Cads"]
    valid_names.each do |invalid_name|
      @product.name = invalid_name
      assert_not @product.valid?, "#{invalid_name.inspect} should not be valid"
    end
  end
end
