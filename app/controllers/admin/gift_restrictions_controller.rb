class Admin::GiftRestrictionsController < Admin::BaseController    
  resource_controller
  
  create.success.wants.html { redirect_to collection_url }
  update.success.wants.html { redirect_to collection_url }
  destroy.success.wants.js { render_js_for_destroy }

end