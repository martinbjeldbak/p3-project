module ApplicationHelper

  def listCount
    if logged_in?
      #items = current_user.list_items
      items = current_user.list_items.count
      #totalItems = items.inject(0) { |sum, item| sum + item.quantity if item.quantity}

      "(#{items})"
    end
  end
  
  def num_favorites
    if !current_user
      return 0
    end
    current_user.favorites.size
  end
  
  def toolbar?
    return @toolbar
  end
  
  def show_ad?
    return !@hide_ad
  end
end
