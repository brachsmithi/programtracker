require 'rails_helper'

RSpec.describe PackagesSearch, :type => :model do

  describe 'find' do
    it 'should provide a package' do
      pkg = Package.create!({
        name: 'Collection of Discs'
      })
      ps = PackagesSearch.find pkg.id
      expect(ps.package).to eq pkg
    end
  end

  describe 'sort_title' do

    it 'should use name of package' do
      package = create(:package, name: 'Deck of Many Things')
      ps = PackagesSearch.find(package.id)
      expect(ps.sort_title).to eq 'deck of many things'
    end

  end

  describe 'sort_title' do
    
    it 'should strip preceding article ''a''' do
      pkg = create(:package, name: 'A New Hope')

      expect(PackagesSearch.find(pkg.id).sort_title).to eq 'new hope'
    end

    it 'should strip preceding article ''an''' do
      pkg = create(:package, name: 'An Evening With Edgar Allan Poe')

      expect(PackagesSearch.find(pkg.id).sort_title).to eq 'evening with edgar allan poe'
    end

    it 'should strip preceding article ''the''' do
      pkg = create(:package, name: 'The Loved One')

      expect(PackagesSearch.find(pkg.id).sort_title).to eq 'loved one'
    end

  end

  describe 'search_by_name' do

    def create_package
      create(:package, name: 'Deck of Many Things')
    end

    it 'should use name of package' do
      package = create_package
      expect(PackagesSearch.search_by_name('many')[0].package).to eq package
    end

    it 'should search by discs when present' do
      package = create_package
      location = create(:location, name: 'Somewhere Over the Rainbow')
      d = create(:disc, location: location)
      prog = create(:program, name: 'Fred and Ethel')
      create(:disc_program, program_id: prog.id, disc_id: d.id)
      create(:disc_package, package_id: package.id, disc_id: d.id)
      
      expect(PackagesSearch.search_by_name('red')[0].package).to eq package
    end

  end

  describe 'with_no_discs' do

    it 'should return packages that do not have discs' do
      create(:package, name: 'Package One')
      pkg = create(:package, name: 'Package II')
      create(:package, name: 'Package Three')

      create(:disc_package, package_id: pkg.id, disc_id: create(:disc, name: 'Content').id)

      result = PackagesSearch.with_no_discs

      expect(result.count).to eq 2
      expect(result[0].name).to eq 'Package One'
      expect(result[1].name).to eq 'Package Three'
    end

  end

end