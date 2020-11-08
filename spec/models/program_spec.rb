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

  describe 'duplicates' do 

    it 'should find programs that appear on multiple discs' do
      location = create(:location)

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

  describe 'unused' do 
    
    it 'should find programs that are not on any discs' do
      location = create(:location)

      create(:program, name: 'Cave of the Silken Web', year: '1927')

      program = create(:program, name: 'Reefer Madness')
      disc = create(:disc, format: 'DVD', location_id: location.id)
      create(:disc_program, disc_id: disc.id, program_id: program.id)

      create(:program, name: 'The New Mutants', year: '2020')
      
      dupes = Program.unused
      
      expect(dupes.count).to eq 2
      expect(dupes[0].name).to eq 'Cave of the Silken Web'
      expect(dupes[1].name).to eq 'The New Mutants'
    end

  end
  
  describe 'associations' do
    it { should belong_to(:program_version_cluster).without_validating_presence }
    it { should have_many(:persons).without_validating_presence }
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

    it 'should reject program person without person set' do
      subject.update(programs_directors_attributes:[{'person_id': ''}])
      expect(subject.persons).to be_empty
    end

    it 'should reject alternate title without person set' do
      subject.update(alternate_titles_attributes:[{'name': ''}])
      expect(subject.alternate_titles).to be_empty
    end

  end

end