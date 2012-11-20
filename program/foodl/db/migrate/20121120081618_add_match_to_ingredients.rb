class AddMatchToRecipes < ActiveRecord::Migration
  def change
    add_column :ingredients, :match, :float
  end
end
