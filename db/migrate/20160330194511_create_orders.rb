class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :price
      t.string :user

      t.timestamps null: false
    end
  end
end
