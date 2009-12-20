class GiftChoice < ActiveRecord::Base
  belongs_to :gift_option

  validates_presence_of :name
  validates_presence_of :amount
  validates_numericality_of :amount


  has_attached_file :image, :styles => { :preview => "80x80>" }, :default_style => :preview,
                    :url => "/assets/gift_choices/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/gift_choices/:id/:style/:basename.:extension"
end
