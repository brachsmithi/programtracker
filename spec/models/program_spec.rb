require 'rails_helper'

RSpec.describe Program, :type => :model do
  subject {
    described_class.new(name: "Alien")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "sets a default director if none is provided" do
    create(:default_director)
    subject.save
    expect(subject.directors).to include Director.default
  end
  
  describe "associations" do
    it { should have_many(:directors).without_validating_presence }
    it { should have_many(:programs_directors).without_validating_presence }
    it { should have_many(:series).without_validating_presence }
    it { should have_many(:series_programs).without_validating_presence }
    it { should have_many(:discs).without_validating_presence }
    it { should have_many(:disc_programs).without_validating_presence }
    it { should have_many(:alternate_titles).without_validating_presence }

    it "should reject series program without series set" do
      create(:default_director)
      subject.update(series_programs_attributes:[{'series_id': ''}])
      expect(subject.series).to be_empty
    end
  end

end