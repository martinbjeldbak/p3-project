class CreateUserRecipeJoinTable < ActiveRecord::Migration
  def change
    create_table :users_recipes, :id => false do |t|
      t.integer :user_id
      t.integer :recipe_id
    end
  end
end
