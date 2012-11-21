class AddAliasForToFoodTypes < ActiveRecord::Migration
  def change
    add_column :food_types, :alias_for, :integer
  end
end
