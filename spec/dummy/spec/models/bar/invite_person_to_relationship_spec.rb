require 'rails_helper'

RSpec.describe Bar do
  before(:all) do 
    AppCollaborators::Loader.load 'test'
    RoleLoader.load_all
  end
  it "responds" do 
    expect(bar.respond_to?(:invite_person_to_relationship)).to be_truthy
  end

  context "when bar is sending foo an relationship invitation "+"without".red+" a role name specified" do 
    context "when sending request the first time" do 
      it "returns true" do 
        bar.invite_person_to_relationship(foo).tap do |returned|
          expect(returned).to be_truthy
        end
      end
      it "creates a new relationship invitation" do 
        expect{bar.invite_person_to_relationship(foo)}.to change{ActsAsRelatingTo::RelationshipInvitation.count}.by(1)
      end
      it "foo is invited as a friend" do 
        bar.invite_person_to_relationship(foo)
        bar.sent_relationship_invitations.first.tap do |r|
          expect(r).to be_a_kind_of(ActsAsRelatingTo::RelationshipInvitation)
          r.role.tap do |role|
            expect(role).to be_a_kind_of(ActsAsRelatingTo::Role)
            expect(role.name).to eq("friend")
          end
        end
      end
    end
    context "when sending request the second time" do 
      before(:each) do 
        bar.invite_person_to_relationship(foo)
      end
      it "returns true" do 
        bar.invite_person_to_relationship(foo).tap do |returned|
          expect(returned).to be_truthy
        end
      end
      it "does "+"NOT".red+" create a new relationship invitation".green do 
        expect{bar.invite_person_to_relationship(foo)}.to change{ActsAsRelatingTo::RelationshipInvitation.count}.by(0)
      end
    end
  end

  context "when bar is sending foo an relationship invitation "+"with".blue+" a role name specified" do 
    context "as 'friend' (as a String)" do 
      it "creates a new relationship invitation" do 
        expect{bar.invite_person_to_relationship(foo, as: 'friend')}.to change{ActsAsRelatingTo::RelationshipInvitation.count}.by(1)
      end
      it "foo is invited as a friend" do 
        bar.invite_person_to_relationship(foo)
        bar.sent_relationship_invitations.first.tap do |r|
          expect(r).to be_a_kind_of(ActsAsRelatingTo::RelationshipInvitation)
          r.role.tap do |role|
            expect(role).to be_a_kind_of(ActsAsRelatingTo::Role)
            expect(role.name).to eq("friend")
          end
        end
      end
    end
    context "as 'friend friend' (as a String)" do 
      it "creates a new relationship invitation" do 
        expect{bar.invite_person_to_relationship(foo, as: 'friend friend')}.to change{ActsAsRelatingTo::RelationshipInvitation.count}.by(1)
      end
      it "foo is invited as a friend" do 
        bar.invite_person_to_relationship(foo)
        bar.sent_relationship_invitations.first.tap do |r|
          expect(r).to be_a_kind_of(ActsAsRelatingTo::RelationshipInvitation)
          r.role.tap do |role|
            expect(role).to be_a_kind_of(ActsAsRelatingTo::Role)
            expect(role.name).to eq("friend")
          end
        end
      end
    end
    context "as ['friend'] (in an Array)" do 
      it "creates a new relationship invitation" do 
        expect{bar.invite_person_to_relationship(foo, as: ['friend'])}.to change{ActsAsRelatingTo::RelationshipInvitation.count}.by(1)
      end
      it "foo is invited as a friend" do 
        bar.invite_person_to_relationship(foo)
        bar.sent_relationship_invitations.first.tap do |r|
          expect(r).to be_a_kind_of(ActsAsRelatingTo::RelationshipInvitation)
          r.role.tap do |role|
            expect(role).to be_a_kind_of(ActsAsRelatingTo::Role)
            expect(role.name).to eq("friend")
          end
        end
      end
    end
    context "as ['friend','friend'] (in an Array)" do 
      it "creates a new relationship invitation" do 
        expect{bar.invite_person_to_relationship(foo, as: ['friend','friend'])}.to change{ActsAsRelatingTo::RelationshipInvitation.count}.by(1)
      end
      it "foo is invited as a friend" do 
        bar.invite_person_to_relationship(foo)
        bar.sent_relationship_invitations.first.tap do |r|
          expect(r).to be_a_kind_of(ActsAsRelatingTo::RelationshipInvitation)
          r.role.tap do |role|
            expect(role).to be_a_kind_of(ActsAsRelatingTo::Role)
            expect(role.name).to eq("friend")
          end
        end
      end
    end
    context "as ['friend','mentor'] (in an Array)" do 
      it "creates a new relationship invitation" do 
        expect{bar.invite_person_to_relationship(foo, as: ['friend','mentor'])}.to change{ActsAsRelatingTo::RelationshipInvitation.count}.by(1)
      end
      it "foo is invited as a friend" do 
        bar.invite_person_to_relationship(foo)
        bar.sent_relationship_invitations.first.tap do |r|
          expect(r).to be_a_kind_of(ActsAsRelatingTo::RelationshipInvitation)
          r.role.tap do |role|
            expect(role).to be_a_kind_of(ActsAsRelatingTo::Role)
            expect(role.name).to eq("friend")
          end
        end
      end
    end
    context "as 'mentor' (as a String)" do 
      it "does "+"NOT".red+" create a new relationship invitation".green do 
        expect{bar.invite_person_to_relationship(foo, as: "mentor")}.to change{ActsAsRelatingTo::RelationshipInvitation.count}.by(0)
      end
    end
    context "as ['mentor'] (in an Array)" do 
      it "does "+"NOT".red+" create a new relationship invitation".green do 
        expect{bar.invite_person_to_relationship(foo, as: "mentor")}.to change{ActsAsRelatingTo::RelationshipInvitation.count}.by(0)
      end
    end

  end

end

def foo() @foo ||= create_foo end

def create_foo
  Foo.create
end

def bar() @bar ||= create_bar end

def create_bar
  Bar.create
end