module DiscsHelper

  def program_select_name program
    year = program.year.blank? ? '' : " (#{program.year})"
    version = program.version.blank? ? '' : " - #{program.version}"
    "#{program.name}#{year}#{version}"
  end

end
