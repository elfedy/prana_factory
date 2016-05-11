class AddIndexToPackagesCategoryIdUnitQuantity < ActiveRecord::Migration
  def change
    add_index :packages, [:category_id, :unit, :quantity], unique: true
  end
end
