module DirectorHelper

  def capsule_director director
    aliases = director.director_aliases.empty? ? '' : " (#{director.director_aliases.map(&:name).join(', ')})"
    "#{director.name}#{aliases}"
  end

end
