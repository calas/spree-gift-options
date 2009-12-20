class Admin::GiftOptionsSettingsController < Admin::BaseController
  include GiftOptions::SubMenu

  def update
    GiftOptions::Config.set(params[:preferences])

    respond_to do |format|
      format.html {
        redirect_to admin_gift_options_settings_path
      }
    end
  end
end
