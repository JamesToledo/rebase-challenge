# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'rack/handler/puma'
require 'csv'

class Exams < ActiveRecord::Base
end
