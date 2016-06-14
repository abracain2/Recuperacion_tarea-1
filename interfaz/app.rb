# myapp.rb
require 'rubygems'
require 'sinatra'

set :views, "views"

get '/' do
    erb :hello_form
end

post '/' do
    return "#{params['buscar']}"
end