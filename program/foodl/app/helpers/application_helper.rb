module ApplicationHelper

  def listCount
    if logged_in?
      #items = current_user.list_items
      items = current_user.list_items.count
      #totalItems = items.inject(0) { |sum, item| sum + item.quantity if item.quantity}

      "(#{items})"
    end
  end
end
