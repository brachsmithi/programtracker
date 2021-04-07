require 'rails_helper'

RSpec.describe Package, :type => :model do
  subject {
    described_class.new(name: "Criterion Showa Godzilla")
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
    expect(Package.new(name: subject.name)).to_not be_valid
  end
  
  describe 'search_name' do
    
    it 'should find matches against package name' do
      create(:package, name: 'Atomic Age Classics')
      create(:package, name: 'Blade')
      create(:package, name: 'Bride of the Atom')
      create(:package, name: 'Trinity and Beyond: The Atomic Bomb Movie')
      create(:package, name: 'Ace in the Hole')
      matches = Package.search_name 'atom'
      expect(matches.count).to eq 3
      expect(matches[0].name).to eq 'Atomic Age Classics'
      expect(matches[1].name).to eq 'Bride of the Atom'
      expect(matches[2].name).to eq 'Trinity and Beyond: The Atomic Bomb Movie'
    end

    it 'should ignore entered capitals' do
      create(:package, name: 'Ninja Trilogy')

      matches = Package.search_name 'TRIL'
      expect(matches.count).to eq 1
      expect(matches.first.name).to eq 'Ninja Trilogy'
    end

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

  describe 'no_discs' do
    
    it 'should return packages that do not have disc package relationships' do
      create(:package, name: 'Blair Witch Collection')
      mm_pkg = create(:package, name: 'Midnight Movies')
      bl_pkg = create(:package, name: 'Bruce Lee Boxset')
      create(:package, name: 'Elvira Movie Set')
      location = create(:location, name: 'Col-13')
      create(:disc_package, disc_id: create(:disc, location_id: location.id).id, package_id: mm_pkg.id)
      create(:disc_package, disc_id: create(:disc, location_id: location.id).id, package_id: bl_pkg.id)

      empties = Package.no_discs

      expect(empties.count).to eq 2
      expect(empties[0].name).to eq 'Blair Witch Collection'
      expect(empties[1].name).to eq 'Elvira Movie Set'
    end

  end
  
  describe "associations" do
    it { should have_many(:discs).without_validating_presence }
    it { should have_many(:disc_packages).without_validating_presence }
    it { should have_many(:series).without_validating_presence }
    it { should have_many(:series_packages).without_validating_presence }
    it { should have_many(:wrapper_package_packages) }
    it { should have_many(:contained_package_packages) }
    it "should reject disc package without disc set" do
      subject.update(disc_packages_attributes:[{'disc_id': ''}])
      expect(subject.discs).to be_empty
    end
    it 'should reject series package without series set' do
      subject.update(series_packages_attributes:[{'series_id': ''}])
      expect(subject.series).to be_empty
    end

    it 'should allow deletion of contained package packages' do
      subject.name = 'Wrapper'
      subject.save
      cpp = PackagePackage.create!(wrapper_package: subject, contained_package: create(:package))
      subject.update(contained_package_packages_attributes:{id: cpp.id, _destroy: true})
      expect(subject.contained_package_packages).to be_empty
    end
  end

end