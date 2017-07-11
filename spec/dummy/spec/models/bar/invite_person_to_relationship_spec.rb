require 'rails_helper'

RSpec.describe Bar do
  before(:all) do 
    AppCollaborators::Loader.load 'test'
    RoleLoader.load_all
  end
  it "responds" do 
    expect(bar.respond_to?(:invite_person_to_relationship)).to be_truthy
  end

  context "when the request is successful" do 
    before(:each) do 
      stub_success
    end
    it "does something" do 
      bar.invite_person_to_relationship(foo).tap do |returned|
        puts "returned:"<<" #{returned}".light_blue
      end
      bar.invite_person_to_relationship(foo).tap do |returned|
        puts "returned:"<<" #{returned}".light_blue
      end
      bar.invite_person_to_relationship(foo, as: ["mentor"]).tap do |returned|
        puts "returned:"<<" #{returned}".light_blue
      end
      bar.invite_person_to_relationship(foo, as: "mentor").tap do |returned|
        puts "returned:"<<" #{returned}".light_blue
      end
      bar.invite_person_to_relationship(foo, as: "friend friend").tap do |returned|
        puts "returned:"<<" #{returned}".light_blue
      end
      bar.invite_person_to_relationship(bar, as: "friend mentor").tap do |returned|
        puts "returned:"<<" #{returned}".light_blue
      end
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
