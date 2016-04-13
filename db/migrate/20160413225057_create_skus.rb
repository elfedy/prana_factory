class CreateSkus < ActiveRecord::Migration
  def change
    create_table :skus do |t|
      t.integer :category_id
      t.integer :product_id
      t.integer :package_id
      t.integer :price

      t.timestamps null: false
    end
  end
end
