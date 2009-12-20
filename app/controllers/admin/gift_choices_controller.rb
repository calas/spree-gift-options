class Admin::GiftChoicesController < Admin::BaseController
  include GiftOptions::SubMenu
  resource_controller
  belongs_to :gift_option

  create.wants.html { redirect_to collection_url }
  update.wants.html { redirect_to collection_url }
end
