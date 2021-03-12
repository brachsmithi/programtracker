require 'rails_helper'

RSpec.describe ProgramExport, :type => :service do

  it "should format simple program data for export" do
    program = Program.create! name: 'It! The Terror From Beyond Space', year: '1958', sort_name: 'It The Terror From Beyond Space'
    director = Person.create! name: 'Edward L. Cahn'
    program.persons << director

    expected = {
      program: [
        {
          director: [
            {
              name: 'Edward L. Cahn'
            }
          ],title: [
            'It! The Terror From Beyond Space'
          ],
          year: '1958',
          search_field: 'it the terror from beyond space  1958'
        }
      ]
    }

    writer = class_double('JsonWriter').as_stubbed_const
    expect(writer).to receive(:call).with({content: expected.as_json, file_name: 'programs.json'})

    ProgramExport.call()
  end

  it "should format multiple directors for export" do
    program = Program.create! name: 'Blood Simple', year: '1984'
    director1 = Person.create! name: 'Joel Coen'
    director2 = Person.create! name: 'Ethan Coen'
    program.persons << director1
    program.persons << director2

    expected = {
      program: [
        {
          director: [
            {
              name: 'Joel Coen'
            },
            {
              name: 'Ethan Coen'
            }
          ],title: [
            'Blood Simple'
          ],
          year: '1984',
          search_field: 'blood simple  1984'
        }
      ]
    }

    writer = class_double('JsonWriter').as_stubbed_const
    expect(writer).to receive(:call).with({content: expected.as_json, file_name: 'programs.json'})

    ProgramExport.call()
  end

  it "should format multiple title and director aliases for export" do
    program = Program.create! name: 'Planet of the Vampires', year: '1965'
    director = Person.create! name: 'Mario Bava'
    program.persons << director
    AlternateTitle.create! name: 'The Demon Planet', program: program
    AlternateTitle.create! name: 'Planet of Blood', program: program
    AlternateTitle.create! name: 'Space Mutants', program: program
    AlternateTitle.create! name: 'Terror in Space', program: program
    AlternateTitle.create! name: 'The Haunted Planet', program: program
    AlternateTitle.create! name: 'The Haunted World', program: program
    AlternateTitle.create! name: 'The Outlawed Planet', program: program
    AlternateTitle.create! name: 'The Planet of Terror', program: program
    AlternateTitle.create! name: 'The Planet of the Damned', program: program
    PersonAlias.create! name: 'John M. Old', person: director
    PersonAlias.create! name: 'Mickey Lion', person: director
    PersonAlias.create! name: 'John Hold', person: director

    expected = {
      program: [
        {
          director: [
            {
              name: 'Mario Bava',
              alias: [
                'John M. Old',
                'Mickey Lion',
                'John Hold'
              ]
            }
          ],
          title: [
            'Planet of the Vampires',
            'The Demon Planet',
            'Planet of Blood',
            'Space Mutants',
            'Terror in Space',
            'The Haunted Planet',
            'The Haunted World',
            'The Outlawed Planet',
            'The Planet of Terror',
            'The Planet of the Damned'
          ],
          year: '1965',
          search_field: 'planet of the vampires  1965 the demon planet planet of blood space mutants terror in space the haunted planet the haunted world the outlawed planet the planet of terror the planet of the damned'
        }
      ]
    }

    writer = class_double('JsonWriter').as_stubbed_const
    expect(writer).to receive(:call).with({content: expected.as_json, file_name: 'programs.json'})

    ProgramExport.call()
  end

end
