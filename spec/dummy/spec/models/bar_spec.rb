require 'rails_helper'

RSpec.describe Bar, type: :model do
  before(:each) do
    @foo = FactoryGirl.create('foo')
    @boo = FactoryGirl.create('foo')
    @bar = FactoryGirl.create('bar')
  end

  describe "foos_i_relate_to" do
    describe "when using the 'as' option" do
      before(:each) do
        @bar.relate_to @foo, as: 'friend'
      end
      it "bar responds_to 'foos_i_relate_to'" do
        expect(@bar.respond_to?('foos_i_relate_to')).to be_truthy
      end
      it "foo is a friend" do
        friendly_foos = @bar.foos_i_relate_to as: 'friend'
        expect(friendly_foos.include?(@foo)).to be_truthy
      end
    end
    describe "when not using the 'as' option" do
      before(:each) do
        @bar.relate_to @foo
      end
      it "i relate to foo" do
        expect(@bar.foos_i_relate_to.include?(@foo)).to be_truthy
      end
      it "foo is not a friend" do
        friendly_foos = @bar.foos_i_relate_to as: 'friend'
        expect(friendly_foos.include?(@foo)).to be_falsey
      end
      it "foo is not a foe" do
        friendly_foos = @bar.foos_i_relate_to as: 'foe'
        expect(friendly_foos.include?(@foo)).to be_falsey
      end
      it "bar responds_to 'foos_i_relate_to'" do
        expect(@bar.respond_to?('foos_i_relate_to')).to be_truthy
      end
    end
  end
  describe "boos_i_relate_to" do
    describe "when not using the 'as' option" do
      before(:each) do
        @bar.relate_to @boo
        @boo.relate_to @bar
      end
      it "bar responds_to 'boos_i_relate_to'" do
        expect(@bar.respond_to?(:boos_i_relate_to)).to be_truthy
      end
      it "i relate to boo" do
        expect(@bar.boos_i_relate_to.include?(@boo)).to be_truthy
      end
      it "@bar responds_to :boos_that_relate_to_me" do
        expect(@bar.respond_to?(:boos_that_relate_to_me)).to be_truthy
      end
      it "@bar.boos_that_relate_to_me includes @boo" do
        expect(@bar.boos_that_relate_to_me).to include(@boo)
      end
    end
  end
  describe "foos_that_relate_to_me" do
    describe "when using the 'as' option" do
      before(:each) do
        @foo.relate_to @bar, as: 'foe'
      end
      it "bar responds_to 'foos_that_relate_to_me'" do
        expect(@bar.respond_to?('foos_that_relate_to_me')).to be_truthy
      end
      it "foo relates to bar" do
        related_foos = @bar.foos_that_relate_to_me
        expect(related_foos.include?(@foo)).to be_truthy
      end
      it "foo does not see bar as a friend" do
        friendly_foos = @bar.foos_that_relate_to_me as: 'friend'
        expect(friendly_foos.include?(@foo)).to be_falsey
      end
      it "foo sees bar as a foe" do
        foe_foos = @bar.foos_that_relate_to_me as: 'foe'
        expect(foe_foos.include?(@foo)).to be_truthy
      end
    end
    describe "when not using the 'as' option" do
      before(:each) do
        @foo.relate_to @bar
      end
      it "foo relates to bar" do
        related_foos = @bar.foos_that_relate_to_me
        expect(related_foos.include?(@foo)).to be_truthy
      end
      it "foo does not see bar as a friend" do
        friendly_foos = @bar.foos_that_relate_to_me as: 'friend'
        expect(friendly_foos.include?(@foo)).to be_falsey
      end
      it "foo does not see bar as a foe" do
        foe_foos = @bar.foos_that_relate_to_me as: 'foe'
        expect(foe_foos.include?(@foo)).to be_falsey
      end

    end

  end
end
