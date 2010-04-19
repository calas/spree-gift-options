# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class GiftOptionsExtension < Spree::Extension
  version "1.0"
  description "Adds gift options to the checkout process"
  url "http://github.com/calas/spree-gift-options"

  # Please use gift_options/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end

  def activate

    Order.class_eval do
      has_one :gift_message
      
      def possible_gift_options
        products = line_items.map{|li| li.variant.product}
        GiftOption.find(:all, :include => :gift_choices).select do |gift_option|
          products.all?{|p| gift_option.valid_for_product?(p)}
        end
      end
    end

    Checkout.class_eval do
      validation_group :giftopts, :fields => ["gift_message.body"]

      has_one :gift_message, :through => :order, :source => :gift_message
      accepts_nested_attributes_for :gift_message

      def gift_message
        order.gift_message || GiftMessage.new(:order => order)
      end

      def gift_message_attributes=(attrs)
        message = gift_message
        message.update_attributes(attrs)
        message.save
      end

      # def gift_message=(params)
      #   message = gift_message
      #   message.update_attributes(params)
      # end

      def gift_options=(options)
        order.line_items.each do |line_item|
          if options[:line_items] && options[:line_items][line_item.id.to_s]
            line_item.line_item_gift_choices.destroy_all
            choice = options[:line_items][line_item.id.to_s][:choice_id]
            line_item.line_item_gift_choices.create(:gift_choice_id => choice) unless choice.eql?("-1")
          end
        end
      end
    end

    LineItem.class_eval do
      has_many :line_item_gift_choices, :dependent => :destroy
      has_many :gift_choices, :through => :line_item_gift_choices
      has_many :gift_charges, :through => :line_item_gift_choices
    end

    # Force the GiftCharge class to load now (helps fix an STI issue with associations in development mode)
    ::GiftCharge
    
  end
end
