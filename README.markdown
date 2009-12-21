= Gift Options

Provides spree with a set of options for gifts that are attached to checkout process.

h2. Theme Information

To add the gift option view stuff you need to do as follows

In `products/show.html.erb` add

    <%= hook :gift_options_available %>

In `products/_line_item.html.erb` add

    <%= hook :gift_options_available %>

h2. Checkout Considerations

You'll also need to incorporate the gift option step into your checkout process.  A good way to do this would be to add a "Gift Options" step to your checkout process.  In your site extension you could do the following:

    Checkout.state_machines[:state] = StateMachine::Machine.new(Checkout, :initial => 'address') do
      after_transition :to => 'complete', :do => :complete_order
      event :next do
        transition :from => 'address', :to => 'delivery'
        transition :from => 'delivery', :to => 'giftopts'
        transition :from => 'giftopts', :to => 'payment'
        transition :from => 'payment', :to => 'complete'
      end
    end

