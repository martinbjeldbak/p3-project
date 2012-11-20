module ShoppingListHelper
  def formatQuantityAndUnit(item)
    if item.quantity
      if item.quantity == item.quantity.floor
        return "%g" % item.quantity + " " + "#{item.unit}"
      else
        return "%.1f" % item.quantity + " " + "#{item.unit}"
      end
    end
  end
end
