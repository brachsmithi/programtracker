module Helpers

  # DIRECTOR - DATA AND ACCESSORS

  DEFAULT_DIRECTOR = { name: 'Director Person' }

  EDIT_DIRECTOR = { name: 'A.B. Runs-the-Show' }

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

  def default_director
    DEFAULT_DIRECTOR
  end

  def created_director
    CREATED_DIRECTOR
  end

  def edited_director
    EDITED_DIRECTOR
  end

  # DISC - DATA AND ACCESSORS

  DEFAULT_DISC = { 
    name: 'Bonus Disc',
    format: 'DVD',
    state: 'FILED',
    location_name: 'Cabinet'
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

  def default_disc
    DEFAULT_DISC
  end

  def created_disc
    CREATED_DISC
  end

  def edited_disc
    EDITED_DISC
  end

  # LOCATION - DATA AND ACCESSORS

  DEFAULT_LOCATION = { name: 'Storage' }

  CREATED_LOCATION = {
    name: 'Binder 23'
  }

  EDITED_LOCATION = {
    original_name: 'Box 1',
    edit_name: 'Box-01'
  }

  def default_location
    DEFAULT_LOCATION
  end

  def created_location
    CREATED_LOCATION
  end

  def edited_location
    EDITED_LOCATION
  end

  # PACKAGE - DATA AND ACCESSORS

  DEFAULT_PACKAGE = { name: 'Big Set'}

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

  def default_package
    DEFAULT_PACKAGE
  end

  def created_package
    CREATED_PACKAGE
  end

  def edited_package
    EDITED_PACKAGE
  end

  # PROGRAM - DATA AND ACCESSORS

  DEFAULT_PROGRAM = { name: 'My Program' }

  CREATED_PROGRAM = { 
    name: '1st Created Program',
    name_display: '1st Created Program (2020)',
    sort_name: 'First Created Program',
    year: '2020',
    version: 'Theatrical Cut',
    length: '90',
    length_display: '1 hr 30 min',
    director_name: 'Norah Smith',
    director_search_term: 'nora',
    series_name: 'The Programs We Watched',
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
    original_director_name: 'Johnny Jameson',
    edit_director_name: 'Janey Johnson',
    director_search_term: 'jane',
    original_series_name: 'Programs on DVD',
    edit_series_name: 'Programs on Blu-ray',
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

  # PROGRAM VERSION CLUSTER - DATA AND ACCESSORS

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

  def created_program_version_cluster
    CREATED_PROGRAM_VERSION_CLUSTER
  end

  def edited_program_version_cluster
    EDITED_PROGRAM_VERSION_CLUSTER
  end

  # SERIES - DATA AND ACCESSORS

  DEFAULT_SERIES = { name: 'Film Franchise' }

  EDIT_SERIES = { name: 'Television Show' }

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

  EDITED_CONTAINED_SERIES = {
    edit_name: 'Inner Child',
    series_name: 'Outer Adult',
    series_search_term: 'out'
  }

  EDITED_WRAPPER_SERIES = {
    original_name: 'Wrapper Series',
    edit_name: 'Outer Series',
    original_sequence: '2',
    edit_sequence: '3',
    contained_series_name: 'Contained!'
  }

  def default_series
    DEFAULT_SERIES
  end

  def created_series
    CREATED_SERIES
  end

  def edited_series
    EDITED_SERIES
  end

  def edited_contained_series
    EDITED_CONTAINED_SERIES
  end

  def edited_wrapper_series
    EDITED_WRAPPER_SERIES
  end

end

World(Helpers)