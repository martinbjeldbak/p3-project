# == Schema Information
#
# Table name: ingredients
#
#  id           :integer          not null, primary key
#  quantity     :float
#  unit         :string(255)
#  food_type_id :integer
#  recipe_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  name         :string(255)
#

class Ingredient < ActiveRecord::Base
  attr_accessible :food_type_id, :name, :quantity, :unit

  belongs_to :food_type
  belongs_to :recipe
end
