class ListItem < ActiveRecord::Base
  attr_accessible :food_type_id, :name, :quantity, :unit, :user_id

  belongs_to :user
  belongs_to :food_type
end
