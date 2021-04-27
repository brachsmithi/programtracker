module ProgramsHelper

  def program_capsule(program)
    year = program.year.blank? ? '' : " (#{program.year})"
    s_names = program.series.pluck(:name)
    series = s_names.any? ? " - #{s_names.join(', ')}" : ''
    version = program.version.blank? ? '' : " (#{program.version})"
    "#{program.name}#{year}#{series}#{version}"
  end

  def program_capsule_short(program)
    version = program.version.blank? ? '' : " - #{program.version}"
    "#{program_capsule_year(program)}#{version}"
  end

  def program_capsule_year(program)
    year = program.year.blank? ? '' : " (#{program.year})"
    "#{program.name}#{year}"
  end

  def display_length(minutes)
    return '' if minutes.nil?
    hours = minutes / 60
    minutes = minutes % 60
    min_display = minutes > 0 ? " #{minutes} min" : ''
    "#{hours} #{'hr'.pluralize(hours)}#{min_display}"
  end

  def duplicate_report_display(program)
    discs = program.discs.map { |d|
      package = d.package.nil? ? '' : "#{link_to d.package.name, package_path(d.package)} "
      disc = "#{d.format} (#{d.location.name})"
      "#{package}#{link_to disc, disc_path(d)}"
    }.join(', ')
    raw "#{link_to program.name, program_path(program)} - #{discs}"
  end

end
