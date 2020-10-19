require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  require_relative 'cookbook'

  csv_file   = File.join(__dir__, 'recipes.csv')
  @cookbook   = Cookbook.new(csv_file)
  @hello = "hello"
  erb :index
end

get '/about' do
  erb :about
end
