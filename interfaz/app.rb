# myapp.rb
require 'rubygems'
require 'sinatra'
require "dinosaurus"
require_relative '../indices'  
require_relative '../packages/structures'
require_relative '../packages/normalize'

set :views, "views"
set :logging, :true

struct = Structures.new()
ind = Indices.new()
norm = Normalize.new()

struct = ind.hacer_indices(struct)

get '/' do
    erb :hello_form
end

post '/' do
    
    Dinosaurus.configure do |config|
      config.api_key = 'ddec603cf16e46327f57f1ce15dfcbe6'
    end
    
    structtemp = Hash.new()
    
    consulta = "#{params['buscar']}"
    
    consulta = norm.normalize_text_consult(consulta)
    
    sugerencias = Array.new
    
    consulta.each do |word|
        
        Dinosaurus.synonyms_of(word).each do |sug|
            sugerencias.push(sug)
        end
    
        structtemp = struct.union_avg_hash(structtemp, struct.term_tf_idf_in_documents(word))
        
    end
    
    result = Hash.new()
    
    result['resultados'] = structtemp.sort_by { |id, tf_idf| tf_idf }.reverse!
    
    sugerencias = sugerencias.uniq
    
    result['sugerencias'] = sugerencias
    
    
    #if structtemp != 0
        #structtemp.each do |id, tf_idf|
            
            #if structtemp[id].nil? != true
                #structtemp[id] = struct.get_url(id)
            #end
            
        #end
    #end
    
    puts structtemp
    
    puts sugerencias
    
    return result.inspect
end