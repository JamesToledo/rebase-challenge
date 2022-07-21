# frozen_string_literal: true

require 'spec_helper'
require_relative '../../app/controllers/exams_controller'
require_relative '../../config/routes'

RSpec.describe 'server', type: :request do
  describe 'GET /tests/:token' do
    let(:app) { Server.new }

    it 'Receive response successfully' do
      data = ExtractCsvService.extract('spec/support/test.csv')
      ExamsController.import_to_database(data)

      object = {
        'exam_result_token': 'IQCZ17',
        'exam_date': '2021-08-05',
        'cpf': '048.973.170-88',
        'patient_name': 'Emilly Batista Neto',
        'patient_email': 'gerald.crona@ebert-quigley.com',
        'patient_dob': '2001-03-11',
        'doctor': {
          'doctor_crm': 'B000BJ20J4',
          'doctor_state': 'PI',
          'doctor_name': 'Maria Luiza Pires'
        },
        'tests': [{
          'exam_type': 'hemácias',
          'exam_limit': '45-52',
          'exam_result': 97
        }, {
          'exam_type': 'leucócitos',
          'exam_limit': '9-61',
          'exam_result': 89
        }]
      }.to_json

      response = get '/tests/IQCZ17'

      expect(response.status).to eq 200
      expect(response.body).to eq object
    end
  end
end
