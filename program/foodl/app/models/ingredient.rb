class Ingredient < ActiveRecord::Base
  attr_accessible :food_type_id, :quantity, :unit

  has_one :food_type
end
