require 'rails_helper'

RSpec.describe Series, :type => :model do
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

  it "should not allow duplicate names" do
    subject.save
    expect(Series.new(name: subject.name)).to_not be_valid
  end

  describe 'name_sort_value' do
    
    it 'should use name' do
      subject.name = 'Alien'
      expect(subject.sort_value).to eq 'alien'
    end

    it 'should remove preceding article a' do
      subject.name = 'A Series Title'
      expect(subject.sort_value).to eq 'series title'
    end

    it 'should remove preceding article an' do
      subject.name = 'An Other Series'
      expect(subject.sort_value).to eq 'other series'
    end

    it 'should remove preceding article the' do
      subject.name = 'The Avengers'
      expect(subject.sort_value).to eq 'avengers'
    end

  end
  
  describe "associations" do

    it { should have_many(:series_programs).without_validating_presence }

    it { should have_many(:programs).without_validating_presence }

    it "should reject series program without program set" do
      subject.update(series_programs_attributes:[{'program_id': ''}])
      expect(subject.programs).to be_empty
    end

  end

end