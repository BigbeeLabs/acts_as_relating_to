require 'rails_helper'

RSpec.describe Baz do
  before(:all) do 
    AppCollaborators::Loader.load 'test'
  end
  it "responds" do 
    expect(baz.respond_to?(:invite_person_to_relationship)).to be_truthy
  end

  context "when the request is successful" do 
    before(:each) do 
      stub_success
    end
    it "does something" do 
      baz.invite_person_to_relationship(bar).tap do |returned|
        expect(returned).to_not be_nil
        expect(returned[:relationship_invitation_id]).to_not be_nil
        expect(returned[:errors]).to be_nil
      end
    end
  end

  context "when the request is successful" do 
    before(:each) do 
      stub_failure
    end
    it "does something" do 
      baz.invite_person_to_relationship(bar).tap do |returned|
        expect(returned).to_not be_nil
        expect(returned[:relationship_invitation_id]).to be_nil
        expect(returned[:errors]).to_not be_nil
      end
    end
  end

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
  response = {relationship_invitation_id: 1}.to_json
  stub_request(:post, "https://bigbee-graph-staging.herokuapp.com/api/v0/bazs/1/sent_relationship_invitations?as=friend&thing_id=#{bar.id}&thing_type=Bar").
    with(headers: {'Token'=>'token'}).
    to_return(status: 200, body: response, headers: {})
end

def stub_failure
  response = {errors: ["well, shoot"]}.to_json
  stub_request(:post, "https://bigbee-graph-staging.herokuapp.com/api/v0/bazs/1/sent_relationship_invitations?as=friend&thing_id=#{bar.id}&thing_type=Bar").
    with(headers: {'Token'=>'token'}).
    to_return(status: 200, body: response, headers: {})
end
