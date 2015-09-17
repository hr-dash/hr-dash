# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  group_name :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Group, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
