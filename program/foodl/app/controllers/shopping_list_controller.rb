class ShoppingListController < ApplicationController
  def index
    @user = current_user

    @shopping_list = @user.list_items
  end

  # Manglende actions:
  #   - Tilføj item fra opskrift
  #      - husk at tilføj til session hvis ikke loggt ind
  #   - Fjern tilføjet listitem fra opskrift

  #   - Fjern listeitem fra indkøbslisten
  #   - Printfunktion
  #   - Send til email
end
