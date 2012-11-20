class ShoppingListController < ApplicationController
  respond_to :json

  def index
    @user = current_user

    @shopping_list = @user.list_items

    @listItem = ListItem.new
  end

  def create
    @listItem = ListItem.new

    @listItem.name = params[:name]
    @listItem.user = current_user

    if @listItem.save
      render json: @listItem
    else
      render json: @listItem.errors
    end
  end

  def remove
    @listItem = ListItem.find_by_id(params[:id])

    if @listItem.user == current_user and @listItem.destroy
      render json: @listItem
    else
      render json: @listItem.errors
    end

  end

  # Manglende actions:
  #   - Tilføj item fra opskrift
  #      - husk at tilføj til session hvis ikke loggt ind
  #   - Fjern tilføjet listitem fra opskrift

  #   - Fjern listeitem fra indkøbslisten
  #   - Printfunktion
  #   - Send til email
end
