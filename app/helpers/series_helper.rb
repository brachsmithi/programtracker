module SeriesHelper

  def series_capsule_array series
    return_array = []
    series.series_programs.each do |sp|
      return_array << sequenced_series_capsule(sp)
    end
    series.contained_series_series.each do |cs|
      return_array << sequenced_series_capsule(cs)
    end
    return_array.sort_by {|ssc| ssc[:seq]}
  end

  def sequenced_series_capsule series_assoc
    {
      seq: series_assoc.safe_sequence, 
      display_capsule: series_capsule(series_assoc),
      id: series_capsule_id(series_assoc),
      path_method: series_capsule_path(series_assoc)
    }
  end

  def capsule_series_program series_program
    year = series_program.program.year.blank? ? '' : " (#{series_program.program.year})"
    version = series_program.program.version.blank? ? '' : " - #{series_program.program.version}"
    "#{series_program.program.name}#{year}#{version}"
  end

  def capsule_series_series series_series
    programs = series_series.contained_series.series_programs
    program_count = programs.any? ? " [#{programs.count}]" : ''
    "#{series_series.contained_series.name}#{program_count}"
  end

  private 

  def series_capsule series_assoc
    if series_assoc.respond_to? :program
      capsule_series_program series_assoc
    else
      capsule_series_series series_assoc
    end
  end

  def series_capsule_id series_assoc
    if series_assoc.respond_to? :program
      series_assoc.program.id
    else
      series_assoc.contained_series.id
    end
  end

  def series_capsule_path series_assoc
    if series_assoc.respond_to? :program
      'program_path'
    else
      'series_path'
    end
  end

end
