require 'rails_helper'

RSpec.describe Director, :type => :model do
  subject {
    described_class.new(name: "Alan Smithee")
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
    expect(Director.new(name: subject.name)).to_not be_valid
  end

  it "should present a default director" do
    create(:default_director)
    expect(Director.default).to_not be_nil
  end
  
  describe "associations" do
    it { should have_many(:programs_directors).without_validating_presence }
    it { should have_many(:programs).without_validating_presence }
    it { should have_many(:director_aliases).without_validating_presence }
  end

end