class Movie
  attr_reader :title

  # Skipping the following tasks to prevent scope creep:
  # - multiple shows on same timestamp
  def initialize(title:)
    @title = title.squeeze.strip.capitalize
    @genres = []
    @shows = {}
  end

  def genres
    @genres.dup
  end

  def add_genre(genre)
    @genres << genre
  end

  def add_show(show_timing, rows, cols)
    show_timing = show_timing.upcase
    # TODO: create and add a show
  end

  def show_timings
    @shows.keys
  end
end
