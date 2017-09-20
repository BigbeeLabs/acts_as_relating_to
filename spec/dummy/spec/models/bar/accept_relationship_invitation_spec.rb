require 'rails_helper'

RSpec.describe Bar do
  before(:all) do 
    AppCollaborators::Loader.load 'test'
    RoleLoader.load_all
  end
  it "responds" do 
    expect(bar.respond_to?(:accept_relationship_invitation)).to be_truthy
  end

  context "when Foo has sent Bar a relationship_invitation" do 
    before(:each) do 
      bar.invite_person_to_relationship(foo, as: 'friend')
      use_first_invitation
      bar.invite_person_to_relationship(foo, as: 'parent')
    end

    context "when accepting the first invitation" do 
      before(:each) do 
        use_first_invitation
      end
      it "changes relationships_count by 2" do 
        expect{accept_invitation}.to change{relationships_count}.by(2)
      end
      it "changes has_as_count by 2" do 
        expect{accept_invitation}.to change{has_as_count}.by(2)
      end
      it "returns true" do 
        expect(accept_invitation).to eq(true)
      end
      context "when accepting the second relationship invitation" do 
        before(:each) do 
          use_first_invitation
          accept_invitation
          use_second_invitation
        end
        it "changes has_as_count by 2" do 
          expect{accept_invitation}.to change{has_as_count}.by(2)
        end
        it "changes relationships_count by 0" do 
          expect{accept_invitation}.to change{relationships_count}.by(0)
        end
        it "returns true" do 
          expect(accept_invitation).to eq(true)
        end
      end
    end

    context "after accepting the first invitation" do 
      before(:each) do
        use_first_invitation
        accept_invitation
        @relationship_invitation.reload
      end
      it "relationship invitation has status of 'accepted'" do 
        expect(@relationship_invitation.status).to eq('accepted')
      end
      it "foo's role list includes 'friend'" do 
        expect(foo.relationship_to(bar).first.role_list).to include('friend')
      end
      it "bar's role list includes 'friend'" do 
        expect(bar.relationship_to(foo).first.role_list).to include('friend')
      end

      context "after bar cancels the invitation" do 
        before(:each) do 
          bar.cancel_relationship_invitation(id: @relationship_invitation.id)
          @relationship_invitation.reload
        end
        context "after foo declines the invitation" do 
          before(:each) do 
            decline_invitation
            @relationship_invitation.reload
          end
          context "when accepting the invitation" do 
            it "changes has_as_count by 0" do 
              expect{accept_invitation}.to change{has_as_count}.by(0)
            end
            it "changes relationships_count by 0" do 
              expect{accept_invitation}.to change{relationships_count}.by(0)
            end
            it "returns true" do 
              expect(accept_invitation).to eq(true)
            end
          end
          context "after accepting the invitation" do 
            before(:each) do 
              accept_invitation
              @relationship_invitation.reload
            end
            it "relationship invitation has status of 'cancelled_accepted'" do 
              expect(@relationship_invitation.status).to eq('cancelled_accepted')
            end
          end
        end
      end

      context "when declining the first invitation" do 
        it "changes relationships_count by -2" do 
          expect{decline_invitation}.to change{relationships_count}.by(-2)
        end
      end
      context "after declining the first invitation" do 
        before(:each) do 
          use_first_invitation
          decline_invitation
          @relationship_invitation.reload
        end
        it "relationship invitation has status of 'declined'" do 
          expect(@relationship_invitation.status).to eq('declined')
        end
        context "when accepting the invitation" do 
          it "changes has_as_count by 2" do 
            expect{accept_invitation}.to change{has_as_count}.by(2)
          end
          it "changes relationships_count by 2" do 
            expect{accept_invitation}.to change{relationships_count}.by(2)
          end
        end 
        context "after accepting the invitation (again)" do 
          before(:each) do 
            accept_invitation
            @relationship_invitation.reload
          end 
          it "relationship invitation has status of 'accepted'" do 
            expect(@relationship_invitation.status).to eq('accepted')
          end
        end
      end

      context "after accepting the second invitation" do 
        before(:each) do 
          use_second_invitation
          accept_invitation
          use_second_invitation
        end
        it "foo's role list includes 'parent'" do 
          expect(foo.relationship_to(bar).first.role_list).to include('parent')
        end
        it "bar's role list includes 'child'" do 
          expect(bar.relationship_to(foo).first.role_list).to include('child')
        end
      end
    end

  end
end

def use_first_invitation
  @relationship_invitation = foo.received_relationship_invitations.first
end

def use_second_invitation
  @relationship_invitation = foo.received_relationship_invitations.last
end

def has_as_count
  ActsAsHaving::HasA.count
end

def relationships_count
  ActsAsRelatingTo::Relationship.count
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