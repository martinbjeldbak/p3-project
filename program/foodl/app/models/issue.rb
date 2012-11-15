# == Schema Information
#
# Table name: issues
#
#  id                :integer          not null, primary key
#  description       :text
#  issue_category_id :integer
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Issue < ActiveRecord::Base
  attr_accessible :description, :issue_category_id

  belongs_to :user
  belongs_to :issue_category
end
