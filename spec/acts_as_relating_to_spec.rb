require 'rails_helper'

RSpec.describe "ActsAsRelatingTo" do
	before(:each) do
		@foo = FactoryGirl.create(:foo)
		@bar = FactoryGirl.create(:bar)
	end

	describe "associations are generated correctly" do
		it "@foo responds_to 'referencing_relationships'" do
			expect(@foo.respond_to?('referencing_relationships')).to be_truthy
		end
		it "@foo responds_to 'bars_i_relate_to'" do
			expect(@foo.respond_to?('bars_i_relate_to')).to be_truthy
		end
		it "@foo responds_to 'bars_that_relate_to_me'" do
			expect(@foo.respond_to?('bars_that_relate_to_me')).to be_truthy
		end
		it "@foo responds_to 'owned_relationships_to_bars'" do
			expect(@foo.respond_to?('owned_relationships_to_bars')).to be_truthy
		end
	end

	describe "relate_to" do
		it "increases Relationship.count by 1" do
			expect{@foo.relate_to @bar}.to change{ActsAsRelatingTo::Relationship.count}.by(1)
		end
		describe "after relating" do
			before(:each) do
				@foo.relate_to @bar
			end
			it "@foo relates to 1 bar" do
				expect(@foo.bars_i_relate_to.count).to eq(1)
			end
			it "@foo has 1 owned_relationships_to_bars" do
				@owned_relationships_to_bars = @foo.owned_relationships_to_bars
				expect(@foo.owned_relationships_to_bars.count).to eq(1)
			end
		end
	end

	describe "relates_to?" do
		it "before relating, returns false" do
			expect(@foo.relates_to? @bar).to be_falsey
		end
		it "after relating, returns true" do
			@foo.relate_to @bar
			expect(@foo.relates_to? @bar).to be_truthy
		end
	end

	describe "relates_to_as? (using 'admin' for test)" do
		it "before relate_to, returns false" do
			expect(@foo.relates_to_as? @bar, 'admin').to be_falsey
		end
		it "after relate_to (with no 'as' passed), returns false" do
			@foo.relate_to @bar
			expect(@foo.relates_to_as? @bar, 'admin').to be_falsey
		end
		it "after relate_to, as: 'friend', returns false" do
			@foo.relate_to @bar, as: 'friend'
			expect(@foo.relates_to_as? @bar, 'admin').to be_falsey
		end
		it "after relate_to, as: 'admin', returns true" do
			@foo.relate_to @bar, as: 'admin'
			expect(@foo.relates_to_as? @bar, 'admin').to be_truthy
		end
	end

	describe "relationship_to" do
		before(:each) do
			@foo.relate_to @bar
			@r = @foo.relationship_to @bar
		end
		it "returns an ActiveRecord::AssociationRelation" do
			expect(@r.class.name).to eq('ActiveRecord::AssociationRelation')
		end
		it "the ActiveRecord::AssociationRelation has one element" do
			expect(@r.count).to eq(1)
		end
		it "the first element is a ActsAsRelatingTo::Relationship" do
			expect(@r.first.class.name).to eq('ActsAsRelatingTo::Relationship')
		end
	end


	describe "owned_relationships" do
		before(:each) do
			@foo.relate_to @bar
		end
		it "@foo responds_to 'owned_relationships'" do
			expect(@foo.respond_to?('owned_relationships')).to be_truthy
		end
		it "@foo has 1 owned_relationships" do
			expect(@foo.owned_relationships.count).to eq(1)
		end
	end

	describe "unrelate_to" do
		before(:each) do
			@foo.relate_to @bar
		end
		it "changes ActsAsRelatingTo::Relationship.count by -1" do
			expect{@foo.unrelate_to @bar}.to change{ActsAsRelatingTo::Relationship.count}.by(-1)
		end
	end

	describe "tell_to_unrelate" do
		before(:each) do
			@foo.relate_to @bar
		end
		it "changes ActsAsRelatingTo::Relationship.count by -1" do
			expect{@bar.tell_to_unrelate}.to change{ActsAsRelatingTo::Relationship.count}.by(-1)
		end

	end

	describe "destroy" do
		before(:each) do
			@foo.relate_to @bar
		end
		describe "when @foo relates to @bar" do 
			it "changes the number of foos by -1" do
				expect{@foo.destroy!}.to change{Foo.count}.by(-1)
			end
			it "changes ActsAsRelatingTo::Relationship.count by -1" do
				expect{@foo.destroy!}.to change{ActsAsRelatingTo::Relationship.count}.by(-1)
			end
		end
		describe "when @foo relates to @bar and @bar relates to @foo" do
			before(:each) do 
				@bar.relate_to @foo
			end
			it "changes ActsAsRelatingTo::Relationship.count by -2" do
				#@foo.destroy!
				expect{@foo.destroy!}.to change{ActsAsRelatingTo::Relationship.count}.by(-2)
			end
		end
	end

end

