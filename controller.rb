require('sinatra')
require('sinatra/contrib/all')
require('pry')

require_relative('./models/film')
also_reload('./models/*')

require_relative('../db/sql_runner')

class Film

  attr_reader :id, :title

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
  end

  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    return Film.map_items(films)
  end

  def self.map_items(film_data)
    result = film_data.map { |film| Film.new(film) }
    return result
  end

end