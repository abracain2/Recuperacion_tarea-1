# myapp.rb
require 'rubygems'
require 'sinatra'

get '/form' do
  erb :form
end

<form action="/form" method="post">
  <input type="text" name="message">
  <input type="submit">
</form>