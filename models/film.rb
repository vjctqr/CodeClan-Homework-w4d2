require_relative('../db/sql_runner')

class Film
    
    attr_reader :id
    attr_accessor :title, :price

    def initialize( options )
        @id = options['id'] if options['id']
        @title = options['title']
        @price = options['price']
    end

    def save()
        sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id;"
        values = [@title, @price]
        film = SqlRunner.run(sql, values).first
        @id = film['id'].to_i
    end   

    def update()
        sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
        values = [@title, @price, @id]
        SqlRunner.run(sql, values)
    end

    # def delete()
    #     sql = "DELETE FROM films where id = $1"
    #     values = [@id]
    #     SqlRunner.run(sql, values)
    # end

    def customers()
        sql = "SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customers_id = customers.id WHERE film_id = $1"
        values = [@id]
        customers = SqlRunner.run(sql, values)
        return Customer.map_items(customers)
    end

    def tickets()
        sql = "SELECT * FROM tickets WHERE tickets.film_id = $1"
        values = [@id]
        films = SqlRunner.run(sql. values)
        return Ticket.map_items(films)
    end

    def watchers()
        return customers().length
    end



    def self.all()
        sql = "SELECT * FROM films"
        films = SqlRunner.run(sql)
        return self.map_items(films)
    end

    def self.delete_all()
        sql = "DELETE FROM films"
        SqlRunner.run(sql)
    end

    def self.map_items(films)
        return films.map { |film| Film.new(film) }
    end
    

end
