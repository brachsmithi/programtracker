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

    package = nil

    before(:each) do
      package = Package.create!({
        name: 'Deck of Many Things'
      })
    end

    it 'should use name of package' do
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

    package = nil

    before(:each) do
      package = Package.create!({
        name: 'Deck of Many Things'
      })
    end

    it 'should use name of package' do
      expect(PackagesSearch.search_by_name('many')[0].package).to eq package
    end

    it 'should search by discs when present' do
      location = create(:location, name: 'Somewhere Over the Rainbow')
      d = create(:disc, location: location)
      prog = create(:program, name: 'Fred and Ethel')
      create(:disc_program, program_id: prog.id, disc_id: d.id)
      create(:disc_package, package_id: package.id, disc_id: d.id)
      
      expect(PackagesSearch.search_by_name('red')[0].package).to eq package
    end

  end

end