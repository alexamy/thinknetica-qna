# frozen_string_literal: true

# :reek:UtilityFunction
def create_file_from_system(path, file_type: 'text/plain')
  Rack::Test::UploadedFile.new(path, file_type)
end

# :reek:UtilityFunction
def create_file(path, file_type: 'text/plain')
  Rack::Test::UploadedFile.new("#{Rails.root}/#{path}", file_type)
end
