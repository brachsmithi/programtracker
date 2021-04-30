require './app/services/application_service.rb'
require './app/models/programs_search.rb'

class ProgramExport < ApplicationService

  def call
    programs = ProgramsSearch.all_by_name
    discs = DiscsSearch.with_no_programs
    packages = PackagesSearch.with_no_discs
    formatted_content = formatted_programs(programs).concat(formatted_discs(discs))
                                                    .concat(formatted_packages(packages))
                                                    .sort_by {|fc| fc[:sort_title]}
    programs_json = {
      meta: {
        version: '1.0'
      },
      program: formatted_content
    }.as_json
    JsonWriter.call({content: programs_json, file_name: 'programs.json'})
  end

  private

  def formatted_packages(packages)
    packages.map do |pkg|
      package = pkg.package
      {
        director: [],
        search_field: pkg.sort_title,
        sort_title: pkg.sort_title,
        title: [package.name],
        year: nil
      }
    end
  end

  def formatted_discs(discs)
    discs.select {|d| !d.name.blank?}.map do |d|
      disc = d.disc
      {
        director: [],
        search_field: d.sort_title,
        sort_title: d.sort_title,
        title: [disc.name],
        year: nil
      }
    end
  end

  def formatted_programs(programs)
    programs.map do |prog|
      program = prog.program
      formatted = {
        director: formatted_directors(program),
        search_field: prog.search_name,
        sort_title: prog.sort_title,
        title: formatted_titles(program),
        year: program.year
      }
      formatted[:version] = program.version unless program.version.nil?
      formatted
    end
  end

  def formatted_titles(program)
    titles = program.alternate_titles.map do |title|
      title.name
    end
    titles.insert 0, program.name
  end

  def formatted_directors(program)
    program.persons.map do |person|
      director = {
        name: person.name
      }
      director[:alias] = formatted_aliases(person) unless person.person_aliases.empty?
      director
    end
  end

  def formatted_aliases(person)
    person.person_aliases.map do |pa|
      pa.name
    end
  end

end