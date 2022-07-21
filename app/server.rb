# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'rack/handler/puma'
require_relative './sidekiq/import_csv_job'

class Server < Sinatra::Base
  set :logging, true
  set :bind, '0.0.0.0'
  set :port, 3000

  get '/tests' do
    Exams.all.to_json
  end

  post '/import' do
    data = Exams.extract_csv(params[:csv][:tempfile])

    ImportCsvJob.perform_async(data)

    return 'Your csv file will be uploaded soon!'
  end
  run! if app_file == $PROGRAM_NAME
end
