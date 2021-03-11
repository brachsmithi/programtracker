import 'app/services/json_writer.rb'
import 'app/services/program_export.rb'

namespace :export do

  namespace :json do

    desc 'exports programs to json'
    task programs: :environment do
      ProgramExport.call()
    end

  end

end