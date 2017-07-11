require 'rails_helper'

RSpec.describe RoleLoader do
  before(:all) do
    @method_name = "load_all"
  end
  describe "#load_all" do
    it "responds" do
      expect(described_class.respond_to?(@method_name)).to be_truthy
    end
    it "does something" do
      described_class.send(@method_name)
    end
  end
end