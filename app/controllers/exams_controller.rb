# frozen_string_literal: true

require_relative '../models/exams'
require_relative '../services/extract_csv_service'
require_relative '../services/mount_response_service'

class ExamsController
  def self.index
    Exams.all.to_json(except: %i[id updated_at created_at])
  end

  def self.show(params)
    data = Exams.where('exam_result_token = ?', params)
    MountResponseService.mount(data)
  end

  def self.import_to_database(rows)
    object = Exams.column_names[1..16].to_h { |key| [key, nil] }

    rows.each do |row|
      object.each_key do |key|
        object[key] = row.shift
      end
      Exams.create(object)
    end
  end
end
