class Ingredient < ActiveRecord::Base
  attr_accessible :food_type_id, :quantity, :unit

  belongs_to :food_type
  belongs_to :recipe
end
