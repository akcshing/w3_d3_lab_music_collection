require('pg')
require_relative("../db/Sql_Runner.rb")

class Artist

  attr_accessor :name
  attr_reader :id

    def initialize( options )
    @id = options['id'] if options['id']
    @name = options['name']
  end

  def all_albums
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    results = Sql_Runner.run( sql,values )
    return results.map{| album | Album.new(album)}
  end

  def update
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
    Sql_Runner.run( sql,values )
  end


  def save
    sql = "INSERT INTO artists
    (
    name
    )
    VALUES
    (
    $1
    )
    RETURNING *"
    values = [@name]
    result = Sql_Runner.run(sql,values)
    @id = result[0]['id'].to_i
  end

  def delete()
    sql = "DELETE FROM artists where id = $1"
    values = [@id]
    Sql_Runner.run(sql,values)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    results = Sql_Runner.run(sql)
    return results.map{|artist| Artist.new(artist)}
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    result = Sql_Runner.run(sql,values)
    return Artist.new(result[0])
  end

end
