require './app/services/application_service.rb'
require './app/models/programs_search.rb'

class ProgramExport < ApplicationService

  def call
    progs = ProgramsSearch.all_by_name
    JsonWriter.call({content: progs.as_json, file_name: 'programs.json'})
  end

end