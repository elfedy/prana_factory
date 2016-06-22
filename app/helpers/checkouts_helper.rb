module CheckoutsHelper
  def define_base_date
    base_date = Date.today + 1
    while Checkout::VALID_DELIVERY_WDAYS.exclude?(base_date.wday) do
      if base_date.wday == 6
        base_date = 0
      else
        base_date += 1
      end
    end
    return base_date
  end
end
