require 'rails_helper'

RSpec.describe SeriesProgram, :type => :model do
  subject {
    described_class.new(series: create(:series), program: create(:program))
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a series" do
    subject.series = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a program" do
    subject.program = nil
    expect(subject).to_not be_valid
  end
  
  describe "associations" do
    it { should belong_to(:series).without_validating_presence }
    it { should belong_to(:program).without_validating_presence }
  end

end