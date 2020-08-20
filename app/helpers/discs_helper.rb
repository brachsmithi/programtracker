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

end
