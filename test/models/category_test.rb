require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: "Ejemplo", description: "Descripción de ejemplo.")
  end

  test "accepts valid names" do
    valid_names = ["Ejemplo", "Rúcula", "Cáscara de Banana"]
    valid_names.each do |valid_name|
      @category.name = valid_name
      assert @category.valid?, "#{valid_name.inspect} should be valid"
    end
  end

  test "rejects invalid names" do
    valid_names = ["ejemplo", "$$$", "xjdsl Cads", "  "]
    valid_names.each do |invalid_name|
      @category.name = invalid_name
      assert_not @category.valid?, "#{invalid_name.inspect} should not be valid"
    end
  end

  test "accepts valid descriptions" do
    valid_descriptions = ["Ejemplo", "Rúcula", "Cáscara de Banana"]
    valid_descriptions.each do |valid_description|
      @category.description = valid_description
      assert @category.valid?, "#{valid_description.inspect} should be valid"
    end
  end

  test "rejects invalid descriptions" do
    valid_descriptions = ["ejemplo", "$$$", "xjdsl Cads", "   "]
    valid_descriptions.each do |invalid_description|
      @category.description = invalid_description
      assert_not @category.valid?, "#{invalid_description.inspect} should not be valid"
    end
  end
end
