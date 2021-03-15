# frozen_string_literal: true

def create_file(path, file_type: 'text/plain', from_app: true)
  root = "#{Rails.root}/" if from_app
  Rack::Test::UploadedFile.new("#{root}#{path}", file_type)
end
