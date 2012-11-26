module ShoppingListHelper
  def formatQuantityAndUnit(item)
    if item.quantity
      return format_quantity( item.quantity ) + " " + "#{item.unit}"
    end
  end
end
