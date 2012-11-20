class AddMatchToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :match, :float
  end
end
