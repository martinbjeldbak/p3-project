class Recipe < ActiveRecord::Base
  attr_accessible :name, :picture, :rating, :url

  has_many :ingredients
end
