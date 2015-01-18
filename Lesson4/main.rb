require 'sinatra'

get '/' do
  erb :home
end

post '/set_name' do
  "Hello World"
end