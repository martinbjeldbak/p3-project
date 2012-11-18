# == Schema Information
#
# Table name: food_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  verified   :boolean
#

class FoodType < ActiveRecord::Base
  attr_accessible :id, :name

  has_many :ingredients
  has_many :list_items
end
