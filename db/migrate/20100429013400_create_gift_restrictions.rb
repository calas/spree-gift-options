class CreateGiftRestrictions < ActiveRecord::Migration
  def self.up            
    create_table :gift_restrictions do |t|
      t.references :gift_option
      t.references :product
      t.references :product_group      
    end
  end

  def self.down
  end
end