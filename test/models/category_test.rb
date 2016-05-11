require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: "Ejemplo", description: "Descripción de ejemplo.")
  end

  test "is valid" do
    assert @category.valid?
  end

  test "is invalid without a name" do
    @category.name = "   "
    assert_not @category.valid?
  end

  test "is invalid without a description" do
    @category.description = "   "
    assert_not @category.valid?
  end

  test "is invalid if name is already taken" do
    category_copy = @category.dup
    @category.save
    assert_not category_copy.valid?
  end

  test "is valid if name starts with a capital letter" do
    valid_names = ["Ejemplo", "Rúcula", "Cáscara de Banana"]
    valid_names.each do |valid_name|
      @category.name = valid_name
      assert @category.valid?, "#{valid_name.inspect} should be valid"
    end
  end

  test "is invalid if name does not start with a capital letter" do
    valid_names = ["ejemplo", "$$$", "xjdsl Cads"]
    valid_names.each do |invalid_name|
      @category.name = invalid_name
      assert_not @category.valid?, "#{invalid_name.inspect} should not be valid"
    end
  end

  test "is valid if description starts with a capital letter" do
    valid_descriptions = ["Ejemplo", "Rúcula", "Cáscara de Banana"]
    valid_descriptions.each do |valid_description|
      @category.description = valid_description
      assert @category.valid?, "#{valid_description.inspect} should be valid"
    end
  end

  test "is invalid if description does not start with a capital letter" do
    valid_descriptions = ["ejemplo", "$$$", "xjdsl Cads"]
    valid_descriptions.each do |invalid_description|
      @category.description = invalid_description
      assert_not @category.valid?, "#{invalid_description.inspect} should not be valid"
    end
  end
end
