class AddOriginalToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :original, :string
  end
end
