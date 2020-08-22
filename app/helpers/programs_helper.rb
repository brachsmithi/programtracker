module ProgramsHelper

  def program_capsule program
    year = program.year.blank? ? '' : " (#{program.year})"
    s_names = program.series.pluck(:name)
    series = s_names.any? ? " - #{s_names.join(', ')}" : ''
    version = program.version.blank? ? '' : " (#{program.version})"
    "#{program.name}#{year}#{series}#{version}"
  end

end
