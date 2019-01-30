require_relative("../models/artist.rb")
require_relative("../models/album.rb")
require('pry')


artist_1_details ={
  'name' => "Alex"
}

artist_1 = Artist.new(artist_1_details)
artist_1.save()


album_1_details = {
  'title' => 'Best of',
  'genre' => 'Hip-Hop',
  'artist_id' => artist_1.id
}

album_1 = Album.new(album_1_details)
album_1.save()

all_artists = Artist.all()
all_albums = Album.all()
#
# all_albums.each do |album|
#   album.delete()
# end
#
# all_artists.each do |artist|
#   artist.delete()
# end

new_artist = Artist.find(29)
new_album = Album.find(29)

binding.pry
nil
