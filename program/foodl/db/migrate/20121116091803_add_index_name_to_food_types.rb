class AddIndexNameToFoodTypes < ActiveRecord::Migration
  def change
    add_index :food_types, :name, { :unique => true }
  end
end
