class Admin::GiftOptionsController < Admin::BaseController
  include GiftOptions::SubMenu
  resource_controller

  create.wants.html { redirect_to edit_object_url }
  update.wants.html { redirect_to edit_object_url }
end
