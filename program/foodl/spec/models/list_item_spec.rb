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

require 'spec_helper'

describe ListItem do
  pending "add some examples to (or delete) #{__FILE__}"
end
