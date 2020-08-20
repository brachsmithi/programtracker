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

  describe 'sort_title' do
    
    it 'should use sort_name' do
      subject.name = 'The Uncanny'
      subject.sort_name = 'Uncanny'
      expect(subject.sort_title).to eq 'uncanny'
    end

    it 'should use name when there is no sort_name' do
      subject.name = 'Bamboozled'
      subject.sort_name = ''
      expect(subject.sort_title).to eq 'bamboozled'
    end

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
      subject.update(series_programs_attributes:[{'series_id': ''}])
      expect(subject.series).to be_empty
    end

    it "should reject program director without director set" do
      subject.update(programs_directors_attributes:[{'director_id': ''}])
      expect(subject.directors).to be_empty
    end
  end

end