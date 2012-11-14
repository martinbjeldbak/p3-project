class IssueCategory < ActiveRecord::Base
  attr_accessible :indescribable, :name

  has_many :issues
end
