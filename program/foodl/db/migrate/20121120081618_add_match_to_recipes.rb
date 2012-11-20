class AddMatchToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :match, :float
  end
end
