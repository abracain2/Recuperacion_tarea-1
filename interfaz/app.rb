# myapp.rb
require 'rubygems'
require 'sinatra'
require_relative '../packages/consultas'

set :views, "views"
set :logging, :true

con = Consultas.new()

get '/' do
    
    consulta = "#{params['word']}"
    
    if not consulta.empty?
      
      return con.procesar_consulta(consulta)
      
    else
      
      erb :hello_form
      
    end
end

post '/' do
    
    consulta = "#{params['buscar']}"
    
    return con.procesar_consulta(consulta)
    
end