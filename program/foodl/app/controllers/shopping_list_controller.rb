class ShoppingListController < ApplicationController
  respond_to :json

  def index
    @listItem = ListItem.new

    if logged_in?
      user = current_user
      @shopping_list = user.list_items
    else
      session[:list_items] ||= []

      @shopping_list = session[:list_items]
    end


  end

  def create
    @listItem = ListItem.new(name: params[:name])

    if logged_in?
      @listItem.user = current_user

      if @listItem.save
        render json: @listItem
      else
        render json: @listItem.errors
      end

    else
      @listItem.id = session[:list_items].length
      session[:list_items] << @listItem

      if session[:list_items].include?(@listItem)
        render json: @listItem
      else
        render json: @listItem.errors
      end
    end


  end

  def remove
    if logged_in?
      @listItem = ListItem.find_by_id(params[:id])

      if @listItem.destroy # and @listItem.user == current_user
        render json: @listItem
      else
        render json: @listItem.errors
      end
    else
      @listItem = session[:list_items][params[:id].to_i]

      if session[:list_items].delete(@listItem)
        render json: @listItem
      else
        render json: @listItem.errors
      end
    end
  end

  def add_recipe
    recipe = Recipe.find_by_id(params[:id])

    recipe.ingredients.each do |ingredient|
      listItem = ingredient_to_list_item(ingredient)

      if logged_in?
        listItem.user = current_user
        listItem.save
      else
        session[:list_items] ||= []
        listItem.id = session[:list_items].length
        session[:list_items] << listItem
      end
    end

    return respond_to do |format|
      format.html do
        redirect_to :shopping_list
      end
      format.json do
        render json: true
      end
    end
  end

  private

  def ingredient_to_list_item(ingredient)
    ListItem.new(name: ingredient.name, quantity: ingredient.quantity, unit: ingredient.unit)
  end
end
