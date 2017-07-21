require 'rails_helper'

RSpec.describe Bar do

  before(:all) do 
    RoleLoader.load_all
  end

  it "responds" do 
    expect(bar.respond_to?(:relate_to_person)).to be_truthy
  end

  context "when telling bar to relate to foo as a friend" do 
    it "creates two relationships" do 
      expect{bar.relate_to_person(foo, as: 'friend')}.to change{ActsAsRelatingTo::Relationship.count}.by(2)
    end
    it "creates two HasAs" do 
      expect{bar.relate_to_person(foo, as: 'friend')}.to change{ActsAsHaving::HasA.count}.by(2)
    end
  end

  context "after telling bar to relate to foo as a friend" do
    before(:each) do 
      bar.relate_to_person(foo, as: 'friend')
    end
    it "bar relates to foo as a friend" do 
      expect(bar.relates_to_person?(foo, as: 'friend')).to be_truthy
    end
    it "bar does not relate to foo as a bingbong" do 
      expect(bar.relates_to_person?(foo, as: 'bingbong')).to be_falsey
    end
    it "foo relates to bar as a friend" do 
      expect(foo.relates_to_person?(bar, as: 'friend')).to be_truthy
    end
    context "when telling bar to relate to foo as a friend (again)" do 
      it "creates no relationships" do 
        expect{bar.relate_to_person(foo, as: 'friend')}.to change{ActsAsRelatingTo::Relationship.count}.by(0)
      end
      it "creates no HasAs" do 
        expect{bar.relate_to_person(foo, as: 'friend')}.to change{ActsAsHaving::HasA.count}.by(0)
      end
    end
  end

  context "when telling bar to relate to foo in a non-existant role" do 
    it "creates one relationship ('cause there's no way to reciprocate)" do 
      expect{bar.relate_to_person(foo, as: 'bingbong')}.to change{ActsAsRelatingTo::Relationship.count}.by(1)
    end
    it "creates no HasAs" do 
      expect{bar.relate_to_person(foo, as: 'bingbong')}.to change{ActsAsHaving::HasA.count}.by(0)
    end
    it "creates one ActsAsTaggableOn::Tagging" do 
      expect{bar.relate_to_person(foo, as: 'bingbong')}.to change{ActsAsTaggableOn::Tagging.count}.by(1)
    end

  end

  context "after telling bar to relate to foo in a non-existant role" do
    before(:each) do 
      bar.relate_to_person(foo, as: 'bingbong')
    end
    it "bar relates to foo as a bingbong" do 
      expect(bar.relates_to_person?(foo, as: 'bingbong')).to be_truthy
    end
    it "foo does not relate to bar as a bingbong" do 
      expect(foo.relates_to_person?(bar, as: 'bingbong')).to be_falsey
    end
  end

end

def baz() @baz ||= new_baz end

def new_baz
  Baz.new(id: 1, credential: {token: 'token'})
end

def foo() @foo ||= create_foo end

def create_foo
  Foo.create
end

def bar() @bar ||= create_bar end

def create_bar
  Bar.create
end

def stub_success
  response = {id: 1}.to_json
  stub_request(:post, "https://bigbee-graph-staging.herokuapp.com/api/v0/bazs/1/relationship_invitations?as=friend&thing_id=#{bar.id}&thing_type=Bar").
    with(headers: {'Token'=>'token'}).
    to_return(status: 200, body: response, headers: {})
end

def stub_failure
  response = {errors: ["well, shoot"]}.to_json
  stub_request(:post, "https://bigbee-graph-staging.herokuapp.com/api/v0/bazs/1/relationship_invitations?as=friend&thing_id=#{bar.id}&thing_type=Bar").
    with(headers: {'Token'=>'token'}).
    to_return(status: 200, body: response, headers: {})
end
