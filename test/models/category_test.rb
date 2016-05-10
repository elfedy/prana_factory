require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: "Ejemplo", description: "Descripción de ejemplo.")
  end

  test "should be valid" do
    assert @category.valid?
  end

  test "name should be present" do
    @category.name = "   "
    assert_not @category.valid?
  end

  test "description should be present" do
    @category.description = "   "
    assert_not @category.valid?
  end

  test "name should be unique" do
    category_copy = @category.dup
    @category.save
    assert_not category_copy.valid?
  end

  test "should accept valid names" do
    valid_names = ["Ejemplo", "Rúcula", "Cáscara de Banana"]
    valid_names.each do |valid_name|
      @category.name = valid_name
      assert @category.valid?, "#{valid_name.inspect} should be valid"
    end
  end

  test "should not accept invalid names" do
    valid_names = ["ejemplo", "$$$", "xjdsl Cads"]
    valid_names.each do |invalid_name|
      @category.name = invalid_name
      assert_not @category.valid?, "#{invalid_name.inspect} should not be valid"
    end
  end

end
