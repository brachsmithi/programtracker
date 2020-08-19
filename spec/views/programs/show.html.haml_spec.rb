require 'rails_helper'

RSpec.describe "programs/show.html.haml", type: :view do
  
  before(:each) do
    director = Director.create(name: 'John Landis')
    series = Series.create(name: 'American Werewolf Movies')
    alternate = AlternateTitle.create(name: 'American Werewolf I')
    program = create(:program, name: 'An American Werewolf in London', sort_name: 'Amer Werewolf in London', year: '1981', version: 'Theatrical', minutes: 90, directors: [director], series: [series], alternate_titles: [alternate])
    assign(:program, program)
  end

  it "should display program data" do
    
    render

    expect(rendered).to match /An American Werewolf in London/
    expect(rendered).to match /1981/
    expect(rendered).to match /Theatrical/
    expect(rendered).to match /90/
    expect(rendered).to match /John Landis/
    expect(rendered).to match /American Werewolf Movies/
    expect(rendered).to match /American Werewolf I/
    expect(rendered).to match /Amer Werewolf in London/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /Title/
    expect(rendered).to match /Alternate Titles/
    expect(rendered).to match /Sort Title/
    expect(rendered).to match /Directors/
    expect(rendered).to match /Version/
    expect(rendered).to match /Year/
    expect(rendered).to match /Length/
    expect(rendered).to match /Series/
    expect(rendered).to match /Programs/
  end

end
