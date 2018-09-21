require 'sinatra'
require 'sinatra/namespace'
require 'json'
require './models/directory_scrub'

configure do
  set :port, 8080
  set :allow_methods, [:get]
end

before do
  content_type 'application/json'
end

get '/' do
  JSON.pretty_generate("Simple application to do full directory listing of provided path on local instance!")
end

namespace '/v1' do
  get '/disk_space' do
    path = params[:path]
    unless path.nil?
      JSON.pretty_generate(Scrubbing.new.directory_scrub_for_info(path))
    else
      JSON.pretty_generate("Path can't be empty!")
    end
  end
end

not_found do
  JSON.pretty_generate("Oops, can't find what you are looking for.....!")
end