require 'rails_helper'

RSpec.describe "alternate_titles/edit.html.haml", type: :view do

  before(:each) do
    program = create(:program, name: 'Night of the Living Dead')
    alternate_title = create(:alternate_title, name: 'Night of Anubis', program_id: program.id)
    assign(:alternate_title, alternate_title)
  end

  it 'displays the alternate title form' do

    render

    expect(rendered).to match /Name/
    expect(rendered).to match /Night of Anubis/
    expect(rendered).to match /Night of the Living Dead/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /Edit Alternate Title/
    expect(rendered).to match /Update/
    expect(rendered).to match /Cancel/
  end

end
