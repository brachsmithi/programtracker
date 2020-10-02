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
  
  describe 'search_name' do
    
    it 'should find matches against series name' do
      create(:series, name: 'Creepshow')
      create(:series, name: 'Blade')
      create(:series, name: 'Dreamland Massacre')
      create(:series, name: 'The 100 Acre Woods')
      create(:series, name: 'The Chronicles of Riddick')
      matches = Series.search_name 'cre'
      expect(matches.count).to eq 3
      expect(matches[0].name).to eq 'Creepshow'
      expect(matches[1].name).to eq 'Dreamland Massacre'
      expect(matches[2].name).to eq 'The 100 Acre Woods'
    end

    it 'should ignore entered capitals' do
      create(:series, name: 'Futurama')

      matches = Series.search_name 'FUTU'
      expect(matches.count).to eq 1
      expect(matches.first.name).to eq 'Futurama'
    end

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

    it { should have_many(:series_programs) }

    it { should have_many(:series_discs) }

    it { should have_many(:wrapper_series_series) }

    it { should have_many(:contained_series_series) }

    it { should have_many(:programs) }

    it { should accept_nested_attributes_for(:contained_series_series) }

    it { should accept_nested_attributes_for(:series_programs) }

    it { should accept_nested_attributes_for(:series_discs) }

    it 'should allow deletion of series program' do
      subject.save
      sp = SeriesProgram.create!(series: subject, program: create(:program))
      subject.update(series_programs_attributes:{id: sp.id, _destroy: true})
      expect(subject.series_programs).to be_empty
    end

    it 'should allow deletion of series disc' do
      subject.save
      ds = SeriesDisc.create!(series: subject, disc: create(:disc))
      subject.update(series_discs_attributes:{id: ds.id, _destroy: true})
      expect(subject.series_discs).to be_empty
    end

    it 'should allow deletion of contained series series' do
      subject.name = 'Wrapper'
      subject.save
      css = SeriesSeries.create!(wrapper_series: subject, contained_series: create(:series))
      subject.update(contained_series_series_attributes:{id: css.id, _destroy: true})
      expect(subject.contained_series_series).to be_empty
    end

  end

end