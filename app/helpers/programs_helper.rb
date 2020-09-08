module ProgramsHelper

  def program_capsule program
    year = program.year.blank? ? '' : " (#{program.year})"
    s_names = program.series.pluck(:name)
    series = s_names.any? ? " - #{s_names.join(', ')}" : ''
    version = program.version.blank? ? '' : " (#{program.version})"
    "#{program.name}#{year}#{series}#{version}"
  end

  def program_capsule_short program
    year = program.year.blank? ? '' : " (#{program.year})"
    version = program.version.blank? ? '' : " - #{program.version}"
    "#{program.name}#{year}#{version}"
  end

  def display_length minutes
    return '' if minutes.nil?
    hours = minutes/60
    minutes = minutes%60
    min_display = minutes > 0 ? " #{minutes} min" : ''
    "#{hours} #{'hr'.pluralize(hours)}#{min_display}"
  end

  def duplicate_report_display program
    discs = program.discs.map {|d| 
      package = d.package.nil? ?  '' : "#{d.package.name} (#{link_to 'show', package_path(d.package)}) "
      "#{package}#{d.format} (#{d.location.name}) (#{link_to 'show', disc_path(d)})"
    }.join(', ')
    raw "#{program.name} (#{link_to 'show', program_path(program)}) - #{discs}"
  end

end
