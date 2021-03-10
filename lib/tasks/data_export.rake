import 'app/services/json_writer.rb'

namespace :export do

  namespace :json do

    desc 'exports programs to json'
    task :programs do
      JsonWriter.call({content: {key: ['value1', 'value2']}, file_name: 'foo.json'})
    end

  end

end