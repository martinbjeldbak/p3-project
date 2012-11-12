class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.float :quantity
      t.string :unit
      t.integer :food_type_id

      t.timestamps
    end
  end
end
