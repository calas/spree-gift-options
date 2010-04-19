class ProductGroupIdForGiftOptions < ActiveRecord::Migration
  def self.up
    add_column "gift_options", "product_group_id", :integer
    add_index(:gift_options, :product_group_id)    
  end

  def self.down
    remove_column "gift_options", "product_group_id"
  end
end