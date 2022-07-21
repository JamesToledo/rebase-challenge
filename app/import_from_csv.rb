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
end
