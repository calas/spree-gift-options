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
    Checkout.state_machines[:state] = StateMachine::Machine.new(Checkout, :initial => 'address') do
      after_transition :to => 'complete', :do => :complete_order
      event :next do
        transition :from => 'address', :to => 'delivery'
        transition :from => 'delivery', :to => 'giftopts'
        transition :from => 'giftopts', :to => 'payment'
        transition :from => 'payment', :to => 'complete'
      end
    end

    Order.class_eval do
      has_one :gift_message
      accepts_nested_attributes_for :gift_message
    end

    Checkout.class_eval do
      validation_group :giftopts, :fields => []

      has_one :gift_message, :through => :order
      accepts_nested_attributes_for :gift_message

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

    CheckoutsController.class_eval do
      class_scoping_reader :giftopts, Spree::Checkout::ActionOptions.new
      giftopts.edit_hook :load_gift_options
      giftopts.update_hook :set_gift_options

      private

      def load_gift_options
        @gift_options = GiftOption.find(:all, :include => :gift_choices)
        @checkout.gift_message ||= GiftMessage.new(:order => @order)
      end

      def set_gift_options
        logger.debug "setting"
      end
    end

    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
  end
end
