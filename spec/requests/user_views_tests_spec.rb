# frozen_string_literal: true

require 'spec_helper'
require_relative '../../app/controllers/exams_controller'
require_relative '../../config/routes'

RSpec.describe 'server', type: :request do
  describe 'GET /tests' do
    let(:app) { Server.new }

    it 'Receive response successfully' do
      data = ExtractCsvService.extract('spec/support/test.csv')
      ExamsController.import_to_database(data)

      response = get '/tests'

      expect(response.status).to eq 200
      expect(JSON.parse(response.body)[0]['cpf']).to include Exams.first.cpf
    end
  end
end
