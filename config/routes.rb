# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'rack/handler/puma'
require_relative '../app/sidekiq/import_csv_job'
require_relative '../app/controllers/exams_controller'
require_relative '../app/services/extract_csv_service'

class Server < Sinatra::Base
  set :logging, true
  set :bind, '0.0.0.0'
  set :port, 3000

  get '/tests' do
    ExamsController.index
  end

  get '/tests/:exam_result_token' do
    ExamsController.show(params[:exam_result_token])
  end

  post '/import' do
    data = ExtractCsvService.extract(params[:csv][:tempfile])

    ImportCsvJob.perform_async(data)

    return 'Your csv file will be uploaded soon!'
  end
  run! if app_file == $PROGRAM_NAME
end
