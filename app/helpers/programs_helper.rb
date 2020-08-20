module ProgramsHelper

  def sort_programs programs
    programs.sort_by { |p| (p.sort_name.blank? ? p.name : p.sort_name).downcase }
  end

  def program_capsule program
    s_names = program.series.pluck(:name)
    series = s_names.any? ? " - #{s_names.join(', ')}" : ''
    version = program.version.blank? ? '' : " (#{program.version})"
    "#{program.name}#{series}#{version}"
  end

end
