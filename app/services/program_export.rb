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
      {
        search_field: prog.program.sort_name,
        title: [
          prog.program.name
        ],
        year: prog.program.year
      }
    end
  end

end


# director: [
#   {
#     name: prog.program.persons.first.name
#   }
# ],