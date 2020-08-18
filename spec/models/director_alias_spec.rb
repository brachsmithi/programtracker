require 'rails_helper'

RSpec.describe DirectorAlias, :type => :model do
  subject {
    described_class.new(director: create(:director), name: 'Alan Smithee')
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a director" do
    subject.director = nil
    expect(subject).to_not be_valid
  end
  
  describe "associations" do
    it { should belong_to(:director).without_validating_presence }
  end

end