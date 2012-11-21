class RemoveVerifiedFromFoodTypes < ActiveRecord::Migration
  def change
    remove_column :food_types, :verified
  end
end
