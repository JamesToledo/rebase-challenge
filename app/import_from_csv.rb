# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'rack/handler/puma'
require 'csv'

class Exams < ActiveRecord::Base
  def self.import_to_database(rows)
    object = Exams.column_names[1..16].to_h { |key| [key, nil] }

    rows.each do |row|
      object.each_key do |key|
        object[key] = row.shift
      end
      Exams.create(object)
    end
  end

  def self.extract_csv(data)
    rows = CSV.read(data, col_sep: ';')
    rows.shift

    rows
  end

  def self.show(data)
    response = mount_response(data.first)

    data.each do |object|
      response[:tests] << {
        'exam_type': object[:exam_type],
        'exam_limit': object[:exam_limit],
        'exam_result': object[:exam_result]
      }
    end

    response.to_json
  end

  def self.mount_response(data)
    {
      'exam_result_token': data[:exam_result_token],
      'exam_date': data[:exam_date],
      'cpf': data[:cpf],
      'patient_name': data[:patient_name],
      'patient_email': data[:patient_email],
      'patient_dob': data[:patient_dob],
      'doctor': { 'doctor_crm': data[:doctor_crm], 'doctor_state': data[:doctor_state],
                  'doctor_name': data[:doctor_name] }, 'tests': []
    }
  end
end
