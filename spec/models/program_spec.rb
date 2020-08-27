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

  describe 'title_sort_value' do
    
    it 'should use sort_name' do
      subject.name = 'The Uncanny'
      subject.sort_name = 'Uncanny'
      expect(subject.title_sort_value).to eq 'uncanny'
    end

    it 'should use name when there is no sort_name' do
      subject.name = 'Bamboozled'
      subject.sort_name = ''
      expect(subject.title_sort_value).to eq 'bamboozled'
    end

  end

  describe 'search_name' do
    
    it 'should find matches against program name' do
      create(:program, name: 'All That Jazz')
      create(:program, name: 'The Apple')
      create(:program, name: 'Annie Hall')
      create(:program, name: 'The Ballad of Narayama')
      create(:program, name: 'Anything Goes')
      matches = Program.search_name 'all'
      expect(matches.count).to eq 3
      expect(matches[0].name).to eq 'All That Jazz'
      expect(matches[1].name).to eq 'Annie Hall'
      expect(matches[2].name).to eq 'The Ballad of Narayama'
    end

    it 'should also search agains alternates' do
      program = create(:program, name: 'Aelita: Queen of Mars')
      create(:alternate_title, name: 'Aelita: Revolt of the Robots', program_id: program.id)
      matches = Program.search_name 'robot'
      expect(matches.count).to eq 1
      expect(matches[0].name).to eq 'Aelita: Queen of Mars'
    end

  end

  describe 'duplicates' do 

    it 'should find programs that appear on multiple discs' do
      location = create(:default_location)

      program1 = create(:program, name: 'Night of the Living Dead')
      disc1 = create(:disc, format: 'DVD', location_id: location.id)
      create(:disc_program, disc_id: disc1.id, program_id: program1.id)
      disc2 = create(:disc, format: 'Blu-ray', location_id: location.id)
      create(:disc_program, disc_id: disc2.id, program_id: program1.id,)
      disc3 = create(:disc, format: 'DVD', location_id: location.id)
      create(:disc_program, disc_id: disc3.id, program_id: program1.id)

      program2 = create(:program, name: 'Planet Earth')
      disc4 = create(:disc, format: 'DVD', location_id: location.id)
      create(:disc_program, disc_id: disc4.id, program_id: program2.id)

      program3 = create(:program, name: 'Reefer Madness')
      disc5 = create(:disc, format: 'DVD', location_id: location.id)
      create(:disc_program, disc_id: disc5.id, program_id: program3.id)
      create(:disc_program, disc_id: disc3.id, program_id: program3.id)

      dupes = Program.duplicates

      expect(dupes.count.size).to eq 2
      expect(dupes[0].name).to eq 'Night of the Living Dead'
      expect(dupes[1].name).to eq 'Reefer Madness'
    end

  end
  
  describe 'associations' do
    it { should have_many(:directors).without_validating_presence }
    it { should have_many(:programs_directors).without_validating_presence }
    it { should have_many(:series).without_validating_presence }
    it { should have_many(:series_programs).without_validating_presence }
    it { should have_many(:discs).without_validating_presence }
    it { should have_many(:disc_programs).without_validating_presence }
    it { should have_many(:alternate_titles).without_validating_presence }

    it 'should reject series program without series set' do
      subject.update(series_programs_attributes:[{'series_id': ''}])
      expect(subject.series).to be_empty
    end

    it 'should reject program director without director set' do
      subject.update(programs_directors_attributes:[{'director_id': ''}])
      expect(subject.directors).to be_empty
    end

    it 'should reject alternate title without director set' do
      subject.update(alternate_titles_attributes:[{'name': ''}])
      expect(subject.alternate_titles).to be_empty
    end

  end

end