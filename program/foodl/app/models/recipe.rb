class Recipe < ActiveRecord::Base
  attr_accessible :name, :picture, :rating, :url

  has_many :ingredients

  has_and_belongs_to_many :users
end
