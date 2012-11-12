class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :url
      t.binary :picture
      t.integer :rating

      t.timestamps
    end
  end
end
