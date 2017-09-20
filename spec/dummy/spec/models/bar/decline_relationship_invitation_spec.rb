require 'rails_helper'

RSpec.describe Bar do
  before(:all) do 
    AppCollaborators::Loader.load 'test'
    RoleLoader.load_all
  end
  it "responds" do 
    expect(foo.respond_to?(:decline_relationship_invitation)).to be_truthy
  end

  context "after Bar has invited Foo to be a friend" do 
    before(:each) do 
      bar.invite_person_to_relationship(foo, as: 'friend')
      use_first_relationship_invitation
=begin
      accept_invitation
      bar.invite_person_to_relationship(foo, as: 'parent')
      use_second_relationship_invitation
      accept_invitation
=end      
    end
    context "when declining to be Bar's friend" do 
      before(:each) do 
        use_first_relationship_invitation
      end
      it "the first relationship_invitation status is 'pending'" do
        expect(@relationship_invitation.status).to eq('pending')
      end
      it "changes has_as_count by 0" do 
        expect{decline_invitation}.to change{has_as_count}.by(0)
      end
      it "changes relationships_count by 0" do 
        expect{decline_invitation}.to change{relationships_count}.by(0)
      end
      it "returns true" do 
        expect(decline_invitation).to eq(true)
      end
    end
    context "after Foo declines to be Bar's friend" do 
      before(:each) do 
        use_first_relationship_invitation
        decline_invitation
        use_first_relationship_invitation
      end
      it "the first relationship_invitation status is 'declined'" do
        expect(@relationship_invitation.status).to eq('declined')
      end
      it "there are no relationships" do 
        expect(relationships_count).to eq(0)
      end
    end
    context "after Foo accepts Bar's friend invitation" do 
      before(:each) do 
        use_first_relationship_invitation
        accept_invitation
      end
      context "when Foo declines Bar's friend invitation" do
        it "changes has_as_count by -2" do 
          expect{decline_invitation}.to change{has_as_count}.by(-2)
        end
        it "changes relationships_count by -2" do 
          expect{decline_invitation}.to change{relationships_count}.by(-2)
        end
      end
      context "after Foo declines Bar's friend invitation" do 
        before(:each) do 
          decline_invitation
          @relationship_invitation.reload
        end
        it "the relationship_invitation status is 'declined'" do
          expect(@relationship_invitation.status).to eq('declined')
        end
      end
      context "when Bar cancels Foo's friend invitation" do 
      end 
      context "after Bar cancels Foo's friend invitation" do 
        before(:each) do
          cancel_invitation
          @relationship_invitation.reload
        end
        it "the relationship_invitation has a status of 'cancelled_accepted'" do 
          expect(@relationship_invitation.status).to eq('cancelled_accepted')
        end
        context "when Foo declines Bar's friend invitation" do 
          it "changes relationships_count by 0" do 
            expect{decline_invitation}.to change{relationships_count}.by(0)
          end
          it "changes has_as_count by 0" do 
            expect{decline_invitation}.to change{has_as_count}.by(0)
          end
        end
        context "after Foo declines Bar's friend invitation" do 
          before(:each) do 
            use_first_relationship_invitation
            decline_invitation
            @relationship_invitation.reload
          end 
          it "the relationship_invitation has a status of 'cancelled_declined'" do 
            expect(@relationship_invitation.status).to eq('cancelled_declined')
          end
        end
      end
    end
    context "after Bar has invited Foo to be a child" do
      before(:each) do 
        bar.invite_person_to_relationship(foo, as: 'parent')
      end
      context "after Foo accepts Bar's friend invitation" do 
        before(:each) do 
          use_first_relationship_invitation
          accept_invitation
          @relationship_invitation.reload
        end
        context "when declining to be Bar's child" do 
          before(:each) do 
            use_second_relationship_invitation
          end
          it "changes has_as_count by 0" do 
            expect{decline_invitation}.to change{has_as_count}.by(0)
          end
          it "changes relationships_count by 0" do 
            expect{decline_invitation}.to change{relationships_count}.by(0)
          end
        end
        context "after decling to be Bar's child" do 
          before(:each) do 
            use_second_relationship_invitation
            decline_invitation
            @relationship_invitation.reload
          end
          it "the relationship_invitation status is 'declined'" do
            expect(@relationship_invitation.status).to eq('declined')
          end
          it "there are two relationships" do 
            expect(relationships_count).to eq(2)
          end
          context "when declining to be Bar's friend" do 
            before(:each) do 
              use_first_relationship_invitation
            end
            it "changes the relationship count by -2" do 
              expect{decline_invitation}.to change{relationships_count}.by(-2)
            end
          end
        end
      end
    end

    xcontext "after declining the second invitation" do 
      before(:each) do 
        use_second_relationship_invitation
        decline_invitation
        use_second_relationship_invitation
      end
      it "there are no relationships" do 
        expect(relationships_count).to eq(0)
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

def cancel_invitation
  bar.cancel_relationship_invitation(id: @relationship_invitation.id)
end

def decline_invitation
  foo.decline_relationship_invitation(id: @relationship_invitation.id)
end

def accept_invitation
  foo.accept_relationship_invitation(id: @relationship_invitation.id)
end

def foo() @foo ||= create_foo end

def create_foo
  Foo.create
end

def bar() @bar ||= create_bar end

def create_bar
  Bar.create
end