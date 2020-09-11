module Helpers

  DEFAULT_PROGRAM = { name: 'My Program' }

  DEFAULT_DIRECTOR = { name: 'Director Person' }
  EDIT_DIRECTOR = { name: 'A.B. Runs-the-Show' }

  DEFAULT_SERIES = { name: 'Film Franchise' }
  EDIT_SERIES = { name: 'Television Show' }

  DEFAULT_LOCATION = { name: 'Storage' }

  DEFAULT_PACKAGE = { name: 'Big Set'}

  DEFAULT_DISC = { 
    name: 'Bonus Disc',
    format: 'DVD',
    state: 'FILED',
    location_name: DEFAULT_LOCATION[:name]
  }

  CREATED_PROGRAM_VERSION_CLUSTER = {
    programs: [
      {
        name: 'Long Movie',
        version: 'Theatrical Cut',
        search_term: 'long movie'
      },
      {
        name: 'Longer Movie',
        version: 'Extended Version',
        search_term: 'longer'
      }
    ]
  }

  EDITED_PROGRAM_VERSION_CLUSTER = {
    programs: [
      {
        name: 'Feature film',
        version: 'U.S. Theatrical Version'
      },
      {
        name: 'Feature film',
        version: 'European Version'
      }
    ],
    edit_program: {
      name: 'Feature Film',
      version: 'TV Edit',
      search_name: 'Feature Film - TV Edit'
    },
    search_term: 'feat'
  }

  CREATED_SERIES = {
    name: 'TV Show'
  }

  EDITED_SERIES = {
    original_name: 'Adventures of Mizzer Man',
    edit_name: 'Cat Town Adventures',
    programs: [
      {
        name: 'The Monk is Amonk Us',
        original_sequence: '11',
        edit_sequence: '12'
      },
      {
        name: 'The Outside Cat Wants In',
        original_sequence: '41',
        edit_sequence: '39'
      }
    ]
  }

  CREATED_PACKAGE = {
    name: '20 Sci-Fi Movies'
  }

  EDITED_PACKAGE = {
    original_name: 'Alien Worlds',
    edit_name: 'Forbidden Worlds',
    discs: [
      {
        original_sequence: '1',
        edit_sequence: '4'
      },
      {
        original_sequence: '2',
        edit_sequence: '8'
      }
    ]
  }

  CREATED_DIRECTOR = {
    name: 'Ann Film-Maker',
    alias: 'Ann F. Maker'
  }

  EDITED_DIRECTOR = {
    original_name: 'Jonathan Franco',
    edit_name: 'Frank Jonathon',
    original_alias: 'Johnny Frank',
    edit_alias: 'Francis J.'
  }

  CREATED_DISC = {
    name: 'Disc One',
    format: 'Blu-ray',
    state: 'VIEWING',
    location_name: 'Under TV',
    package_name: 'Movie Collection',
    programs: [
      {
        name: 'First Program',
        search_term: 'first',
        program_type: 'FEATURE',
        sequence: '1'
      },
      {
        name: 'Second Program',
        search_term: 'second',
        program_type: 'BONUS',
        sequence: '2'
      }
    ]
  }

  EDITED_DISC = {
    original_name: 'Disc One',
    edit_name: 'Feature',
    original_format: 'DVD',
    edit_format: 'Blu-ray',
    original_state: 'VIEWING',
    edit_state: 'LENT',
    original_location_name: 'On Shelf',
    edit_location_name: 'Book 12',
    original_package_name: 'Double Feature',
    edit_package_name: 'Midnight Double-Feature',
    original_program: {
      name: 'Picture Show',
      program_type: 'FEATURE',
      sequence: '1'
    },
    edit_program: {
      name: 'Earlier Short',
      program_type: 'SHORT',
      sequence: '2',
      search_term: 'earl'
    } 
  }

  CREATED_PROGRAM = { 
    name: '1st Created Program',
    name_display: '1st Created Program (2020)',
    sort_name: 'First Created Program',
    year: '2020',
    version: 'Theatrical Cut',
    length: '90',
    length_display: '1 hr 30 min',
    director_name: DEFAULT_DIRECTOR[:name],
    director_search_term: 'perso',
    series_name: DEFAULT_SERIES[:name],
    alternate_title: 'Created Program'
  }

  EDITED_PROGRAM = { 
    original_name: '1st Created Program',
    edit_name: '1st Edited Program',
    original_sort_name: 'First Created Program',
    edit_sort_name: 'First Edited Program',
    original_year: '2018',
    edit_year: '2020',
    name_display: '1st Edited Program (2020)',
    original_version: 'Theatrical Cut',
    edit_version: 'U.S. Theatrical Cut',
    original_length: '90',
    edit_length: '92',
    length_display: '1 hr 32 min',
    original_director_name: DEFAULT_DIRECTOR[:name],
    edit_director_name: EDIT_DIRECTOR[:name],
    director_search_term: 'runs',
    original_series_name: DEFAULT_SERIES[:name],
    edit_series_name: EDIT_SERIES[:name],
    original_alternate_title: 'Created Program',
    edit_alternate_title: 'Edited Program'
  }

  def default_program
    DEFAULT_PROGRAM
  end

  def created_program
    CREATED_PROGRAM
  end

  def edited_program
    EDITED_PROGRAM
  end

  def default_disc
    DEFAULT_DISC
  end

  def created_disc
    CREATED_DISC
  end

  def edited_disc
    EDITED_DISC
  end

  def default_director
    DEFAULT_DIRECTOR
  end

  def created_director
    CREATED_DIRECTOR
  end

  def edited_director
    EDITED_DIRECTOR
  end

  def default_package
    DEFAULT_PACKAGE
  end

  def created_package
    CREATED_PACKAGE
  end

  def edited_package
    EDITED_PACKAGE
  end

  def default_series
    DEFAULT_SERIES
  end

  def created_series
    CREATED_SERIES
  end

  def edited_series
    EDITED_SERIES
  end

  def created_program_version_cluster
    CREATED_PROGRAM_VERSION_CLUSTER
  end

  def edited_program_version_cluster
    EDITED_PROGRAM_VERSION_CLUSTER
  end

  def create_director name = DEFAULT_DIRECTOR[:name]
    Director.create!(name: name)
  end

  def create_series name = DEFAULT_SERIES[:name]
    Series.create!(name: name)
  end

  def create_disc name = DEFAULT_DISC[:name]
    location = Location.find_or_create_by(name: DEFAULT_DISC[:location_name])
    Disc.create!(
      name: name, 
      location: location, 
      format: DEFAULT_DISC[:format],
      state: DEFAULT_DISC[:state]
    )
  end

  def create_program name = DEFAULT_PROGRAM[:name]
    Program.create!(name: name)
  end

  def create_location name = DEFAULT_LOCATION[:name]
    Location.create! name: name
  end

  def create_package name = DEFAULT_PACKAGE[:name]
    Package.create! name: name
  end

  def create_program_version_cluster
    ProgramVersionCluster.create!
  end

  def create_edit_program
    p = Program.create!({
      name: edited_program[:original_name],
      sort_name: edited_program[:origianl_sort_name],
      year: edited_program[:original_year],
      version: edited_program[:original_version],
      minutes: edited_program[:original_length]
    })
    p.directors << create_director(edited_program[:original_director_name])
    p.series << create_series(edited_program[:original_series_name])
    AlternateTitle.create(program: p, name: edited_program[:original_alternate_title])
    create_director(edited_program[:edit_director_name])
    create_series(edited_program[:edit_series_name])
    p
  end

  def create_edit_disc
    d = Disc.create!({
      name: edited_disc[:original_name],
      format: edited_disc[:original_format],
      state: edited_disc[:original_state],
      location: create_location(edited_disc[:original_location_name]),
      package: create_package(edited_disc[:original_package_name])
    })
    p = create_program edited_disc[:original_program][:name]
    DiscProgram.create!({
      program_type: edited_disc[:original_program][:program_type],
      sequence: edited_disc[:original_program][:series],
      program_id: p.id,
      disc_id: d.id
    })

    create_location edited_disc[:edit_location_name]
    create_package edited_disc[:edit_package_name]
    create_program edited_disc[:edit_program][:name]
    d
  end

  def create_edit_director
    d = create_director edited_director[:original_name]
    DirectorAlias.create!(director_id: d.id, name: edited_director[:original_alias])
    d
  end

  def create_edit_package
    p = create_package edited_package[:original_name]
    location = create_location
    d1 = Disc.create!({
      location: location,
      format: 'DVD',
      state: 'FILED'
    })
    d2 = Disc.create!({
      location: location,
      format: 'DVD',
      state: 'FILED'
    })
    DiscPackage.create!(
      disc_id: d1.id,
      package_id: p.id,
      sequence: edited_package[:discs][0][:original_sequence]
    )
    DiscPackage.create!(
      disc_id: d2.id,
      package_id: p.id,
      sequence: edited_package[:discs][1][:original_sequence]
    )
    p
  end

  def create_edit_series
    s = create_series edited_series[:original_name]
    p1 = create_program edited_series[:programs][0][:name]
    p2 = create_program edited_series[:programs][1][:name]
    SeriesProgram.create!({
      series_id: s.id,
      program_id: p1.id,
      sequence: edited_series[:programs][0][:original_sequence]
    })
    SeriesProgram.create!({
      series_id: s.id,
      program_id: p1.id,
      sequence: edited_series[:programs][1][:original_sequence]
    })
    s
  end

  def create_edit_program_version_cluster
    pvc = create_program_version_cluster
    p1 = Program.create!({
      name: EDITED_PROGRAM_VERSION_CLUSTER[:programs][0][:name],
      version: EDITED_PROGRAM_VERSION_CLUSTER[:programs][0][:version]
    })
    p2 = Program.create!({
      name: EDITED_PROGRAM_VERSION_CLUSTER[:programs][1][:name],
      version: EDITED_PROGRAM_VERSION_CLUSTER[:programs][1][:version]
    })
    pvc.programs << p1
    pvc.programs << p2
    Program.create!({
      name: EDITED_PROGRAM_VERSION_CLUSTER[:edit_program][:name],
      version: EDITED_PROGRAM_VERSION_CLUSTER[:edit_program][:version]
    })
    pvc
  end

end

World(Helpers)