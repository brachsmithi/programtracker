module PersonsHelper

  def capsule_person(person)
    aliases = person.person_aliases.empty? ? '' : " (#{person.person_aliases.map(&:name).join(', ')})"
    "#{person.name}#{aliases}"
  end

end
