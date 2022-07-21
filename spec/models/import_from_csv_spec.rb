# frozen_string_literal: true

require 'spec_helper'
require_relative '../../app/import_from_csv'

describe 'Import csv data to database' do
  it 'successfully' do
    data = Exams.extract_csv('spec/support/test.csv')
    Exams.import_to_database(data)

    expect(Exams.count).to eq 2
    expect(Exams.first.exam_result).to eq 97
  end
end
