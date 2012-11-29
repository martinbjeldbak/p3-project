# == Schema Information
#
# Table name: issue_categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  describable :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class IssueCategory < ActiveRecord::Base
  attr_accessible :indescribable, :name

  has_many :issues
end