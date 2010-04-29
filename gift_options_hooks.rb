class GiftOptionsHooks < Spree::ThemeSupport::HookListener
  # The following methods are available
  #
  # * insert_before
  # * insert_after
  # * replace
  # * remove
  #
  # All accept a block name symbol followed either by arguments that would be valid for 'render'
  # or a block which returns the string to be inserted. The block will have access to any methods
  # or instance variables accessible in your views
  #
  # Examples
  #
  #   insert_before :homepage_products, :text => "<h1>Welcome!</h1>"
  #   insert_after :homepage_products, 'shared/offers' # renders a partial
  #   replace :taxon_sidebar_navigation, 'shared/my_sidebar'
  #

  insert_after :admin_tabs do
    "<%= tab(:gift_options, :gift_options_settings) %>"
  end

  replace :gift_options_available, 'shared/gift_option_available'
  insert_after :admin_configurations_menu, "admin/gift_restrictions/admin_link"
end
