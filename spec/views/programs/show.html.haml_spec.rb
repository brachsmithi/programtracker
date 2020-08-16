require 'rails_helper'

RSpec.describe "programs/show.html.haml", type: :view do
  
  before(:each) do
    director = Director.create(name: 'John Landis')
    program = create(:program, name: 'An American Werewolf in London', sort_name: 'American Werewolf in London', year: '1981', directors: [director])
    assign(:program, program)
  end

  it "should display program data" do
    
    render

    expect(rendered).to match /An American Werewolf in London/
    expect(rendered).to match /1981/
    expect(rendered).to match /John Landis/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /Programs/
  end

end
