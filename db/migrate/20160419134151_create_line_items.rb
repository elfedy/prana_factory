class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :price
      t.integer :quantity, :default => 1
      t.integer :sku_id
      t.integer :order_id

      t.timestamps null: false
    end
  end
end
