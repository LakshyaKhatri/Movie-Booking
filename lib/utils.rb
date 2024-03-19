require 'json'

module Utils
  genres_data = File.open(File.join(File.dirname(__FILE__), 'data/genres.json'))
  ALL_GENRES = Set.new(JSON.load(genres_data)).freeze
end
