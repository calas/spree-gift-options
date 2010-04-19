class GiftOption < ActiveRecord::Base
  has_many :gift_choices
  belongs_to :product_group
  
  validates_presence_of :name

  def valid_for_product?(product)
    product_group.nil? or product_group.include?(product)
  end
  
  def self.for_product(product)
    all.select{|go| go.valid_for_product?(product)}
  end

end
