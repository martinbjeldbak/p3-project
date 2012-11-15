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

require 'spec_helper'

describe Issue do
  pending "add some examples to (or delete) #{__FILE__}"
end
