require 'rails_helper'

RSpec.describe DiscPackage, :type => :model do
  subject {
    described_class.new(disc: create(:disc), package: create(:package))
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a disc" do
    subject.disc = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a package" do
    subject.package = nil
    expect(subject).to_not be_valid
  end
  
  describe "associations" do
    it { should belong_to(:disc).without_validating_presence }
    it { should belong_to(:package).without_validating_presence }
  end

end