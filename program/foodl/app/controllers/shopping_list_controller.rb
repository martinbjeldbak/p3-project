class ShoppingListController < ApplicationController
  respond_to :json

  def index
    @listItem = ListItem.new

    if logged_in?
      user = current_user
      @shopping_list = user.list_items
    else
      session[:list_items] ||= {id: 0}

      @shopping_list = []
      session[:list_items].each do |k, v|
        if (k.is_a? Integer)
          @shopping_list << v
        end
      end
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
      @listItem.id = session[:list_items][:id]
      session[:list_items][@listItem.id] = @listItem
      session[:list_items][:id] += 1;

      if session[:list_items].has_value?(@listItem)
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
      if session[:list_items].delete(params[:id].to_i)
        render json: @listItem
      else
        render json: @listItem.errors
      end
    end
  end

  # TODO: Brug skaleringen (fra cookie (Sebastian?))
  def add_recipe
    recipe = Recipe.find_by_id(params[:id])

    recipe.ingredients.each do |ingredient|
      listItem = ingredient_to_list_item(ingredient)

      if logged_in?
        listItem.user = current_user
        listItem.save
      else
        session[:list_items] ||= {id: 0}
        listItem.id = session[:list_items][:id]
        session[:list_items][listItem.id] = listItem
        session[:list_items][:id] += 1
      end
    end

    respond_to do |format|
      format.html do
        redirect_to :shopping_list
      end
      format.json do
        render json: true
      end
    end
  end
  
   

  def delete_list
    params[:ids].each do |itemID|
      if logged_in?
        listItem = ListItem.find_by_id(itemID)

        begin
          listItem.destroy
        rescue
          next
        end

      # User not logged in
      else
        session[:list_items].delete(itemID.to_i)
      end
    end

    respond_to do |format|
      format.html do
        redirect_to :list
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
