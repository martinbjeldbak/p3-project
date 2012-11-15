# == Schema Information
#
# Table name: list_items
#
#  id           :integer          not null, primary key
#  quantity     :float
#  name         :string(255)
#  unit         :string(255)
#  user_id      :integer
#  food_type_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ListItem < ActiveRecord::Base
  attr_accessible :food_type_id, :name, :quantity, :unit, :user_id

  belongs_to :user
  belongs_to :food_type
end
