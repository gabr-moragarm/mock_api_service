# frozen_string_literal: true

require 'sinatra/base'
require 'json'
require 'rack'
require_relative './routes/api_json_basic'

class App < Sinatra::Base
  configure do
    set :show_exceptions, false
  end

  use Routes::ApiJsonBasic
end
