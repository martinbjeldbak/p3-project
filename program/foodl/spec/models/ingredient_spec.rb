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

require 'spec_helper'

describe Ingredient do
  pending "add some examples to (or delete) #{__FILE__}"
end
