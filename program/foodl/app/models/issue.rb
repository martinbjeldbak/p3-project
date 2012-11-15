class Issue < ActiveRecord::Base
  attr_accessible :description, :issue_category_id

  belongs_to :user
  belongs_to :issue_category
end
