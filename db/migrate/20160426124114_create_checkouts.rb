class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|
      t.string :name
      t.string :email
      t.string :telephone
      t.string :address
      t.date :delivery_date
      t.string :delivery_time

      t.timestamps null: false
    end
  end
end
