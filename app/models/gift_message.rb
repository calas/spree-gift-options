class GiftMessage < ActiveRecord::Base
  belongs_to :order

  validates_presence_of :body
end
