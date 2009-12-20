module GiftOptions::SubMenu
  def self.included(base)
    base.class_eval do
      before_filter :gift_options_submenu
    end
  end

  def gift_options_submenu
    render_to_string :partial => 'admin/gift_options/sub_menu'
  end
end
