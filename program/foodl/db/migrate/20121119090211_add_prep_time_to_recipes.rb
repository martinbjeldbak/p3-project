class AddPrepTimeToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :prep_time, :integer
  end
end
