# myapp.rb
require 'rubygems'
require 'sinatra'
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
    
    structtemp = Hash.new()
    
    consulta = "#{params['buscar']}"
    
    consulta = norm.normalize_text_consult(consulta)
    
    consulta.each do |word|
    
        structtemp = struct.union_avg_hash(structtemp, struct.term_tf_idf_in_documents(word))
        
    end
    
    
    structtemp = structtemp.sort_by { |id, tf_idf| tf_idf }.reverse!
    
    #if structtemp != 0
        #structtemp.each do |id, tf_idf|
            
            #if structtemp[id].nil? != true
                #structtemp[id] = struct.get_url(id)
            #end
            
        #end
    #end
    
    return structtemp.inspect
end