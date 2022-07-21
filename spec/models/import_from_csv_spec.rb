# frozen_string_literal: true

require 'spec_helper'
require_relative '../../app/controllers/exams_controller'

describe 'Import csv data to database' do
  it 'successfully' do
    data = ExtractCsvService.extract('spec/support/test.csv')
    ExamsController.import_to_database(data)

    expect(Exams.count).to eq 3
    expect(Exams.first.exam_result).to eq 97
  end
end
