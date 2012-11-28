module ApplicationHelper

  def listCount
    if logged_in?
      "#{current_user.list_items.count}"
    elsif session[:list_items]
      "#{session[:list_items].count}"
    else
      "0"
    end
  end
  
  def num_favorites
    if logged_in?
      current_user.favorites.size
    else
      0
    end
  end
  
  def toolbar?
    return @toolbar
  end
  
  def show_ad?
    return !@hide_ad
  end

  def elias_mode?
    return @elias_mode
  end
end
