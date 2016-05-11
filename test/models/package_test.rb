require 'test_helper'

class PackageTest < ActiveSupport::TestCase
  def setup
    @package = categories(:valid_category).packages.build(unit: "u", quantity: "2", normal_price: "50",
                                                          premium_price: "70")
    @another_package = categories(:another_valid_category).packages.build(unit: "u", quantity: "2",
                                                                          normal_price: "50", premium_price: "70")
  end

  test "is invalid if same quantity and unit are already taken within the category" do
    @package.unit = packages(:valid_package).unit
    @package.quantity = packages(:valid_package).quantity
    assert_not @package.valid?
  end

  test "is valid when same quantity and unit are taken only within another the category" do
    @another_package.unit = packages(:valid_package).unit
    @another_package.quantity = packages(:valid_package).quantity
    assert @another_package.valid?
  end
end
