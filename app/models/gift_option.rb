class GiftOption < ActiveRecord::Base
  has_many :gift_choices
  #belongs_to :product_group
  has_many :gift_restrictions
  
  validates_presence_of :name

  def valid_for_product?(product)
    gift_restrictions.each do |restriction|
      return false if restriction.covers?(product) 
    end
    true
  end
  
end
