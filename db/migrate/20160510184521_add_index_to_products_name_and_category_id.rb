class AddIndexToProductsNameAndCategoryId < ActiveRecord::Migration
  def change
    add_index :products, [:category_id, :name], unique: true
  end
end
