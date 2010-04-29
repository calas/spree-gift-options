class GiftRestriction < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_group         
  belongs_to :gift_option
  validates_presence_of :product, :if => Proc.new { |sr| sr.product_group.nil? }
  validates_presence_of :product_group, :if => Proc.new { |sr| sr.product.nil? }  
  validates_presence_of :gift_option

  def covers?(product)
    product == self.product || product.product_groups.include?(self.product_group)
  end
  
  def product_sku
    self.product.try(:sku)
  end
  
  def product_sku=(sku)
    self.product = sku.blank? ? nil : Variant.sku_equals(sku).first.try(:product) 
  end
  
end