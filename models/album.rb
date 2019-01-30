class Album

  attr_reader :id, :artist_id
  attr_accessor :title, :genre

  def initialize( options )
    @id = options['id'] if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id']
  end

  def artist
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    results = Sql_Runner.run( sql,values )
    return results.map{| artist | Artist.new(artist)}
  end

  def save
    sql= "INSERT INTO albums
    (
    title,
    genre,
    artist_id
    )
    VALUES
    (
    $1,
    $2,
    $3
    )
    RETURNING *"
    values = [@title,@genre,@artist_id]
    result = Sql_Runner.run(sql,values)
    @id = result[0]['id'].to_i
  end

  def update
    sql = "UPDATE albums SET (title,genre) = ($1,$2) WHERE id = $3"
    values = [@title,@genre,@id]
    Sql_Runner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM albums where id = $1"
    values = [@id]
    Sql_Runner.run(sql,values)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    results = Sql_Runner.run(sql)
    return results.map{|album| Album.new(album)}
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    result = Sql_Runner.run(sql,values)
    return Album.new(result[0])
  end

end
