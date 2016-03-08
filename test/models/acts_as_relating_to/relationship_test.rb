# == Schema Information
#
# Table name: acts_as_relating_to_relationships
#
#  id                  :integer          not null, primary key
#  owner_id            :integer
#  owner_type          :string
#  in_relation_to_id   :integer
#  in_relation_to_type :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

module ActsAsRelatingTo
  class RelationshipTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
