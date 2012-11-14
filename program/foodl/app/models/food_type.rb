class FoodType < ActiveRecord::Base
  attr_accessible :name

  has_many :ingredients
  has_many :list_items
end
