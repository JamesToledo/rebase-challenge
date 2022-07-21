# frozen_string_literal: true

require 'spec_helper'
require_relative '../../app/server'

RSpec.describe 'server', type: :request do
  describe 'GET /tests' do
    let(:app) { Server.new }

    it 'Receive response successfully' do
      data = Exams.extract_csv('spec/support/test.csv')
      Exams.import_to_database(data)

      response = get '/tests'

      expect(response.status).to eq 200
      expect(JSON.parse(response.body)[0]['cpf']).to include Exams.first.cpf
    end
  end
end
