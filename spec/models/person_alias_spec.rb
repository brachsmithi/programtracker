require 'rails_helper'

RSpec.describe PersonAlias, :type => :model do
  subject {
    described_class.new(person_id: create(:person).id, name: 'Alan Smithee')
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a person" do
    subject.person_id = nil
    expect(subject).to_not be_valid
  end
  
  describe "associations" do
    it { should belong_to(:person).without_validating_presence }
  end

end