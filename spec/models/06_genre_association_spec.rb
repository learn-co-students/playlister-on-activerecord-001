  describe 'Genre Associations' do
  before do
    @genre = Genre.create(name: "Hip Hop")
  end

  after do 
    clean_database
  end

  it 'has many songs' do
    @genre.songs << Song.create(name: "Something By That Person Who Sings Stuff")
    @genre.save

    found_song = Song.find_by(name: "Something By That Person Who Sings Stuff")
    expect(found_song.genre).to eq(@genre)
  end

  it 'is also associated with an artist' do
    artist = Artist.create(name: "Fun Person Who Sings")
    song = Song.create(name: "Sweet Tunez", genre: @genre)
    artist.songs << song
    artist.save

    expect(@genre.artists).to include(artist)
  end

  it 'has many artists' do
    artist1 = Artist.create(name: "Artist 1")
    artist2 = Artist.create(name: "Artist 2")
    song1 = Song.create(name: "Song1", genre: @genre, artist: artist1)
    song2 = Song.create(name: "Song2", genre: @genre, artist: artist2)
    expect(@genre.artists.all.size) == 2
  end

  it 'knows about its songs' do
    song = Song.create(name: "Milk", genre: @genre)
    expect(@genre.songs).to include(song)
  end

  
end

