# frozen_string_literal: true

require_relative '../controllers/exams_controller'
require_relative '../../config/sidekiq'

class ImportCsvJob
  include Sidekiq::Job

  def perform(data)
    ExamsController.import_to_database(data)
  end
end
