module Helpers

  DEFAULT_PROGRAM = { name: 'My Program' }

  DEFAULT_DIRECTOR = { name: 'Director Person' }
  EDIT_DIRECTOR = { name: 'A.B. Runs-the-Show' }

  DEFAULT_SERIES = { name: 'Film Franchise' }
  EDIT_SERIES = { name: 'Television Show' }

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

  def create_director name = DEFAULT_DIRECTOR[:name]
    Director.create(name: name)
  end

  def create_series name = DEFAULT_SERIES[:name]
    Series.create(name: name)
  end

  def create_program name = DEFAULT_PROGRAM[:name]
    Program.create(name: name)
  end

  def create_edit_program
    p = Program.create({
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

end

World(Helpers)