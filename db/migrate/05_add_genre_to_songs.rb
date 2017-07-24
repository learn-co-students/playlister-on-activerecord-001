class AddGenreToSongs < ActiveRecord::Migration
  def change
    add_reference :songs, :genre, index: true
  end
end