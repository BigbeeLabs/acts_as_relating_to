# == Schema Information
#
# Table name: acts_as_relating_to_relationship_invitations
#
#  id             :integer          not null, primary key
#  sender_id      :integer
#  sender_type    :string
#  recipient_id   :integer
#  recipient_type :string
#  status         :integer          default(0)
#  role_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

module ActsAsRelatingTo
  class RelationshipInvitationTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
