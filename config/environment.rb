require 'bundler/setup'
Bundler.require

require 'active_record'
require 'rake'
require 'tk'

Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../lib/support", "*.rb")].each {|f| require f}

DBRegistry[ENV["PLAYLISTER_ENV"]].connect!
DB = ActiveRecord::Base.connection

if ENV["PLAYLISTER_ENV"] == "test"
  ActiveRecord::Migration.verbose = false
end

def migrate_db
  DB.tables.each do |table|
    DB.execute("DROP TABLE #{table}")
  end

  Dir[File.join(File.dirname(__FILE__), "../db/migrate", "*.rb")].each do |f| 
    require f
    migration = Kernel.const_get(f.split("/").last.split(".rb").first.gsub(/\d+/, "").split("_").collect{|w| w.strip.capitalize}.join())
    migration.migrate(:up)
  end
end

def drop_db
  DB.tables.each do |table|
    DB.execute("DROP TABLE #{table}")
  end
end

def seed_db
Artist.delete_all 
Song.delete_all 
Genre.delete_all 
genres = Genre.create([{name: "Rock"}, {name: "Pop"}, {name: "Rap"}])
artists = Artist.create([{name: "Michael Smith"}, {name: "Dolphin"}, {name: "Max Fry"}])
artists.each do |artist|
5.times do |i|
  song = Song.create(name: "song#{i}", genre: genres[rand(0..genres.size-1)], artist: artist)
  song.save
  end
 end

end