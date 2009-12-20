class CreateGiftOptionsTables < ActiveRecord::Migration
  def self.up
    create_table :gift_options do |t|
      t.string :name
      t.text   :description

      t.timestamps
    end

    create_table :gift_choices do |t|
      t.integer  :gift_option_id
      t.string   :name
      t.text     :description
      t.decimal  :amount, :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.string   :image_file_name
      t.string   :image_content_type
      t.integer  :image_file_size
      t.datetime :image_updated_at

      t.timestamps
    end

    create_table :gift_messages do |t|
      t.integer :order_id
      t.string  :from
      t.string  :to
      t.string  :body

      t.timestamps
    end

    create_table :line_item_gift_choices do |t|
      t.integer :line_item_id
      t.integer :gift_choice_id

      t.timestamps
    end

  end

  def self.down
    drop_table :gift_messages
    drop_table :gift_choices
    drop_table :gift_options
  end
end
