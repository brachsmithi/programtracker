module ProgramsHelper

  def program_capsule program
    year = program.year.blank? ? '' : " (#{program.year})"
    s_names = program.series.pluck(:name)
    series = s_names.any? ? " - #{s_names.join(', ')}" : ''
    version = program.version.blank? ? '' : " (#{program.version})"
    "#{program.name}#{year}#{series}#{version}"
  end

  def display_length minutes
    return '' if minutes.nil?
    hours = minutes/60
    minutes = minutes%60
    min_display = minutes > 0 ? " #{minutes} min" : ''
    "#{hours} #{'hr'.pluralize(hours)}#{min_display}"
  end

end
