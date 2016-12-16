# == Schema Information
#
# Table name: acts_as_relating_to_roles
#
#  id           :integer          not null, primary key
#  name         :string
#  display_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

module ActsAsRelatingTo
  class Role < ActiveRecord::Base
  end
end
