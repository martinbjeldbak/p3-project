class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  helper_method :firebug
  helper_method :num_favorites

  def num_favorites
    if !current_user
      return 0
    end
    current_user.favorites.size
  end

  def addIngredientsToList(recipe)
    recipe.ingredients.each do |ingredient|
      listItem = ingredientToListItem(ingredient)

      if logged_in?
        listItem.user = current_user
        listItem.save
      else
        session[:list_items] ||= []
        listItem.id = session[:list_items].length
        session[:list_items] << listItem
      end
    end
  end

  private
  def firebug(message, type = :debug)
    request.env['firebug.logs'] ||= []
    request.env['firebug.logs'] << [type.to_sym, message.to_s]
  end

  def ingredientToListItem(ingredient)
    ListItem.new(name: ingredient.name, quantity: ingredient.quantity, unit: ingredient.unit)
  end

end
