require 'rails_helper'

RSpec.describe Baz do
  before(:all) do 
    AppCollaborators::Loader.load 'test'
  end
  it "responds" do 
    expect(baz.respond_to?(:relate_to_hamster)).to be_truthy
  end

  context "when the request is successful" do 
    before(:each) do 
      stub_success
    end
    it "does something" do 
      baz.relate_to_hamster(qax, as: 'friend').tap do |returned|
        puts "returned:"<<" #{returned}".light_blue
      end
    end
  end

  xcontext "when the request is successful" do 
    before(:each) do 
      stub_failure
    end
    it "does something" do 
      baz.invite_person_to_relationship(bar).tap do |returned|
        expect(returned[:id]).to be_nil
        expect(returned[:errors]).to_not be_nil
      end
    end
  end

end

def qax() @qax ||= new_qax end

def new_qax
  Baz.new(id: 2)
end

def baz() @baz ||= new_baz end

def new_baz
  Baz.new(id: 1, credential: {token: 'token'})
end

def bar() @bar ||= create_bar end

def create_bar
  Bar.create
end

def stub_success
  response = {success: true}.to_json
  stub_request(:post, "https://bigbee-graph-staging.herokuapp.com/api/v0/bazs/1/relate_to_thing?as=friend&thing%5Bthing_id%5D=2&thing%5Bthing_type%5D=Baz").
    with(headers: {'Token'=>'token'}).
    to_return(status: 200, body: response, headers: {})
end

def stub_failure
  response = {errors: ["well, shoot"]}.to_json
  stub_request(:post, "https://bigbee-graph-staging.herokuapp.com/api/v0/bazs/1/relationship_invitations?as=friend&thing_id=#{bar.id}&thing_type=Bar").
    with(headers: {'Token'=>'token'}).
    to_return(status: 200, body: response, headers: {})
end
