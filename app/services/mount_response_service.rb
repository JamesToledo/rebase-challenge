# frozen_string_literal: true

class MountResponseService
  def self.mount(data)
    response = build_response(data.first)

    data.each do |object|
      response[:tests] << {
        'exam_type': object[:exam_type],
        'exam_limit': object[:exam_limit],
        'exam_result': object[:exam_result]
      }
    end

    response.to_json
  end

  def self.build_response(data)
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
