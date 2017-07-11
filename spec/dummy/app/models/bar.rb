class Bar < ActiveRecord::Base
	acts_as_relating_to :foos
  acts_as_relating_to :boos, class_name: 'Foo'
  acts_as_relating_to :people, class_name: 'Foo'
end
