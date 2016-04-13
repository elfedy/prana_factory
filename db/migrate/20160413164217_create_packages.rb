class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.integer :category_id
      t.integer :units

      t.timestamps null: false
    end
  end
end
