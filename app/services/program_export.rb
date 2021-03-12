require './app/services/application_service.rb'
require './app/models/programs_search.rb'

class ProgramExport < ApplicationService

  def call
    programs = ProgramsSearch.all_by_name
    JsonWriter.call({content: formatted_programs(programs).as_json, file_name: 'programs.json'})
  end

  private

  def formatted_programs programs
    programs.map do |prog|
      program = prog.program
      {
        director: formatted_directors(program),
        search_field: prog.search_name,
        title: formatted_titles(program),
        year: program.year
      }
    end
  end

  def formatted_titles program
    titles = program.alternate_titles.map do |title|
      title.name
    end
    titles.insert 0, program.name
  end

  def formatted_directors program
    program.persons.map do |person|
      director = {
        name: program.persons.first.name
      }
      director[:alias] = formatted_aliases(person) unless person.person_aliases.empty?
      director
    end
  end

  def formatted_aliases person
    person.person_aliases.map do |pa|
      pa.name
    end
  end

end