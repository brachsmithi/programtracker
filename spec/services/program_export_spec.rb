require 'rails_helper'

RSpec.describe ProgramExport, :type => :service do

  it "should format simple program data for export" do
    program = Program.create! name: 'It! The Terror From Beyond Space', year: '1958', sort_name: 'It The Terror From Beyond Space', version: 'Full Screen'
    director = Person.create! name: 'Edward L. Cahn'
    program.persons << director

    expected = {
      meta: {
        version: '1.0'
      },
      program: [
        {
          director: [
            {
              name: 'Edward L. Cahn'
            }
          ],
          sort_title: "it the terror from beyond space 1958",
          title: [
            'It! The Terror From Beyond Space'
          ],
          year: '1958',
          version: 'Full Screen',
          search_field: 'it! the terror from beyond space it the terror from beyond space 1958'
        }
      ]
    }

    writer = class_double('JsonWriter').as_stubbed_const
    expect(writer).to receive(:call).with({content: expected.as_json, file_name: 'programs.json'})

    ProgramExport.call
  end

  it "should format multiple directors for export" do
    program = Program.create! name: 'Blood Simple', year: '1984'
    director1 = Person.create! name: 'Joel Coen'
    director2 = Person.create! name: 'Ethan Coen'
    program.persons << director1
    program.persons << director2

    expected = {
      meta: {
        version: '1.0'
      },
      program: [
        {
          director: [
            {
              name: 'Joel Coen'
            },
            {
              name: 'Ethan Coen'
            }
          ],
          sort_title: 'blood simple 1984',
          title: [
            'Blood Simple'
          ],
          year: '1984',
          search_field: 'blood simple 1984'
        }
      ]
    }

    writer = class_double('JsonWriter').as_stubbed_const
    expect(writer).to receive(:call).with({content: expected.as_json, file_name: 'programs.json'})

    ProgramExport.call
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
      meta: {
        version: '1.0'
      },
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
          sort_title: 'planet of the vampires 1965',
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
          search_field: 'planet of the vampires 1965 the demon planet planet of blood space mutants terror in space the haunted planet the haunted world the outlawed planet the planet of terror the planet of the damned'
        }
      ]
    }

    writer = class_double('JsonWriter').as_stubbed_const
    expect(writer).to receive(:call).with({content: expected.as_json, file_name: 'programs.json'})

    ProgramExport.call
  end

  it "should format discs without programs for export" do
    location = create(:location, name: 'COL-3')
    create(:disc, name: 'Trailer Trauma 2: Drive-In Monsterama', format: 'Blu-ray', state: 'FILED', location: location)
    disc_to_skip = create(:disc, name: 'Ray Harryhausen''s Fairy Tales', format: 'DVD', state: 'FILED', location: location)
    director = create(:person, name: 'Ray Harryhausen')
    program1 = create(:program, name: 'The Storybook Review', sort_name: 'Storybook Review', year: '1946', minutes: 11, version: nil)
    create(:program_person, program_id: program1.id, person_id: director.id)
    create(:disc_program, disc_id: disc_to_skip.id, program_id: program1.id, sequence: 1)
    program2 = create(:program, name: 'The Story of ''Little Red Riding Hood''', sort_name: 'Story of Little Red Riding Hood', year: '1949', minutes: 9, version: nil)
    create(:program_person, program_id: program2.id, person_id: director.id)
    create(:disc_program, disc_id: disc_to_skip.id, program_id: program2.id, sequence: 2)
    program3 = create(:program, name: 'The Story of ''Hansel and Gretel''', sort_name: 'Story of Hansel and Gretel', year: 1951, minutes: 10, version: nil)
    create(:program_person, program_id: program3.id, person_id: director.id)
    create(:disc_program, disc_id: disc_to_skip.id, program_id: program3.id, sequence: 3)
    program4 = create(:program, name: 'The Story of ''Rapunzel''', sort_name: 'Story of Rapunzel', year: '1951', minutes: 11, version: nil)
    create(:program_person, program_id: program4.id, person_id: director.id)
    create(:disc_program, disc_id: disc_to_skip.id, program_id: program4.id, sequence: 4)
    program5 = create(:program, name: 'The Story of King Midas', sort_name: 'Story of King Midas', year: '1953', minutes: 10, version: nil)
    create(:program_person, program_id: program5.id, person_id: director.id)
    create(:disc_program, disc_id: disc_to_skip.id, program_id: program5.id, sequence: 5)

    expected = {
      meta: {
        version: '1.0'
      },
      program: [
        {
          director: [
            {
              name: 'Ray Harryhausen'
            }
          ],
          sort_title: 'story of hansel and gretel 1951',
          title: [
            'The Story of ''Hansel and Gretel'''
          ],
          year: '1951',
          search_field: 'the story of hansel and gretel story of hansel and gretel 1951 ray harryhausen''s fairy tales'
        },
        {
          director: [
            {
              name: 'Ray Harryhausen'
            }
          ],
          sort_title: 'story of king midas 1953',
          title: [
            'The Story of King Midas'
          ],
          year: '1953',
          search_field: 'the story of king midas story of king midas 1953 ray harryhausen''s fairy tales'
        },
        {
          director: [
            {
              name: 'Ray Harryhausen'
            }
          ],
          sort_title: 'story of little red riding hood 1949',
          title: [
            'The Story of ''Little Red Riding Hood'''
          ],
          year: '1949',
          search_field: 'the story of little red riding hood story of little red riding hood 1949 ray harryhausen''s fairy tales'
        },
        {
          director: [
            {
              name: 'Ray Harryhausen'
            }
          ],
          sort_title: 'story of rapunzel 1951',
          title: [
            'The Story of ''Rapunzel'''
          ],
          year: '1951',
          search_field: 'the story of rapunzel story of rapunzel 1951 ray harryhausen''s fairy tales'
        },
        {
          director: [
            {
              name: 'Ray Harryhausen'
            }
          ],
          sort_title: 'storybook review 1946',
          title: [
            'The Storybook Review'
          ],
          year: '1946',
          search_field: 'the storybook review storybook review 1946 ray harryhausen''s fairy tales'
        },
        {
          director: [],
          sort_title: 'trailer trauma 2: drive-in monsterama',
          title: [
            'Trailer Trauma 2: Drive-In Monsterama'
          ],
          search_field: 'trailer trauma 2: drive-in monsterama',
          year: nil
        }
      ]
    }

    writer = class_double('JsonWriter').as_stubbed_const
    expect(writer).to receive(:call).with({content: expected.as_json, file_name: 'programs.json'})

    ProgramExport.call
  end

  it "should sort discs alphabetically within programs" do
    create(:program, name: 'The First Thing', sort_name: 'First Thing')
    create(:disc, name: 'A Second Thing')
    create(:program, name: 'The Third Thing', sort_name: 'Third Thing')

    expected = {
      meta: {
        version: '1.0'
      },
      program: [
        {
          director: [],
          sort_title: 'first thing 1979',
          title: [
            'The First Thing'
          ],
          search_field: 'the first thing first thing 1979',
          version: 'Director Cut',
          year: '1979'
        },
        {
          director: [],
          sort_title: 'second thing',
          title: [
            'A Second Thing'
          ],
          search_field: 'second thing',
          year: nil
        },
        {
          director: [],
          sort_title: 'third thing 1979',
          title: [
            'The Third Thing'
          ],
          search_field: 'the third thing third thing 1979',
          version: 'Director Cut',
          year: '1979'
        }
      ]
    }

    writer = class_double('JsonWriter').as_stubbed_const
    expect(writer).to receive(:call).with({content: expected.as_json, file_name: 'programs.json'})

    ProgramExport.call
  end

  it "should omit discs with no title" do
    location = create(:location)
    create(:disc, name: nil, format: 'Blu-ray', state: 'FILED', location: location)
    create(:disc, name: '', format: 'Blu-ray', state: 'FILED', location: location)

    expected = {
      meta: {
        version: '1.0'
      },
      program: []
    }

    writer = class_double('JsonWriter').as_stubbed_const
    expect(writer).to receive(:call).with({content: expected.as_json, file_name: 'programs.json'})

    ProgramExport.call
  end

  it "should format packages without discs for export" do
    create(:package, name: 'The Complete Eek! The Cat')
    pkg = create(:package, name: 'Freakazoid: Season 1')
    create(:package, name: 'Rescue Rangers: Complete Series')
    create(:disc_package, package_id: pkg.id, disc_id: create(:disc, name: 'Disc 1').id)

    expected = {
      meta: {
        version: '1.0'
      },
      program: [
        {
          director: [],
          sort_title: 'complete eek! the cat',
          search_field: 'complete eek! the cat',
          title: ['The Complete Eek! The Cat'],
          year: nil
        },
        {
            director: [],
            sort_title: 'freakazoid: season 1 disc 1',
            search_field: 'freakazoid: season 1 disc 1',
            title: ['Disc 1'],
            year: nil
        },
        {
          director: [],
          sort_title: 'rescue rangers: complete series',
          search_field: 'rescue rangers: complete series',
          title: ['Rescue Rangers: Complete Series'],
          year: nil
        }
      ]
    }

    writer = class_double('JsonWriter').as_stubbed_const
    expect(writer).to receive(:call).with({content: expected.as_json, file_name: 'programs.json'})

    ProgramExport.call
  end

  it "should sort packages alphabetically within programs" do
    create(:package, name: 'Columbo: The Complete Series')
    create(:package, name: 'Murder, She Wrote')
    program = create(:program, name: 'Friday Foster', year: '1975', minutes: 90)
    director = create(:person, name: 'Arthur Marks')
    create(:program_person, program_id: program.id, person_id: director.id)

    expected = {
      meta: {
        version: '1.0'
      },
      program: [
        {
          director: [],
          sort_title: 'columbo: the complete series',
          search_field: 'columbo: the complete series',
          title: ['Columbo: The Complete Series'],
          year: nil
        },
        {
          director: [name: 'Arthur Marks'],
          sort_title: 'friday foster 1975',
          search_field: 'friday foster 1975',
          title: ['Friday Foster'],
          version: 'Director Cut',
          year: '1975'
        },
        {
          director: [],
          sort_title: 'murder, she wrote',
          search_field: 'murder, she wrote',
          title: ['Murder, She Wrote'],
          year: nil
        }
      ]
    }

    writer = class_double('JsonWriter').as_stubbed_const
    expect(writer).to receive(:call).with({content: expected.as_json, file_name: 'programs.json'})

    ProgramExport.call
  end

end
