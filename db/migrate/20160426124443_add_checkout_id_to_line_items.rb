class AddCheckoutIdToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :checkout_id, :integer
  end
end
