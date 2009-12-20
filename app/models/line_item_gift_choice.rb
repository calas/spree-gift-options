class LineItemGiftChoice < ActiveRecord::Base
  belongs_to :line_item
  belongs_to :gift_choice

  has_one :gift_charge, :as => :adjustment_source

  validates_presence_of :line_item_id
  validates_presence_of :gift_choice_id

  after_save :create_gift_charge

  def create_gift_charge
    if line_item && gift_choice
      self.gift_charge ||= GiftCharge.create({
          :order => line_item.order,
          :description => "#{I18n.t(:gift_option)} (#{line_item.quantity} x #{gift_choice.name})",
          :adjustment_source => self,
        })
    end
  end
end
