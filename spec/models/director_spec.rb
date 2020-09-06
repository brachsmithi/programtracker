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
      expect(subject.first_name_sort_value).to eq 'takashi miike'
    end

  end

  describe 'last_name_sort_value' do
    
    it 'should sort by last part of name' do
      subject.name = 'Francis Ford Coppola'
      expect(subject.last_name_sort_value).to eq 'coppola'
    end

    it 'should include Le' do
      subject.name = 'Reginald Le Borg'
      expect(subject.last_name_sort_value).to eq 'le borg'
    end

    it 'should include Del' do
      subject.name = 'Peter Del Monte'
      expect(subject.last_name_sort_value).to eq 'del monte'
    end

    it 'should include De' do
      subject.name = 'Giuseppe De Santis'
      expect(subject.last_name_sort_value).to eq 'de santis'
    end

    it 'should include von' do
      subject.name = 'Josef von Sternberg'
      expect(subject.last_name_sort_value).to eq 'von sternberg'
    end

    it 'should handle one name directors' do
      subject.name = 'McG'
      expect(subject.last_name_sort_value).to eq 'mcg'
    end

    it 'should include van den' do
      subject.name = 'Rudolf van den Berg'
      expect(subject.last_name_sort_value).to eq 'van den berg'
    end

  end

  describe 'search_name' do
    
    it 'should find matches against director name' do
      create(:director, name: 'Jane Campion')
      create(:director, name: 'W.D. Richter')
      create(:director, name: 'Ishiro Honda')
      create(:director, name: 'Eric Bress')
      create(:director, name: 'Richard Dreyfus')
      matches = Director.search_name 'ric'
      expect(matches.count).to eq 3
      expect(matches[0].name).to eq 'Eric Bress'
      expect(matches[1].name).to eq 'Richard Dreyfus'
      expect(matches[2].name).to eq 'W.D. Richter'
    end

    it 'should also search agains aliases' do
      director = create(:director, name: 'Jesus Franco')
      create(:director_alias, name: 'Jess Franco', director_id: director.id)
      matches = Director.search_name 'jess'
      expect(matches.count).to eq 1
      expect(matches[0].name).to eq 'Jesus Franco'
    end

    it 'should only return one record for director with aliases' do 
      director1 = create(:director, name: 'Jesus Franco')
      create(:director_alias, name: 'Jess Franco', director_id: director1.id)
      create(:director_alias, name: 'J. Franco', director_id: director1.id)
      director2 = create(:director, name: 'Jessica Yu')
      create(:director_alias, name: 'J. Yu', director_id: director2.id)
      create(:director_alias, name: 'Jess Yu', director_id: director2.id)

      matches = Director.search_name 'jess'
      expect(matches.count).to eq 2
      expect(matches[0].name).to eq 'Jesus Franco'
      expect(matches[1].name).to eq 'Jessica Yu'
    end

    it 'should sort search results by last name' do
      create(:director, name: 'Woody Allen')
      create(:director, name: 'Anthony Waller')
      create(:director, name: 'Irwin Allen')
      create(:director, name: 'Daniel Haller')
      create(:director, name: 'Louis Malle')

      matches = Director.search_name 'alle'
      expect(matches.count).to eq 5
      expect(matches[0].name).to eq 'Irwin Allen'
      expect(matches[1].name).to eq 'Woody Allen'
      expect(matches[2].name).to eq 'Daniel Haller'
      expect(matches[3].name).to eq 'Louis Malle'
      expect(matches[4].name).to eq 'Anthony Waller'
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