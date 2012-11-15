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

require 'spec_helper'

describe IssueCategory do
  pending "add some examples to (or delete) #{__FILE__}"
end
