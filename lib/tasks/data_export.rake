namespace :export do

  namespace :json do

    desc 'exports programs to json'
    task programs: :environment do
      ProgramExport.call
    end

  end

end