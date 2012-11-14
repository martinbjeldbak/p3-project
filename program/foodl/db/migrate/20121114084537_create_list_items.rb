class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.float :quantity
      t.string :name
      t.string :unit
      t.integer :user_id
      t.integer :food_type_id

      t.timestamps
    end
  end
end
