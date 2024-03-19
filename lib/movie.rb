class Movie
  attr_reader :title

  def initialize(title:)
    @title = title.squeeze.strip.capitalize
    @genres = []
    @shows = {}
  end
end
