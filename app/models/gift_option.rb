class GiftOption < ActiveRecord::Base
  has_many :gift_choices

  validates_presence_of :name

end
