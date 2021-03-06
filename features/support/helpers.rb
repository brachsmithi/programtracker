module Helpers

  # PERSON - DATA AND ACCESSORS

  DEFAULT_PERSON = { name: 'Person Person' }

  EDIT_PERSON = { name: 'A.B. Runs-the-Show' }

  CREATED_PERSON = {
    name: 'Ann Film-Maker',
    alias: 'Ann F. Maker'
  }

  EDITED_PERSON = {
    original_name: 'Jonathan Franco',
    edit_name: 'Frank Jonathon',
    original_alias: 'Johnny Frank',
    edit_alias: 'Francis J.'
  }

  def default_person
    DEFAULT_PERSON
  end

  def created_person
    CREATED_PERSON
  end

  def edited_person
    EDITED_PERSON
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
    package_search_term: 'coll',
    series_name: 'Media Series',
    series_search: 'edia',
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
    package_search_term: 'night',
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
    },
    series: {
      original_series_name: 'First Series',
      new_series_name: 'New Series',
      search_term: 'new'
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
    ],
    series_name: 'Mill Creek Sets',
    series_search: 'mill'
  }

  EDITED_CONTAINED_PACKAGE = {
    edit_name: 'Inner Child',
    package_name: 'Outer Adult',
    package_search_term: 'out'
  }

  EDITED_WRAPPER_PACKAGE = {
    original_name: 'Wrapper Package',
    edit_name: 'Outer Series',
    original_sequence: '2',
    edit_sequence: '3',
    contained_package_name: 'Contained!'
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

  def edited_contained_package
    EDITED_CONTAINED_PACKAGE
  end

  def edited_wrapper_package
    EDITED_WRAPPER_PACKAGE
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
    person_name: 'Norah Smith',
    person_search_term: 'nora',
    series_name: 'The Programs We Watched',
    series_search: 'prog',
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
    original_person_name: 'Johnny Jameson',
    edit_person_name: 'Janey Johnson',
    person_search_term: 'jane',
    original_series_name: 'Programs on DVD',
    edit_series_name: 'Programs on Blu-ray',
    series_search: 'blu',
    original_alternate_title: 'Created Program',
    edit_alternate_title: 'Edited Program'
  }

  EDITED_PROGRAM_IN_CLUSTER = {
    name: 'The Lion in Winter',
    sort_name: 'Lion in Winter',
    year: '1968',
    original_version: 'Full Screen',
    new_version: 'Widescreen',
    length: '134',
    length_display: '2 hrs 14 min',
    person_name_1: 'Anthony Harey',
    person_name_2: 'Douglas Slocombe',
    series_name_1: 'Katherine Hepburn Filmography',
    series_name_2: 'Peter O\'Toole Filmography',
    alternate_title_1: 'Who\'s Afraid of Henry II?',
    alternate_title_2: 'Christmas with the Royals'
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

  def edited_program_in_cluster
    EDITED_PROGRAM_IN_CLUSTER
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

  EDITED_PROGRAMS_EDIT_PROGRAM_VERSION_CLUSTER = {
    programs: [
      {
        name: 'The Silence of the Lambs',
        sort_name: 'Silence of the Lambs',
        version: 'Widescreen',
        year: '1991',
        length: '118',
        display_length: '1 hr 58 min'
      },
      {
        name: 'The Silence of the Lambs',
        sort_name: 'Silence of the Lambs',
        version: 'Full Screen',
        year: '1991',
        length: '118',
        display_length: '1 hr 58 min'
      }
    ],
    edit_name: 'The Roar of the Lion',
    edit_sort_name: 'Roar of the Lion',
    edit_year: '1990'
  }

  def created_program_version_cluster
    CREATED_PROGRAM_VERSION_CLUSTER
  end

  def edited_program_version_cluster
    EDITED_PROGRAM_VERSION_CLUSTER
  end

  def edited_programs_edit_program_version_cluster
    EDITED_PROGRAMS_EDIT_PROGRAM_VERSION_CLUSTER
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
    ],
    disc: {
      name: 'The Piddle Party',
      original_sequence: '9',
      edit_sequence: '13'
    },
    package: {
      name: 'Mizzer Man Set',
      original_sequence: '7',
      edit_sequence: '8'
    }
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

  EDITED_SERIES_FOR_DELETION = {
    series_name: 'The Big Series',
    contained_series_name: 'The Small Series',
    program_name: 'An Entry',
    disc_name: 'The Disc',
    series_sequence: '1',
    program_sequence: '2',
    disc_sequence: '3'
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

  def edited_series_for_deletion
    EDITED_SERIES_FOR_DELETION
  end

end

World(Helpers)