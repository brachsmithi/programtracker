require 'rails_helper'

RSpec.describe AlternateTitle, :type => :model do
  subject {
    described_class.new(name: "Xenomorph", program: create(:program))
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a program" do
    subject.program = nil
    expect(subject).to_not be_valid
  end
  
  describe 'title_sort_value' do

    it 'should remove preceding article a' do
      subject.name = 'A Certain Magical Index: The Movie - The Miracle of Endymion'
      expect(subject.title_sort_value).to eq 'certain magical index: the movie - the miracle of endymion'
    end

    it 'should remove preceding article an' do
      subject.name = 'An Ordinary Life'
      expect(subject.title_sort_value).to eq 'ordinary life'
    end

    it 'should remove preceding article the' do
      subject.name = 'The Bat'
      expect(subject.title_sort_value).to eq 'bat'
    end

  end
  
  describe "associations" do
    it { should belong_to(:program).without_validating_presence }
  end

end