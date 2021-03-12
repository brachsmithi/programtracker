require 'rails_helper'

RSpec.describe ProgramExport, :type => :service do

  it "should format program data for export" do
    program = Program.create! name: 'It! The Terror From Beyond Space', year: '1958', sort_name: 'It The Terror From Beyond Space'
    director = Person.create! name: 'Edward L. Cahn'
    program.persons << director

    expected = [
      {
        title: [
          'It! The Terror From Beyond Space'
        ],
        year: '1958',
        search_field: 'It The Terror From Beyond Space'
      }
    ]

    writer = class_double('JsonWriter').as_stubbed_const
    expect(writer).to receive(:call).with({content: expected.as_json, file_name: 'programs.json'})

    ProgramExport.call()
  end

end


# director: [
#   {
#     name: "Edward L. Cahn"
#   }
# ],