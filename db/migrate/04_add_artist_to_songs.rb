class AddArtistToSongs < ActiveRecord::Migration
  def change
    change_table :songs do |t|
      t.integer :genre_id
      t.integer :artist_id
    end
  end
end
