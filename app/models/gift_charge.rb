class GiftCharge < Charge
  def calculate_adjustment
    adjustment_source && calculate_gift_charge
  end

  def calculate_gift_charge
    return unless adjustment_source.line_item && adjustment_source.gift_choice
    return adjustment_source.line_item.quantity * adjustment_source.gift_choice.amount
  end
end
