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
  
  describe "associations" do
    it { should have_many(:discs).without_validating_presence }
    it { should have_many(:disc_packages).without_validating_presence }
    it "should reject disc package without disc set" do
      subject.update(disc_packages_attributes:[{'disc_id': ''}])
      expect(subject.discs).to be_empty
    end
  end

end