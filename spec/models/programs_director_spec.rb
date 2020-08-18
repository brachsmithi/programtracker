require 'rails_helper'

RSpec.describe ProgramsDirector, :type => :model do
  subject {
    dir = create(:director)
    described_class.new(director: dir, program: create(:program))
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a director" do
    subject.director = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a program" do
    subject.program = nil
    expect(subject).to_not be_valid
  end
  
  describe "associations" do
    it { should belong_to(:director).without_validating_presence }
    it { should belong_to(:program).without_validating_presence }
  end

end