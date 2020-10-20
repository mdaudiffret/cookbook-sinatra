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

  csv_file = File.join(__dir__, 'recipes.csv')
  @cookbook = Cookbook.new(csv_file)
  erb :index
end

get '/new' do
  erb :new
end

get '/recipe?*' do
  require_relative 'cookbook'

  csv_file = File.join(__dir__, 'recipes.csv')
  @cookbook = Cookbook.new(csv_file)
  @cookbook.add_recipe(Recipe.new(params[:name], params[:description], params[:rating], params[:prep_time]))
  erb :index
end

get '/scrap' do
  erb :scrap
end

get '/ingredient?*' do
  @url = "https://www.marmiton.org/recettes/recherche.aspx?aqt=#{params[:search]}"
  erb :select
end
