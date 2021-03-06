# == Schema Information
#
# Table name: recipes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  url        :text
#  picture    :binary
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Recipe < ActiveRecord::Base

  include RecipesHelper

  attr_accessible :name, :picture, :rating, :url, :prep_time

  has_many :ingredients

  has_and_belongs_to_many :users, :join_table => 'users_recipes'

  def calculate_rating
    return rating.to_f / max_rating.to_f
  end
end
