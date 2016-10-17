class Song < ActiveRecord::Base


  belongs_to :artist
  belongs_to :genre

  def build_genre(attributes)
      new_genre = Genre.create(attributes)
      self.genre = new_genre
      new_genre
  end


  
end
