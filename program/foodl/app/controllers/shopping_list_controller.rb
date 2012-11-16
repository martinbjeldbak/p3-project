class ShoppingListController < ApplicationController
  def index
    @user = current_user

    @shopping_list = @user.list_items
  end

  # Manglende actions:
  #   - Tilføj item fra opskrift
  #   - Fjern tilføjet listitem fra opskrift

  #   - Fjern listeitem fra indkøbslisten
  #   - Printfunktion
  #   - Send til email
end
