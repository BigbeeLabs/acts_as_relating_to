require 'rails_helper'

RSpec.describe "Foo spec" do
	before(:each) do
		@foo = FactoryGirl.create(:foo)
		@bar = FactoryGirl.create(:bar)
	end
	it "does something useful" do
		puts "something useful"
	end
end

