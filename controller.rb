require('sinatra')
require('sinatra/contrib/all') if development?
require('pry')

require_relative('./models/customer')
require_relative('./models/film')
require_relative('./models/screenings')
require_relative('./models/ticket')
also_reload('./models/*')

get '/films' do
    @films = Film.self.all()
    erb(:index)
end

# get '/films/1' do
#     erb(:film1)
# end
