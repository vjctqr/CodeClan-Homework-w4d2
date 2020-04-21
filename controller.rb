require('sinatra')
require('sinatra/contrib/all')
require('pry')

require_relative('./models/film')
also_reload('./models/*')

get '/films/film1' do
    @films = Film.all()
    erb(:films)
end