# == Schema Information
#
# Table name: acts_as_relating_to_roles
#
#  id           :integer          not null, primary key
#  name         :string
#  display_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  reciprocal   :string
#

require_dependency 'acts_as_relating_to'

class ActsAsRelatingTo::Role < ActiveRecord::Base
  validates :name,
            :display_name,
            presence: true
end
