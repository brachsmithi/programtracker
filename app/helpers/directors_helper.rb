module DirectorsHelper

  def capsule_director director
    aliases = director.person_aliases.empty? ? '' : " (#{director.person_aliases.map(&:name).join(', ')})"
    "#{director.name}#{aliases}"
  end

end
