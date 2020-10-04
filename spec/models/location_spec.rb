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
  
  describe 'search_name' do
    
    it 'should find matches against location name' do
      create(:location, name: 'A-1')
      create(:location, name: 'B-1')
      create(:location, name: 'B-2')
      create(:location, name: 'Shelf A')
      create(:location, name: 'Box T')
      matches = Location.search_name 'b'
      expect(matches.count).to eq 3
      expect(matches[0].name).to eq 'B-1'
      expect(matches[1].name).to eq 'B-2'
      expect(matches[2].name).to eq 'Box T'
    end

    it 'should ignore entered capitals' do
      create(:location, name: 'Under the TV')

      matches = Location.search_name 'UNDER'
      expect(matches.count).to eq 1
      expect(matches.first.name).to eq 'Under the TV'
    end

    it 'should not include default location' do
      create(:location)

      matches = Location.search_name 'set'
      expect(matches).to be_empty
    end

  end

end