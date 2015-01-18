require 'sinatra'

get '/' do
  erb :home
end


get '/template' do
  erb :my_template
end

get '/nested/nested_template' do
  erb :'/users/profile'
end