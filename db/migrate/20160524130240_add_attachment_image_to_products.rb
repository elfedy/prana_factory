class AddAttachmentImageToProducts < ActiveRecord::Migration
  def change
    remove_column :products, :image_url
  end

  def self.up
    change_table :products do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :products, :image
  end
end
