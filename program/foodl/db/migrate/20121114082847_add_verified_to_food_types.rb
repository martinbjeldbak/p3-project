class AddVerifiedToFoodTypes < ActiveRecord::Migration
  def change
    add_column :food_types, :verified, :boolean
  end
end
