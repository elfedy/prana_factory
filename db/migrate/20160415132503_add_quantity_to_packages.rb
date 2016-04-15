class AddQuantityToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :quantity, :integer
    add_column :packages, :unit, :string
    remove_column :packages, :units, :string
  end
end
