require 'rails_helper'

RSpec.describe Bar do
  before(:all) do 
    AppCollaborators::Loader.load 'test'
    RoleLoader.load_all
  end
  it "responds" do 
    expect(bar.respond_to?(:reinstate_relationship_invitation)).to be_truthy
  end

  context "after bar has invited foo to be a friend" do 
    before(:each) do 
      bar_invite_foo_as_friend
      use_first_relationship_invitation
      reload_relationship_invitation
    end
    it "the relationship_invitation has a status of 'pending'" do
      expect(@relationship_invitation.status).to eq('pending')
    end
    it "bar is NOT foo's friend" do 
      expect(bar.relates_to_foo?(foo, as: 'friend')).to be_falsey
    end
    it "foo is NOT bar's friend" do
      expect(foo.relates_to_bar?(bar, as: 'friend')).to be_falsey
    end
    context "after foo accepts bar's friend invitation" do 
      before(:each) do 
        accept_invitation
        reload_relationship_invitation
      end
      it "the relationship_invitation has a status of 'accepted'" do
        expect(@relationship_invitation.status).to eq('accepted')
      end
      it "bar is foo's friend" do 
        expect(bar.relates_to_foo?(foo, as: 'friend')).to be_truthy
      end
      it "foo is bar's friend" do
        expect(foo.relates_to_bar?(bar, as: 'friend')).to be_truthy
      end
      context "after bar cancels the friend invitation" do 
        before(:each) do
          cancel_invitation
          reload_relationship_invitation
        end
        it "the relationship_invitation has a status of 'cancelled_accepted'" do
          expect(@relationship_invitation.status).to eq('cancelled_accepted')
        end
        it "bar is NOT foo's friend" do 
          expect(bar.relates_to_foo?(foo, as: 'friend')).to be_falsey
        end
        it "foo is NOT bar's friend" do
          expect(foo.relates_to_bar?(bar, as: 'friend')).to be_falsey
        end
        context "when bar reinstates the friend invitation" do 
          it "relationships_count changes by 2" do 
            expect{reinstate_invitation}.to change{relationships_count}.by(2)
          end
          it "has_as_count changes by 2" do
            expect{reinstate_invitation}.to change{has_as_count}.by(2)
          end
        end
        context "after bar reinstates the friend invitation" do
          before(:each) do 
            reinstate_invitation
            reload_relationship_invitation
          end
          it "the relationship request has a status of 'accepted'" do 
            expect(@relationship_invitation.status).to eq('accepted')
          end
          it "bar is foo's friend" do 
            expect(bar.relates_to_foo?(foo, as: 'friend')).to be_truthy
          end
          it "foo is bar's friend" do
            expect(foo.relates_to_bar?(bar, as: 'friend')).to be_truthy
          end
        end
      end
    end
    context "after foo declines bar's friend invitation" do 
      before(:each) do 
        decline_invitation
        reload_relationship_invitation
      end
      it "the relationship_invitation has a status of 'declined'" do
        expect(@relationship_invitation.status).to eq('declined')
      end
      it "bar is NOT foo's friend" do 
        expect(bar.relates_to_foo?(foo, as: 'friend')).to be_falsey
      end
      it "foo is NOT bar's friend" do
        expect(foo.relates_to_bar?(bar, as: 'friend')).to be_falsey
      end
      context "after bar cancels the friend invitation" do 
        before(:each) do 
          cancel_invitation
          reload_relationship_invitation
        end
        it "the relationship_invitation has a status of 'cancelled_declined'" do
          expect(@relationship_invitation.status).to eq('cancelled_declined')
        end
        it "bar is NOT foo's friend" do 
          expect(bar.relates_to_foo?(foo, as: 'friend')).to be_falsey
        end
        it "foo is NOT bar's friend" do
          expect(foo.relates_to_bar?(bar, as: 'friend')).to be_falsey
        end
        context "when bar reinstates the friend invitation" do
          it "relationships_count changes by 0" do
            expect{reinstate_invitation}.to change{relationships_count}.by(0)
          end
          it "has_as_count changes by 0" do
            expect{reinstate_invitation}.to change{has_as_count}.by(0)
          end
        end 
        context "after bar reinstates the friend invitation" do 
          before(:each) do 
            reinstate_invitation
            reload_relationship_invitation
          end
          it "the relationship_invitation has a status of 'declined'" do
            expect(@relationship_invitation.status).to eq('declined')
          end
          it "bar is NOT foo's friend" do 
            expect(bar.relates_to_foo?(foo, as: 'friend')).to be_falsey
          end
          it "foo is NOT bar's friend" do
            expect(foo.relates_to_bar?(bar, as: 'friend')).to be_falsey
          end
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

def bar_invite_foo_as_friend
  bar.invite_person_to_relationship(foo, as: 'friend')
end

def reinstate_invitation
  bar.reinstate_relationship_invitation(id: @relationship_invitation.id)
end

def cancel_invitation
  bar.cancel_relationship_invitation(id: @relationship_invitation.id)
end

def decline_invitation
  foo.decline_relationship_invitation(id: @relationship_invitation.id)
end

def accept_invitation
  foo.accept_relationship_invitation(id: @relationship_invitation.id)
end

def reload_relationship_invitation
  @relationship_invitation.reload
end

def foo() @foo ||= create_foo end

def create_foo
  Foo.create
end

def bar() @bar ||= create_bar end

def create_bar
  Bar.create
end