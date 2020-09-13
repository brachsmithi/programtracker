module SeriesHelper

  def capsule_series_program series_program
    sequence = series_program.sequence.nil? ? '' : "#{series_program.sequence} - "
    year = series_program.program.year.blank? ? '' : " (#{series_program.program.year})"
    version = series_program.program.version.blank? ? '' : " - #{series_program.program.version}"
    "#{sequence}#{series_program.program.name}#{year}#{version}"
  end

end
