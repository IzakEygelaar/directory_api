require 'sinatra'
require 'sinatra/namespace'

set :environment, ENV['RACK_ENV'] || 'development'

require './app/app'
run Sinatra::Application
