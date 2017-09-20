require 'rails_helper'

RSpec.describe Bar do
  before(:all) do 
    AppCollaborators::Loader.load 'test'
    RoleLoader.load_all
  end
  it "responds" do 
    expect(bar.respond_to?(:cancel_relationship_invitation)).to be_truthy
  end

  context "when Bar has sent Foo a relationship_invitation" do 
    before(:each) do 
      bar.invite_person_to_relationship(foo, as: 'friend')
      use_first_relationship_invitation
    end
    context "when the invitation is pending" do 
      before(:each) do 
        use_first_relationship_invitation
      end
      context "when cancelling the invitation" do 
        it "changes relationship_invitations_count by -1" do 
          expect{cancel_invitation}.to change{relationship_invitations_count}.by(-1)
        end
        it "changes relationships_count by 0" do 
          expect{cancel_invitation}.to change{relationships_count}.by(0)
        end
        it "returns nil" do 
          expect(cancel_invitation).to eq(nil)
        end
      end
    end
    
    context "after foo has accepted" do
      before(:each) do 
        accept_invitation
      end
      context "when cancelling the invitation" do
        it "changes relationships_count by -2" do 
          expect{cancel_invitation}.to change{relationships_count}.by(-2)
        end
        it "returns an invitation" do 
          expect(cancel_invitation).to be_a(ActsAsRelatingTo::RelationshipInvitation)
        end
      end
      context "after bar cancels the relationship invitation" do 
        before(:each) do 
          cancel_invitation
          @relationship_invitation.reload
        end
        it "it has a status of 'cancelled_accepted'" do 
          expect(@relationship_invitation.status).to eq('cancelled_accepted')
        end
      end
    end

    context "after foo has declined" do
      before(:each) do 
        decline_invitation
        @relationship_invitation.reload
      end
      context "when cancelling the invitation" do
        it "changes relationships_count by 0" do 
          expect{cancel_invitation}.to change{relationships_count}.by(0)
        end
        it "returns an invitation" do 
          expect(cancel_invitation).to be_a(ActsAsRelatingTo::RelationshipInvitation)
        end
      end
      context "after the invitation is cancelled" do 
        before(:each) do 
          cancel_invitation
          @relationship_invitation.reload
        end
        it "it has a status of 'cancelled_declined'" do 
          expect(@relationship_invitation.status).to eq('cancelled_declined')
        end
      end
    end

  end
end

def use_first_relationship_invitation
  @relationship_invitation = foo.received_relationship_invitations.first
end

def use_second_relationship_invitation
  @relationship_invitation = foo.received_relationship_invitations.last
end

def relationship_invitations_count
  ActsAsRelatingTo::RelationshipInvitation.count
end

def relationships_count
  relationships.count
end

def relationships
  ActsAsRelatingTo::Relationship.all
end

def has_as_count
  ActsAsHaving::HasA.count
end

def decline_invitation
  foo.decline_relationship_invitation(id: @relationship_invitation.id)
end

def accept_invitation
  foo.accept_relationship_invitation(id: @relationship_invitation.id)
end

def cancel_invitation
  bar.cancel_relationship_invitation(id: @relationship_invitation.id)
end


def foo() @foo ||= create_foo end

def create_foo
  Foo.create
end

def bar() @bar ||= create_bar end

def create_bar
  Bar.create
end