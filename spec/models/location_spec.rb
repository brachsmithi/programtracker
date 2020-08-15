require 'rails_helper'

RSpec.describe Location, :type => :model do
  subject {
    described_class.new(name: "A-2")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "should not allow duplicate names" do
    subject.save
    expect(Location.new(name: subject.name)).to_not be_valid
  end
  
  describe "associations" do
    it { should have_many(:discs).without_validating_presence }
  end

end