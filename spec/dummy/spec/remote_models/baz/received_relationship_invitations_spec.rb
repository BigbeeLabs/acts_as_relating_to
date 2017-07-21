require 'rails_helper'

RSpec.describe Baz do
  before(:all) do 
    AppCollaborators::Loader.load 'test'
  end
  it "responds" do 
    expect(baz.respond_to?(:received_relationship_invitations)).to be_truthy
  end

  context "when the request is successful" do 
    before(:each) do 
      stub_success
    end
    it "does something" do 
      baz.received_relationship_invitations.tap do |returned|
        puts "returned:"<<" #{returned}".light_blue
        expect(returned).to_not be_nil
        #expect(returned[:errors]).to be_nil
      end
    end
  end

  context "when the request is "+"NOT".red+" successful" do 
    before(:each) do 
      stub_failure
    end
    it "does something" do 
      baz.received_relationship_invitations.tap do |returned|
        puts "returned:"<<" #{returned}".light_blue
        expect(returned).to_not be_nil
        expect(returned[0].with_indifferent_access[:errors]).not_to be_nil
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
  response = [{id: 1}].to_json
  stub_request(:get, "https://bigbee-graph-staging.herokuapp.com/api/v0/bazs/#{baz.id}/received_relationship_invitations").
    with(headers: {'Token'=>'token'}).
    to_return(status: 200, body: response, headers: {})
end

def stub_failure
  response = [{errors: ["well, shoot"]}].to_json
  stub_request(:get, "https://bigbee-graph-staging.herokuapp.com/api/v0/bazs/#{baz.id}/received_relationship_invitations").
    with(headers: {'Token'=>'token'}).
    to_return(status: 200, body: response, headers: {})
end
