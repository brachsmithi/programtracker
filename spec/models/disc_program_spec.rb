require 'rails_helper'

RSpec.describe DiscProgram, :type => :model do
  subject {
    described_class.new(disc: create(:disc), program: create(:program), program_type: 'FEATURE')
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a disc" do
    subject.disc = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a program" do
    subject.program = nil
    expect(subject).to_not be_valid
  end

  DiscProgram::PROGRAM_TYPES.each do |pt|
    it "is valid with program type #{pt}" do
      subject.program_type = pt
      expect(subject).to be_valid
    end
  end

  it "is not valid with unknown program type" do
    subject.program_type = 'MEAL PROGRAM'
    expect(subject).to_not be_valid
  end
  
  describe "associations" do
    it { should belong_to(:disc).without_validating_presence }
    it { should belong_to(:program).without_validating_presence }
  end

end