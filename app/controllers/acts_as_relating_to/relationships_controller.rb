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

require_dependency "acts_as_relating_to/application_controller"

module ActsAsRelatingTo
  class RelationshipsController < ApplicationController
    def new
    end

    def create
    end

    def edit
    end

    def show
    end

    def update
    end

    def destroy
    end
  end
end
