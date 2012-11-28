module ApplicationHelper

  def list_count
    if logged_in?
      "#{current_user.list_items.count}"
    elsif session[:list_items]
      "#{session[:list_items].count - 1}"
    else
      "0"
    end
  end
  
  def num_favorites
    if logged_in?
      current_user.favorites.size
    elsif session[:favored]
      session[:favored].count
		else
		  0
    end
  end

  def full_title(page_title)
    base_title = "foodl"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
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
