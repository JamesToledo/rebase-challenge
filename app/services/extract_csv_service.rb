# frozen_string_literal: true

require_relative '../controllers/exams_controller'

class ExtractCsvService
  def self.extract(params)
    rows = CSV.read(params, col_sep: ';')
    rows.shift

    rows
  end
end
