module DiscsHelper

  def display_name disc
    dps = disc.disc_programs
    features = dps.select{|dp| dp.program_type == 'FEATURE'}
    if features.any?
      sequenced = features.select { |f| !f.sequence.nil? }
      if sequenced.any?
        sequenced.sort { |s| s.sequence }.first.program.name
      else
        features.first.program.name
      end
    else
      disc.package.nil? ? 
        disc.programs.empty? ?
          '--No Programs--' :
          disc.programs.first.name : 
        disc.package.name
    end
  end

  def sort_discs disc_arr
    disc_arr.sort_by { |d| trim_article(display_name(d)).downcase }
  end

  private

  def trim_article value
    if value.start_with? 'A '
      value.delete_prefix 'A '
    elsif value.start_with? 'An '
      value.delete_prefix 'An '
    elsif value.start_with? 'The '
      value.delete_prefix 'The '
    else
      value
    end
  end

end
