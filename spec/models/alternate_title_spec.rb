require 'rails_helper'

RSpec.describe AlternateTitle, :type => :model do
  subject {
    described_class.new(name: "Xenomorph", program: create(:program))
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a program" do
    subject.program = nil
    expect(subject).to_not be_valid
  end
  
  describe "associations" do
    it { should belong_to(:program).without_validating_presence }
  end

end