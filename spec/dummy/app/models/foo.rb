class Foo < ActiveRecord::Base
	acts_as_relating_to :bars
  acts_as_relating_to :people, class_name: 'Bar'
  acts_as_sharing_relationship_invitations_with :people, class_name: 'Bar'
end
