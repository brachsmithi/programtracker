module SeriesHelper

  def capsule_series_program series_program
    sequence = series_program.sequence.nil? ? '' : "#{series_program.sequence} - "
    version = series_program.program.version.blank? ? '' : " (#{series_program.program.version})"
    "#{sequence}#{series_program.program.name}#{version}"
  end

end
