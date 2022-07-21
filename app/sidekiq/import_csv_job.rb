# frozen_string_literal: true

require_relative '../import_from_csv'
require_relative '../../config/sidekiq'

class ImportCsvJob
  include Sidekiq::Job

  def perform(data)
    Exams.import_to_database(data)
  end
end
