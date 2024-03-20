require 'json'

module Utils
  genres_file = File.join(File.dirname(__FILE__), 'data/genres.json')
  ALL_GENRES = Set.new(JSON.load_file(genres_file)).freeze
end
