# Put your extension routes here.

map.namespace :admin do |admin|
  admin.resources :gift_options do |gift_option|
    gift_option.resources :gift_choices
  end
  admin.resource :gift_options_settings
end
