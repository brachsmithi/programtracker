require 'rails_helper'

RSpec.describe Person, :type => :model do
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
    expect(Person.new(name: subject.name)).to_not be_valid
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

    it 'should handle one name persons' do
      subject.name = 'McG'
      expect(subject.last_name_sort_value).to eq 'mcg'
    end

    it 'should include van den' do
      subject.name = 'Rudolf van den Berg'
      expect(subject.last_name_sort_value).to eq 'van den berg'
    end

  end

  describe 'search_name' do
    
    it 'should find matches against person name' do
      create(:person, name: 'Jane Campion')
      create(:person, name: 'W.D. Richter')
      create(:person, name: 'Ishiro Honda')
      create(:person, name: 'Eric Bress')
      create(:person, name: 'Richard Dreyfus')
      matches = Person.search_name 'ric'
      expect(matches.count).to eq 3
      expect(matches[0].name).to eq 'Eric Bress'
      expect(matches[1].name).to eq 'Richard Dreyfus'
      expect(matches[2].name).to eq 'W.D. Richter'
    end

    it 'should also search agains aliases' do
      person = create(:person, name: 'Jesus Franco')
      create(:person_alias, name: 'Jess Franco', person_id: person.id)
      matches = Person.search_name 'jess'
      expect(matches.count).to eq 1
      expect(matches[0].name).to eq 'Jesus Franco'
    end

    it 'should only return one record for person with aliases' do 
      person1 = create(:person, name: 'Jesus Franco')
      create(:person_alias, name: 'Jess Franco', person_id: person1.id)
      create(:person_alias, name: 'J. Franco', person_id: person1.id)
      person2 = create(:person, name: 'Jessica Yu')
      create(:person_alias, name: 'J. Yu', person_id: person2.id)
      create(:person_alias, name: 'Jess Yu', person_id: person2.id)

      matches = Person.search_name 'jess'
      expect(matches.count).to eq 2
      expect(matches[0].name).to eq 'Jesus Franco'
      expect(matches[1].name).to eq 'Jessica Yu'
    end

    it 'should sort search results by last name' do
      create(:person, name: 'Woody Allen')
      create(:person, name: 'Anthony Waller')
      create(:person, name: 'Irwin Allen')
      create(:person, name: 'Daniel Haller')
      create(:person, name: 'Louis Malle')

      matches = Person.search_name 'alle'
      expect(matches.count).to eq 5
      expect(matches[0].name).to eq 'Irwin Allen'
      expect(matches[1].name).to eq 'Woody Allen'
      expect(matches[2].name).to eq 'Daniel Haller'
      expect(matches[3].name).to eq 'Louis Malle'
      expect(matches[4].name).to eq 'Anthony Waller'
    end

    it 'should ignore entered capitals' do
      create(:person, name: 'Alice Guy')

      matches = Person.search_name 'ALICE'
      expect(matches.count).to eq 1
      expect(matches.first.name).to eq 'Alice Guy'
    end

  end
  
  describe "associations" do
    it { should have_many(:program_persons).without_validating_presence }
    it { should have_many(:programs).without_validating_presence }
    it { should have_many(:person_aliases).without_validating_presence }
    it { should accept_nested_attributes_for(:person_aliases) }
    it "should reject person aliases without program set" do
      subject.update(person_aliases_attributes:[{'name': ''}])
      expect(subject.person_aliases).to be_empty
    end
  end

end