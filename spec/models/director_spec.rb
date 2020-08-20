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

  describe 'first_name_sort_value' do
    
    it 'should sort by first part of name' do
      subject.name = 'Takashi Miike'
      expect(subject.first_name_sort_value).to eq 'takashi'
    end

  end

  describe 'last_name_sort_value' do
    
    it 'should sort by last part of name' do
      subject.name = 'Francis Ford Coppola'
      expect(subject.last_name_sort_value).to eq 'coppola'
    end

  end
  
  describe "associations" do
    it { should have_many(:programs_directors).without_validating_presence }
    it { should have_many(:programs).without_validating_presence }
    it { should have_many(:director_aliases).without_validating_presence }
    it { should accept_nested_attributes_for(:director_aliases) }
    it "should reject director aliases without program set" do
      subject.update(director_aliases_attributes:[{'name': ''}])
      expect(subject.director_aliases).to be_empty
    end
  end

end